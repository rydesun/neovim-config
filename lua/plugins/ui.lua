-- 先占位，插件启动后让插件设置状态栏
vim.o.statusline = ' '
vim.o.winbar = ' '
-- 不在右下角提示搜索
vim.opt.shortmess:append 'sS'

local cond = vim.g.plug_ui
return require 'libs.lazy-helper' { cond = cond, very_lazy = true, spec = {
  { 'folke/snacks.nvim', lazy = false, priority = 1000, opts_file = true },

  -- 配色主题
  { 'sainnhe/everforest', lazy = false, priority = 1000, config_file = true },

  -- 状态栏
  { 'nvim-lualine/lualine.nvim', opts_file = true },

  -- cmdline
  {
    'folke/noice.nvim',
    lazy = false,
    opts_file = true,
    dependencies = {
      'MunifTanjim/nui.nvim',
      {
        'rcarriga/nvim-notify',
        opts = { render = 'wrapped-compact', stages = 'fade' },
      },
    },
  },

  -- 图标字体
  {
    'nvim-tree/nvim-web-devicons',
    cond = not vim.g.env_console,
    opts_file = true,
  },
  -- 图标字体回退(仅在virtual console中生效)
  {
    'echasnovski/mini.icons',
    cond = vim.g.env_console,
    config = function()
      require 'mini.icons'.setup { style = 'ascii' }
      MiniIcons.mock_nvim_web_devicons()
    end,
  },

  -- 搜索提示
  { 'kevinhwang91/nvim-hlslens', config_file = true },

  -- 文件浏览器
  { 'nvim-tree/nvim-tree.lua', opts_file = true },

  -- 编辑目录
  { 'stevearc/oil.nvim', lazy = false, opts_file = true },

  -- 改进quickfix
  { 'stevearc/quicker.nvim', ft = 'qf', opts_file = true },
  { 'kevinhwang91/nvim-bqf', ft = 'qf', opts_file = true },
} }
