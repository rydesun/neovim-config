local components = require 'plugins.configs.lualine.components'
local extensions = require 'plugins.configs.lualine.extensions'
local ft_color_blob = require 'plugins.configs.lualine.lib'.ft_color_blob

local winbar = {
  lualine_a = { { components.filetype, color = ft_color_blob } },
  lualine_b = { {
    components.filename,
    path = 1,
    cond = function() return vim.bo.buftype ~= 'nofile' end,
    symbols = { modified = '*', readonly = '!', unnamed = '' },
  } },
  lualine_c = { { require 'plugins.configs.lualine.components.gitsigns-bar' } },
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
      cond = function () return #vim.diagnostic.count(0) > 0 end
    },
    { '%2l/%L', cond = function() return vim.fn.line '$' > 1 end },
  },
  lualine_y = { 'progress' },
  lualine_z = {},
}

local opts = {
  options = {
    -- 只显示一个窗口的状态栏
    globalstatus = true,
    disabled_filetypes = {
      winbar = { 'dap-view', 'dap-repl', 'dbee', 'snacks_layout_box' },
    },
    component_separators = '',
    section_separators = '',
  },
  winbar = winbar,
  inactive_winbar = winbar,
  sections = {
    lualine_a = { components.git_branch },
    lualine_b = { components.cwd },
    lualine_c = {},
    lualine_x = { require 'plugins.configs.lualine.components.molten' },
    lualine_y = {
      {
        function() return require 'noice'.api.status.command.get() end,
        cond = function()
          local ok, noice = pcall(require, 'noice')
          if not ok then return end
          local mode = vim.fn.mode()
          return (mode == 'v' or mode == 'V' or mode == '\22') and
              noice.api.status.command.has()
        end,
      },
    },
    lualine_z = {
      {
        function() return require 'noice'.api.status.mode.get() end,
        cond = function()
          local ok, noice = pcall(require, 'noice')
          if not ok then return end
          return noice.api.status.mode.has()
        end,
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

if Snacks then
  table.insert(opts.sections.lualine_x, Snacks.profiler.status())
end

return opts
