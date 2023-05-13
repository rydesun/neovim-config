local M = {}

function M.git_branch()
  local head = vim.b.gitsigns_head
  return head == nil and ''
      or (head == 'master' or head == 'main') and '⋆'
      or ' ' .. head
end

function M.encoding()
  local fenc = vim.o.fenc
  return (fenc == 'utf-8' or fenc == '') and '' or '(' .. fenc .. ')'
end

M.filetype = require 'lualine.components.filetype':extend()

function M.filetype:update_status()
  local filetype = M.filetype.super:update_status()
  return filetype ~= '' and filetype or '-'
end

function M.filetype:apply_icon()
  local ok, devicons = pcall(require, 'nvim-web-devicons')
  if not ok then return nil end

  if self.status == '-' then
    self.status = '󰈙 -'
    return
  end

  local icon = devicons.get_icon_color_by_filetype(
    vim.bo.filetype, { default = false })
  if icon == nil then icon = '' end

  self.status = icon .. ' ' .. self.status
end

M.filename = require 'lualine.components.filename':extend()
local highlight = require 'lualine.highlight'

function M.filename:init(options)
  M.filename.super:init(options)
  self.status_colors = {
    cwd = highlight.create_component_highlight_group(
      -- TODO: 在配色主题中配置此处的颜色
      { fg = '#5f6d67' }, 'filename_cwd', self.options),
  }
end

function M.filename:update_status()
  local path = M.filename.super:update_status() -- 可能被压缩
  local full_path = vim.fn.expand('%:p')
  local parent = vim.fn.getcwd() .. '/'
  local home = vim.env.HOME
  home = home:sub(string.len(home)) == '/' and home or home .. '/'
  local short_parent = parent:gsub('^' .. home, '~/')

  local cwd_hl = highlight.component_format_highlight(self.status_colors.cwd)
  local file_hl = self:get_default_hl()

  if path == '' or full_path == nil then return cwd_hl .. short_parent end
  if full_path:find(parent, 1, true) ~= 1 then return file_hl .. path end

  local count_slash = 0
  for _ in short_parent:gmatch('/') do count_slash = count_slash + 1 end
  local splitter_idx = 0
  for i = 1, #path do
    splitter_idx = splitter_idx + 1
    local c = path:sub(i, i)
    if c == '/' then count_slash = count_slash - 1 end
    if count_slash == 0 then break end
  end
  local path_left = path:sub(1, splitter_idx)
  local path_right = path:sub(splitter_idx + 1)
  return cwd_hl .. path_left .. file_hl .. path_right
end

return M
