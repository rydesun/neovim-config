---@module 'gitsigns'

local M = require 'lualine.component':extend()

local default_options = {
  cursor = '·',
  window_edge_head = '(',
  window_edge_tail = ')',
  sign = { add = '+', change = '~', delete = '-' },
  enable_count = true,
}

local cached_gitsigns_hunks = {}

function M:init(options)
  M.super.init(self, options)
  self.options = vim.tbl_extend('keep', self.options or {}, default_options)

  vim.api.nvim_create_autocmd('User', {
    group = vim.api.nvim_create_augroup('lualine.gitsigns', { clear = true }),
    pattern = 'GitSignsUpdate',
    callback = function(args)
      local bufnr = args.data and args.data.buffer
      if not bufnr then return end
      local hunks = require 'gitsigns'.get_hunks(bufnr)
      if hunks and not vim.tbl_isempty(hunks) then
        local transformed_hunks = {}
        for _, hunk in ipairs(hunks) do
          transformed_hunks[#transformed_hunks+1] = self:transform(hunk)
        end
        cached_gitsigns_hunks[bufnr] = transformed_hunks
      else
        cached_gitsigns_hunks[bufnr] = nil
      end
    end,
  })
  local extract_hl = require 'lualine.utils.utils'.extract_color_from_hllist
  local fg_add = extract_hl('fg', { 'GitSignsAddNr' }, 'green')
  local fg_change = extract_hl('fg', { 'GitSignsChangeNr' }, 'blue')
  local fg_delete = extract_hl('fg', { 'GitSignsDeleteNr' }, 'red')
  local bg = extract_hl('fg', { 'NonText' }, 'grey')
  local color = {
    add = { fg = fg_add },
    change = { fg = fg_change },
    delete = { fg = fg_delete },
    add_with_cursor = { fg = fg_add, bg = bg },
    change_with_cursor = { fg = fg_change, bg = bg },
    delete_with_cursor = { fg = fg_delete, bg = bg },
    cursor = { fg = 'grey', bg = bg },
    edge = { fg = bg },
  }
  self.hl_groups = {
    add = self:format_hl(self:create_hl(color.add, 'add')),
    change = self:format_hl(self:create_hl(color.change, 'change')),
    delete = self:format_hl(self:create_hl(color.delete, 'delete')),
    add_with_cursor = self:format_hl(self:create_hl(color.add_with_cursor,
      'add_with_cursor')),
    change_with_cursor = self:format_hl(self:create_hl(color.change_with_cursor,
      'change_with_cursor')),
    delete_with_cursor = self:format_hl(self:create_hl(color.delete_with_cursor,
      'delete_with_cursor')),
    cursor = self:format_hl(self:create_hl(color.cursor, 'cursor')),
    edge = self:format_hl(self:create_hl(color.edge, 'edge')),
  }
  self.cursor = self.hl_groups.cursor .. self.options.cursor
  self.window_edge_head = self.hl_groups.edge .. self.options.window_edge_head
  self.window_edge_tail = self.hl_groups.edge .. self.options.window_edge_tail
end

function M:update_status()
  local bufnr = vim.api.nvim_win_get_buf(0)
  local hunks = cached_gitsigns_hunks[bufnr]
  if not hunks or vim.tbl_isempty(hunks) then return end

  local start_line = vim.fn.line 'w0'
  local end_line = vim.fn.line 'w$'
  local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
  local start_idx, end_idx, cursor_idx

  local ret = {}
  for idx, hunk in ipairs(hunks) do
    if not start_idx and hunk.tail >= start_line then
      start_idx = idx
      ret[#ret+1] = self.window_edge_head
    end
    if not cursor_idx and hunk.head > cursor_line then
      cursor_idx = idx
      ret[#ret+1] = self.cursor
    end
    if not end_idx and hunk.head > end_line then
      end_idx = idx
      ret[#ret+1] = self.window_edge_tail
    end
    if not cursor_idx and
        hunk.head <= cursor_line and hunk.tail >= cursor_line then
      ret[#ret+1] = hunk.hl_with_cursor .. hunk.sign ..
          (self.options.enable_count and hunk.count or '')
    else
      ret[#ret+1] = hunk.hl .. hunk.sign ..
          (self.options.enable_count and hunk.count or '')
    end
  end
  if not start_idx then ret[#ret+1] = self.window_edge_head end
  if not cursor_idx then ret[#ret+1] = self.cursor end
  if not end_idx then ret[#ret+1] = self.window_edge_tail end

  return table.concat(ret, '')
end

---@param hunk Gitsigns.Hunk.Hunk
function M:transform(hunk)
  local ret = {}
  local type = hunk.type
  if type == 'add' then
    ret.head = hunk.added.start
    ret.tail = hunk.added.start + hunk.added.count - 1
    ret.count = hunk.added.count
    ret.sign = self.options.sign.add
    ret.hl = self.hl_groups.add
    ret.hl_with_cursor = self.hl_groups.add_with_cursor
  elseif type == 'change' then
    ret.head = hunk.added.start
    ret.tail = hunk.added.start + hunk.added.count - 1
    ret.count = hunk.added.count
    ret.sign = self.options.sign.change
    ret.hl = self.hl_groups.change
    ret.hl_with_cursor = self.hl_groups.change_with_cursor
  elseif type == 'delete' then
    if hunk.added.start == 0 then
      ret.head, ret.tail = 1, 1
    else
      ret.head, ret.tail = hunk.added.start, hunk.added.start
    end
    ret.count = hunk.removed.count
    ret.sign = self.options.sign.delete
    ret.hl = self.hl_groups.delete
    ret.hl_with_cursor = self.hl_groups.delete_with_cursor
  end
  return ret
end

return M
