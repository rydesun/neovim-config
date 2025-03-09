return require 'libs.lazy'.setdefault(vim.g.plug_cmd, 'VeryLazy', {
  -- 异步执行
  { 'skywind3000/asyncrun.vim' },

  -- 任务系统
  { 'skywind3000/asynctasks.vim', config_file = true },

  -- 终端窗口
  { 'akinsho/toggleterm.nvim', version = '*', opts_file = true },

  -- 集成Git
  { 'lewis6991/gitsigns.nvim', opts_file = true },
  { 'sindrets/diffview.nvim', opts_file = true },
  { 'NeogitOrg/neogit', opts_file = true },

  -- 切换输入法
  {
    'lilydjwg/fcitx.vim',
    enabled = vim.fn.executable('fcitx5') > 0,
    -- 不用dbus-python
    init = function() vim.g.fcitx5_remote = 'fcitx5-remote' end,
  },

  -- 查看JSON
  {
    'gennaro-tedesco/nvim-jqx',
    enabled = vim.fn.executable('jq') > 0,
    ft = { 'json', 'yaml' },
  },

  -- Obsidian笔记
  {
    'obsidian-nvim/obsidian.nvim',
    enabled = vim.fn.executable('obsidian') > 0,
    ft = 'markdown',
    opts_file = true,
  },

  -- kitty配置文件的语法高亮
  {
    'fladson/vim-kitty',
    enabled = vim.fn.executable('kitty') > 0,
    lazy = false,
  },

  -- 检查启动时间
  { 'dstein64/vim-startuptime' },
})
