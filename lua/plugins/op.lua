local cond = vim.g.plug_op
return require 'libs.lazy-helper' { cond = cond, very_lazy = true, spec = {
  -- 增强%
  { 'andymass/vim-matchup', lazy = false, config_file = true },

  -- 增强[
  { 'tpope/vim-unimpaired' },

  -- 移动光标
  { 'ggandor/leap.nvim', opts_file = true },
  { 'ggandor/flit.nvim', opts_file = true, dependencies = 'leap.nvim' },

  -- 增加a和i的文本对象
  { 'echasnovski/mini.ai', opts_file = 'mini-ai' },

  -- 更多的文本对象
  { 'chrisgrieser/nvim-various-textobjs', config = true },

  -- 多重光标
  { 'mg979/vim-visual-multi' },

  -- 成对符号
  { 'machakann/vim-sandwich' },

  -- 快速注释
  { 'numToStr/Comment.nvim', opts_file = true },

  -- 表格对齐
  { 'echasnovski/mini.align', config = true },

  -- 切换单词
  { 'monaqa/dial.nvim', config_file = true },

  -- 补全
  { 'saghen/blink.cmp', version = '1.*', opts_file = 'blink-cmp' },
  { 'mikavilpas/blink-ripgrep.nvim', lazy = true },

  -- snippets
  { 'L3MON4D3/LuaSnip', opts_file = 'luasnip', version = 'v2.*' },

  -- 输入闭合符号
  { 'altermo/ultimate-autopair.nvim', branch = 'v0.6', config = true },

  -- 编辑颜色
  { 'max397574/colortils.nvim', cmd = 'Colortils', config = true },

  -- Tim Pope's dot.
  { 'tpope/vim-repeat' },
} }
