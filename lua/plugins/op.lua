return require 'libs.lazy'.setdefault(vim.g.plug_op, 'VeryLazy', {
  -- 增强%
  { 'andymass/vim-matchup', nolazy = true, config_file = true },

  -- 增强[
  { 'tpope/vim-unimpaired' },

  -- 移动光标
  { 'ggandor/leap.nvim' },

  -- 增强f和t
  { 'ggandor/flit.nvim', opts_file = true, dependencies = 'leap.nvim' },

  -- 远距离操作文本对象
  { 'ggandor/leap-spooky.nvim', opts_file = true, dependencies = 'leap.nvim' },

  -- 增加a和i的文本对象
  {
    'echasnovski/mini.ai',
    version = '*',
    config = function() require 'mini.ai'.setup() end,
  },

  -- 更多的文本对象
  { 'chrisgrieser/nvim-various-textobjs', config = true },

  -- 多重光标
  { 'mg979/vim-visual-multi' },

  -- 成对符号
  { 'machakann/vim-sandwich' },

  -- 快速注释
  { 'numToStr/Comment.nvim', config = true },

  -- 表格对齐
  { 'junegunn/vim-easy-align' },

  -- 切换单词
  { 'monaqa/dial.nvim', config_file = true },

  -- 补全
  {
    'hrsh7th/nvim-cmp',
    config_file = true,
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'saadparwaiz1/cmp_luasnip',
      { 'L3MON4D3/LuaSnip', opts_file = 'luasnip' },
    }
  },

  -- 自动匹配
  {
    'windwp/nvim-autopairs',
    config_file = true,
    -- 与补全插件集成
    dependencies = 'nvim-cmp',
  },

  -- 撤销历史
  { 'mbbill/undotree', config_file = true },

  -- 编辑颜色
  { 'uga-rosa/ccc.nvim' },

  -- Tim Pope's dot.
  { 'tpope/vim-repeat' },
})
