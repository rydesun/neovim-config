return require 'libs.lazy'.setdefault(vim.g.plug_ui, 'VeryLazy', {
  -- 配色主题
  { 'sainnhe/everforest', nolazy = true, config_file = true },

  -- 状态栏
  { 'nvim-lualine/lualine.nvim', opts_file = true },

  -- 图标字体
  { 'nvim-tree/nvim-web-devicons', lazy = true, opts_file = true },

  -- 图标回退到圆圈
  {
    'projekt0n/circles.nvim',
    -- 仅在virtual console中生效
    cond = vim.g.env_console,
    -- 在console中也能显示的圆圈
    opts = { icons = { empty = '•', filled = '○', lsp_prefix = '◙' } },
    priority = 1,
    dependencies = 'nvim-tree/nvim-web-devicons',
  },

  -- 浮动通知
  { 'rcarriga/nvim-notify', config_file = true },

  -- 搜索提示
  { 'kevinhwang91/nvim-hlslens', config_file = true },

  -- 文件浏览器
  { 'nvim-tree/nvim-tree.lua', opts_file = true },

  -- 编辑目录
  { 'stevearc/oil.nvim', nolazy = true, opts_file = true },

  -- 改进quickfix
  { 'kevinhwang91/nvim-bqf' },

  -- 查找
  {
    'nvim-telescope/telescope.nvim',
    config_file = true,
    dependencies = {
      -- 搜索支持fzf语法
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      -- 补全符号
      'nvim-telescope/telescope-symbols.nvim',
      -- 管理yank
      'AckslD/nvim-neoclip.lua',
    },
  },

  -- 自定义界面
  { 'stevearc/dressing.nvim', opts_file = true },

  -- 保持窗口布局
  { 'famiu/bufdelete.nvim' },
})
