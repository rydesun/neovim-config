local cond = vim.g.plug_view
local event = 'VeryLazy'
local autoconfig = require 'lib'.autoconfig

return {
  -- 平滑滚动
  { 'karb94/neoscroll.nvim',
    cond = cond, event = event, config = autoconfig() },

  -- 缩进线
  { 'lukas-reineke/indent-blankline.nvim',
    cond = cond, config = autoconfig() },

  -- 检测缩进
  { 'nmac427/guess-indent.nvim',
    cond = cond, config = true },

  -- 空白符
  { 'ntpeters/vim-better-whitespace',
    cond = cond, init = autoconfig() },

  -- 折叠
  { 'kevinhwang91/nvim-ufo',
    cond = cond, event = event, config = autoconfig(),
    dependencies = { 'kevinhwang91/promise-async' } },

  -- 选区diff
  { 'AndrewRadev/linediff.vim',
    cond = cond, event = event, config = autoconfig() },

  -- 查看hex
  { 'fidian/hexmode',
    cond = cond },

  -- 翻译
  { 'voldikss/vim-translator',
    cond = cond, event = event },

  -- 显示颜色
  { 'NvChad/nvim-colorizer.lua',
    cond = cond, config = autoconfig() },
}
