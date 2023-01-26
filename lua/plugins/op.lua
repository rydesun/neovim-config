local cond = vim.g.plug_op
local event = 'VeryLazy'
local autoconfig = require 'lib'.autoconfig

return {
  -- 增强%
  { 'andymass/vim-matchup',
    cond = cond, event = event, config = autoconfig() },

  -- 增强[
  { 'tpope/vim-unimpaired',
    cond = cond, event = event },

  -- 移动光标
  { 'ggandor/leap.nvim',
    cond = cond, event = event },

  -- 多重光标
  { 'mg979/vim-visual-multi',
    cond = cond, event = event },

  -- 成对符号
  { 'machakann/vim-sandwich',
    cond = cond, event = event },

  -- 缩进对象
  { 'urxvtcd/vim-indent-object',
    cond = cond, event = event },

  -- 快速注释
  { 'numToStr/Comment.nvim',
    cond = cond, event = event, config = true },

  -- 表格对齐
  { 'junegunn/vim-easy-align',
    cond = cond, event = event },

  -- 切换单词
  { 'monaqa/dial.nvim',
    cond = cond, event = event, config = autoconfig() },

  -- 补全
  { 'hrsh7th/nvim-cmp',
    cond = cond, event = event, config = autoconfig(),
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'saadparwaiz1/cmp_luasnip',
      { 'L3MON4D3/LuaSnip',
        config = autoconfig 'luasnip' },
    } },

  -- 自动匹配
  { 'windwp/nvim-autopairs',
    cond = cond, event = event, config = autoconfig(),
    -- 与补全插件集成
    dependencies = { 'nvim-cmp' } },

  -- 撤销历史
  { 'mbbill/undotree',
    cond = cond, event = event, config = autoconfig() },

  -- 编辑颜色
  { 'uga-rosa/ccc.nvim',
    cond = cond, event = event },

  -- Tim Pope's dot.
  { 'tpope/vim-repeat',
    cond = cond, event = event },
}