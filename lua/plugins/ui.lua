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
    cond = not vim.g.env_no_icon,
    opts_file = true,
  },
  -- 图标字体回退到ASCII
  {
    'echasnovski/mini.icons',
    cond = vim.g.env_no_icon,
    config = function()
      require 'mini.icons'.setup { style = 'ascii' }
      MiniIcons.mock_nvim_web_devicons()
    end,
  },

  -- 搜索提示
  { 'kevinhwang91/nvim-hlslens', config_file = true },

  -- 文件浏览器
  { 'nvim-tree/nvim-tree.lua', opts_file = true,
    cmd = { 'NvimTreeOpen', 'NvimTreeFindFile', 'NvimTreeFindFileToggle' } },

  -- 编辑目录
  { 'stevearc/oil.nvim', lazy = false, opts_file = true },

  -- QuickFix
  { 'stevearc/quicker.nvim', ft = 'qf', opts_file = true },
  { 'kevinhwang91/nvim-bqf', ft = 'qf', opts_file = true },

  -- Session
  { 'jedrzejboczar/possession.nvim', opts_file = true },

  -- 查询
  { 'lewis6991/hover.nvim', opts_file = true, lazy = true },
} }
