local cond = vim.g.plug_cmd
local event = 'VeryLazy'
local autoconfig = require 'lib'.autoconfig

return {
  -- 异步执行
  { 'skywind3000/asyncrun.vim',
    cond = cond, event = event },

  -- 任务系统
  { 'skywind3000/asynctasks.vim',
    cond = cond, event = event, config = autoconfig() },

  -- 终端窗口
  { 'akinsho/toggleterm.nvim', version = '*',
    cond = cond, event = event, config = autoconfig() },

  -- 集成Git
  { 'lewis6991/gitsigns.nvim',
    cond = cond, event = event, config = autoconfig() },

  -- Git diff
  { 'sindrets/diffview.nvim',
    cond = cond, event = event },

  -- 切换输入法
  { 'lilydjwg/fcitx.vim',
    enabled = vim.fn.executable('fcitx5-remote') > 0,
    cond = cond, event = event,
    init = function() vim.g.fcitx5_remote = 'fcitx5-remote' end },

  -- kitty配置文件的语法高亮
  { 'fladson/vim-kitty',
    enabled = vim.fn.executable('kitty') > 0,
    cond = cond },

  -- tridactyl配置文件的语法高亮
  { 'tridactyl/vim-tridactyl',
    enabled = vim.fn.executable('firefox') > 0,
    cond = cond },

  -- 检查启动时间
  { 'dstein64/vim-startuptime',
    cond = cond, event = event },
}