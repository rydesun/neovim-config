local cond = vim.g.plug_op
return require 'libs.lazy-helper' { cond = cond, very_lazy = true, spec = {
  -- 增强复制粘贴：存储复制内容
  { 'gbprod/yanky.nvim', opts_file = true,
    dependencies = 'kkharji/sqlite.lua' },

  -- 增强%
  { 'andymass/vim-matchup', lazy = false, config_file = true },

  -- 增强[
  { 'echasnovski/mini.bracketed', opts = {
    indent  = { suffix = '' }, -- snacks.scope
    window  = { suffix = '' }, -- document_highlight
    oldfile = { suffix = '' }, -- toggle options
    undo    = { suffix = '' }, -- vim-repeat
  } },

  -- 增强gu (gu -> gul, guu -> Vgul)
  { 'johmsalas/text-case.nvim', opts = { prefix = 'gu' },
    keys = { { 'gu', mode = { 'n', 'v' } } }, cmd = 'Subs' },

  -- 替换
  { 'echasnovski/mini.operators', opts = {
    evaluate = { prefix = 's=' }, exchange = { prefix = 'sx' },
    sort = { prefix = 's<' },
    multiply = { prefix = '' }, replace = { prefix = '' } } },

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
  { 'echasnovski/mini.align', config = true,
    keys = {
      { 'ga', mode = { 'n', 'v' } },
      { 'gA', mode = { 'n', 'v' } },
    } },

  -- 切换单词
  { 'monaqa/dial.nvim', config_file = true,
    keys = {
      { '<c-a>', mode = { 'n', 'v' } },
      { '<c-x>', mode = { 'n', 'v' } },
      { 'g<c-a>', mode = { 'n', 'v' } },
      { 'g<c-x>', mode = { 'n', 'v' } },
    } },

  -- 补全
  { 'saghen/blink.cmp', version = '1.*', opts_file = 'blink-cmp' },
  { 'mikavilpas/blink-ripgrep.nvim', lazy = true },

  -- 输入闭合符号
  { 'altermo/ultimate-autopair.nvim', branch = 'v0.6', config = true },

  -- 编辑颜色
  { 'max397574/colortils.nvim', cmd = 'Colortils', config = true },

  -- Tim Pope's dot.
  { 'tpope/vim-repeat' },
} }
