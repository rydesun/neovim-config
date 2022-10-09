local function git_branch()
  local head = vim.b.gitsigns_head
  return (head == nil or head == '') and ''
      or (head == 'master' or head == 'main') and ''
      or ' ' .. head
end

local function git_file_status()
  local status = vim.b.gitsigns_status
  return (status == nil or status == '') and '' or ''
end

local function encoding()
  local fenc = vim.o.fenc
  return fenc == 'utf-8' and '' or fenc
end

local filename = require 'lualine.components.filename':extend()
local highlight = require 'lualine.highlight'

function filename:init(options)
  filename.super:init(options)
  self.status_colors = {
    cwd = highlight.create_component_highlight_group(
      { fg = '#5f6d67' }, 'filename_cwd', self.options),
  }
end

function filename:update_status()
  local path = filename.super:update_status() -- 可能被压缩
  local full_path = vim.fn.expand('%:p')
  local parent = vim.fn.getcwd() .. '/'
  local home = vim.env.HOME
  home = home:sub(string.len(home)) == '/' and home or home .. '/'
  local short_parent = parent:gsub('^' .. home, '~/')
  local parent_hi = highlight.component_format_highlight(self.status_colors.cwd)
  local default_hi = self:get_default_hl()
  if path == '' or full_path == nil then
    return parent_hi .. short_parent .. default_hi
  end
  if full_path:find(parent, 1, true) ~= 1 then return path end

  local count_slash = 0
  for _ in short_parent:gmatch('/') do count_slash = count_slash + 1 end
  local splitter_idx = 0
  for i = 1, #path do
    splitter_idx = splitter_idx + 1
    local c = path:sub(i, i)
    if c == '/' then count_slash = count_slash - 1 end
    if count_slash == 0 then break end
  end
  local path_left = parent_hi .. path:sub(1, splitter_idx) .. default_hi
  local path_right = path:sub(splitter_idx + 1)
  return path_left .. path_right
end

local transform_color = require 'lib'.transform_color(0.3, 30)

require 'lualine'.setup {
  options = {
    theme = 'everforest',
    section_separators = { left = '', right = '' },
    component_separators = '',
  },
  sections = {
    lualine_a = {
      { '%L/%-2l', padding = { left = 1, right = 0 } },
    },
    lualine_b = {
      { git_branch, padding = { left = 1, right = 0 } },
      git_file_status,
    },
    lualine_c = {
      { 'fileformat', symbols = { unix = '' }, padding = { left = 1, right = 0 } },
      { filename, path = 3,
        symbols = { modified = '  ', readonly = '', unnamed = '' } },
    },
    lualine_x = { encoding },
    lualine_y = {
      { 'diagnostics',
        diagnostics_color = {
          error = 'DiagnosticFloatingError',
          warn  = 'DiagnosticFloatingWarn',
          info  = 'DiagnosticFloatingInfo',
          hint  = 'DiagnosticFloatingHint',
        },
      },
    },
    lualine_z = {
      { 'filetype', icons_enabled = false,
        color = function()
          local ok, devicons = pcall(require, 'nvim-web-devicons')
          if not ok then return {} end
          local f_name, f_ext = vim.fn.expand('%:t'), vim.fn.expand('%:e')
          local _, icon_highlight_group = devicons.get_icon(f_name, f_ext)
          local hl_color = require 'lualine.utils.utils'.extract_highlight_colors(
            icon_highlight_group, 'fg')
          if not hl_color then return {} end
          return { bg = transform_color(hl_color) }
        end,
      },
    },
  },
  extensions = { 'aerial', 'man', 'nvim-tree', 'quickfix', 'toggleterm' },
}
