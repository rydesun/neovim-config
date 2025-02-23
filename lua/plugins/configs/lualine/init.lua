local components = require 'plugins.configs.lualine.components'
local extensions = require 'plugins.configs.lualine.extensions'
local blob_color = require 'plugins.configs.lualine.lib'.blob_color

local winbar = {
  lualine_a = { { components.filetype, color = blob_color } },
  lualine_b = { {
    components.filename,
    path = 1,
    file_status = false,
    cond = function() return vim.bo.buftype ~= 'nofile' end,
    symbols = { unnamed = '' },
  } },
  lualine_c = {
    { function() return vim.bo.modified and '󰆓' or '' end },
    { function() return vim.bo.readonly and '󰍶' or '' end },
  },
  lualine_x = {
    components.encoding,
    {
      'fileformat',
      symbols = { unix = '', dos = '[dos]', mac = '[mac]' },
      padding = { left = 0, right = 1 },
    },
    {
      'diagnostics',
      symbols = { error = '● ', warn = '▲ ', info = '■ ', hint = '■ ' },
    },
    { '%2l/%L', cond = function() return vim.fn.line '$' > 1 end },
  },
  lualine_y = { 'progress' },
  lualine_z = {},
}

return {
  options = {
    component_separators = '',
    section_separators = '',
  },
  winbar = winbar,
  inactive_winbar = winbar,
  sections = {
    lualine_a = { components.git_branch },
    lualine_b = { components.cwd },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },

  extensions = {
    extensions.man,
    extensions.nvim_tree,
    extensions.quickfix,
    extensions.termcat,
    extensions.toggleterm,
    'lazy',
  },
}
