local function git_branch()
  local head = vim.b.gitsigns_head
  if head == nil or head == '' then
    return ''
  elseif head == 'master' or head == 'main' then
    return ''
  else
    return ' '..head
  end
end

local function git_diff()
  local status = vim.b.gitsigns_status
  if status == nil or status == '' then
    return ''
  else
    return ''
  end
end

local function encoding()
  local fenc = vim.o.fenc
  return fenc == 'utf-8' and '' or fenc
end

local filename = require('lualine.components.filename'):extend()
local highlight = require'lualine.highlight'

function filename:init(options)
  filename.super.init(self, options)
  self.status_colors = {
    cwd = highlight.create_component_highlight_group(
      {fg = '#5f6d67'}, 'filename_cwd', self.options),
  }
end

function filename:update_status()
  local default_highlight = self:get_default_hl()
  local path = filename.super.update_status(self)
  local parent = vim.fn.getcwd() .. '/'
  parent = parent:gsub('^'..vim.env.HOME, '~/')
  if path == '' then
    return highlight.component_format_highlight(
      self.status_colors.cwd) .. parent .. default_highlight
  elseif path:find(parent, 1, true) == 1 then
    local path_left = highlight.component_format_highlight(
      self.status_colors.cwd) .. parent .. default_highlight
    local path_right = path:sub(#parent+1)
    path =  path_left .. path_right
  end
  return path
end

local transform_color = require('lib').transform_color(0.3, 30)

require'lualine'.setup {
  options = {
    theme = 'everforest',
    section_separators = {left = '', right = ''},
    component_separators = '',
  },
  sections = {
    lualine_a = {
      {'%L/%-2l', padding = {left = 1, right = 0}},
    },
    lualine_b = {
      {git_branch, padding = {left = 1, right = 0}},
      git_diff,
    },
    lualine_c = {
      {'fileformat', symbols = {unix = ''}, padding = {left = 1, right = 0}},
      {filename,
        path = 3, symbols = {modified = '  ', readonly = ' ', unnamed = ''}},
    },
    lualine_x = {encoding},
    lualine_y = {'diagnostics'},
    lualine_z = {
      {'filetype', icons_enabled = false,
        color = function()
          local ok, devicons = pcall(require, 'nvim-web-devicons')
          if not ok then
            return {}
          end
          local f_name, f_ext = vim.fn.expand('%:t'), vim.fn.expand('%:e')
          local _, icon_highlight_group = devicons.get_icon(f_name, f_ext)
          local hl_color = require'lualine.utils.utils'.
            extract_highlight_colors(icon_highlight_group, 'fg')
          if not hl_color then
            return {}
          end
          return { bg = transform_color(hl_color) }
        end,
    },
    },
  },
  extensions = {'aerial', 'nvim-tree', 'quickfix'},
}
