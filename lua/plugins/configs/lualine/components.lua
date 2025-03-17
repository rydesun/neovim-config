local M = {}

function M.git_branch()
  local head = vim.b.gitsigns_head
  return head == nil and ''
      or (head == 'master' or head == 'main') and ' '
      or '  ' .. head
end

function M.encoding()
  local fenc = vim.o.fenc
  return (fenc == 'utf-8' or fenc == '') and '' or '[' .. fenc .. ']'
end

function M.cwd()
  return vim.fn.fnamemodify(vim.fn.getcwd(), ':~')
end

M.filetype = require 'lualine.components.filetype':extend()

function M.filetype:init(options)
  M.filetype.super:init(options)
  self.options = vim.tbl_deep_extend('keep', self.options or {}, {
    terminal = '',
    unknown = '󰡯',
    unset = ' ',
  })
end

function M.filetype:update_status()
  local filetype = self.super:update_status()
  return filetype ~= '' and filetype or '-'
end

function M.filetype:apply_icon()
  local ok, devicons = pcall(require, 'nvim-web-devicons')
  if not ok then return nil end

  if self.status == '-' then
    if vim.bo.buftype == 'terminal' then
      self.status = self.options.terminal
    else
      self.status = self.options.unset
    end
    return
  end

  local icon = devicons.get_icon_color_by_filetype(
    vim.bo.filetype, { default = false })
  if icon == nil then
    icon = vim.bo.buftype == 'nofile' and '' or self.options.unknown
  end
  if icon ~= '' then
    self.status = icon .. ' ' .. self.status
  end
end

M.filename = require 'lualine.components.filename':extend()

function M.filename:init(options)
  M.filename.super:init(options)

  -- 必须禁掉原方法中的symbols，防止update_status返回重复的symbols
  self.options.file_status = false

  self.options = vim.tbl_deep_extend('keep', self.options or {},
    {
      hl_main = '%#deniteStatusLinePath#',
      hl_hint = '%#deniteInput#',
      hl_warn = '%#deniteStatusLineNumber#',
    }
  )
end

function M.filename:update_status()
  local symbols = ''
  if vim.bo.modified then
    symbols = symbols .. self.options.hl_hint .. self.options.symbols.modified
  end
  if vim.bo.modifiable == false or vim.bo.readonly == true then
    symbols = symbols .. self.options.hl_warn .. self.options.symbols.readonly
  end

  local compact_path = M.filename.super:update_status()
  -- unnamed buffer
  if compact_path == '' then return symbols end

  local raw_path = vim.fn.expand '%:p:~'
  local path = ''
  -- 如果是URL
  local protocol = raw_path:match '^[%w-]+://'
  if protocol then
    local rest = compact_path:match '^[^/]+//(.*)'
    path = protocol .. self.options.hl_main .. rest
  else
    local split_idx = compact_path:match '.*()/'
    if split_idx then
      local compact_path_left = compact_path:sub(1, split_idx)
      local compact_path_right = compact_path:sub(split_idx + 1)
      path = compact_path_left .. self.options.hl_main .. compact_path_right
    else
      path = self.options.hl_main .. compact_path
    end
  end

  if symbols == '' then return path else return path .. ' ' .. symbols end
end

return M
