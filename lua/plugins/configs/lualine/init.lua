local components = require 'plugins.configs.lualine.components'
local extensions = require 'plugins.configs.lualine.extensions'
local blob_color = require 'plugins.configs.lualine.lib'.blob_color

local winbar = {
  lualine_a = { { components.filetype, color = blob_color } },
  lualine_b = { {
    components.filename,
    path = 1,
    file_status = true,
    cond = function() return vim.bo.buftype ~= 'nofile' end,
    symbols = { modified = '*', readonly = '!', unnamed = '' },
  } },
  lualine_c = {},
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
    -- 只显示一个窗口的状态栏
    globalstatus = true,

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
    lualine_y = {
      {
        require 'noice'.api.status.command.get,
        cond = function()
          local mode = vim.fn.mode()
          return (mode == 'v' or mode == 'V' or mode == '\22') and
              require 'noice'.api.status.command.has()
        end,
      },
    },
    lualine_z = {
      {
        require 'noice'.api.status.mode.get,
        cond = require 'noice'.api.status.mode.has,
      },
    },
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
