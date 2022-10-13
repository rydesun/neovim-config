local components = require 'plugin-configs.lualine.components'
local extensions = require 'plugin-configs.lualine.extensions'
local transform_color = require 'lib'.transform_color(0.3, 30)

require 'lualine'.setup {
  options = {
    section_separators = { left = '', right = '' },
    component_separators = '',
  },
  sections = {
    lualine_a = {
      { '%L-%-2l', padding = { left = 1, right = 0 } },
    },
    lualine_b = {
      { components.git_branch, padding = { left = 1, right = 0 } },
      { components.git_file_status, padding = 0 },
    },
    lualine_c = {
      { 'fileformat', symbols = { unix = '' }, padding = { left = 1, right = 0 } },
      { components.filename, path = 3,
        symbols = { modified = ' ', readonly = '', unnamed = '' } },
    },
    lualine_x = { components.encoding },
    lualine_y = {
      { 'diagnostics',
        symbols = { error = '● ', warn = '▲ ', info = '■ ', hint = '■ ' },
        diagnostics_color = {
          error = 'DiagnosticFloatingError',
          warn  = 'DiagnosticFloatingWarn',
          info  = 'DiagnosticFloatingInfo',
          hint  = 'DiagnosticFloatingHint',
        },
      },
    },
    lualine_z = {
      { 'filetype', padding = { left = 0, right = 1 },
        icons_enabled = true, colored = false,
        color = function()
          local color = require 'plugin-configs.lualine.lib'
              .filetype_color(transform_color)
          return color and { bg = color } or {}
        end,
      },
    },
  },
  extensions = { extensions.man, 'nvim-tree', 'quickfix', 'toggleterm' },
}
