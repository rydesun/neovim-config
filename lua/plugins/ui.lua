local cond = vim.g.plug_ui
local event = 'VeryLazy'
local autoconfig = require 'libs'.autoconfig

return {
  -- 配色主题
  { 'sainnhe/everforest',
    cond = cond, config = autoconfig() },

  -- 状态栏
  { 'nvim-lualine/lualine.nvim',
    cond = cond, opts = autoconfig() },

  -- 图标字体
  { 'nvim-tree/nvim-web-devicons',
    cond = cond, lazy = true },

  -- 浮动通知
  { 'rcarriga/nvim-notify',
    cond = cond, event = event, config = autoconfig() },

  -- 搜索提示
  { 'kevinhwang91/nvim-hlslens',
    cond = cond, event = event, config = autoconfig() },

  -- 文件浏览器
  { 'nvim-tree/nvim-tree.lua',
    cond = cond, event = event, opts = autoconfig() },

  -- 编辑目录
  { 'stevearc/oil.nvim',
    cond = cond, config = true },

  -- 改进quickfix
  { 'kevinhwang91/nvim-bqf',
    cond = cond, event = event },

  -- 查找
  { 'nvim-telescope/telescope.nvim',
    cond = cond, event = event, config = autoconfig(),
    dependencies = {
      -- 搜索支持fzf语法
      { 'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make' },
      -- 补全符号
      'nvim-telescope/telescope-symbols.nvim',
      -- 管理yank
      'AckslD/nvim-neoclip.lua',
    } },

  -- 自定义界面
  { 'stevearc/dressing.nvim',
    cond = cond, event = event, opts = autoconfig() },

  -- 保持窗口布局
  { 'famiu/bufdelete.nvim',
    cond = cond, event = event },
}
