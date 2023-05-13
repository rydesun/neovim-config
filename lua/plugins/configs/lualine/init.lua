local components = require 'plugins.configs.lualine.components'
local extensions = require 'plugins.configs.lualine.extensions'
local blob_color = require 'plugins.configs.lualine.lib'.blob_color

return {
  options = {
    component_separators = '',
    section_separators = '',
  },
  sections = {
    lualine_a = {
      { components.filetype,
        icons_enabled = true, colored = false,
        color = blob_color,
      },
    },
    lualine_b = {
      { components.git_branch },
    },
    lualine_c = {
      { components.encoding, padding = { left = 1, right = 0 } },
      { 'fileformat', padding = { left = 1, right = 0 },
        symbols = { unix = '', dos = '<DOS>', mac = '<CR>' },
      },
      { components.filename, path = 3,
        symbols = { modified = '󰆓 ', readonly = '󰍶 ', unnamed = '' } },
    },
    lualine_x = {
      { 'diagnostics',
        symbols = { error = '● ', warn = '▲ ', info = '■ ', hint = '■ ' },
      },
    },
    lualine_y = { { '%2l/%L' } },
    lualine_z = { {'progress', color = blob_color} },
  },
  extensions = { extensions.man, 'lazy', 'quickfix', 'toggleterm' },
}
