local components = require 'plugins.configs.lualine.components'
local extensions = require 'plugins.configs.lualine.extensions'
local blob_color = require 'plugins.configs.lualine.lib'.blob_color

return {
  options = {
    component_separators = '',
    section_separators = '',
  },
  sections = {
    lualine_a = { { components.filetype, color = blob_color } },
    lualine_b = { { components.git_branch } },
    lualine_c = {
      {
        components.filename,
        cond = function() return vim.bo.buftype ~= 'nofile' end,
        symbols = { modified = '󰆓 ', readonly = '󰍶 ', unnamed = '' }
      },
    },
    lualine_x = {
      { components.encoding, padding = { left = 0, right = 1 } },
      {
        'fileformat',
        symbols = { unix = '', dos = '(dos)', mac = '(mac)' },
        padding = { left = 0, right = 1 },
      },
      {
        'diagnostics',
        symbols = { error = '● ', warn = '▲ ', info = '■ ', hint = '■ ' },
      },
    },
    lualine_y = { { '%2l/%L' } },
    lualine_z = { { 'progress', color = blob_color } },
  },
  extensions = {
    extensions.aerial,
    extensions.diffview_files,
    extensions.diffview_file_history,
    extensions.man,
    extensions.nvim_tree,
    extensions.quickfix,
    extensions.telescope,
    extensions.termcat,
    'lazy',
    'toggleterm',
  },
}
