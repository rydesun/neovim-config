local spec_op_motion = require 'libs.lazy-helper' { cond = vim.g.plug_op_motion,
  very_lazy = true, spec = {
  -- 增强y：保持光标、存储复制内容
  -- 增强p：切换粘贴内容
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

  -- 移动光标
  { 'ggandor/leap.nvim', opts_file = true },
  -- 增强f和t
  { 'ggandor/flit.nvim', opts_file = true, dependencies = 'leap.nvim' },

  -- 文本对象
  { 'echasnovski/mini.ai', opts_file = 'mini-ai' },
  { 'chrisgrieser/nvim-various-textobjs', config = true },
} }

local spec_op_edit = require 'libs.lazy-helper' { cond = vim.g.plug_op_edit,
  very_lazy = true, spec = {
  -- 增强gu (gu -> gul, guu -> Vgul)
  { 'johmsalas/text-case.nvim', opts = { prefix = 'gu' },
    keys = { { 'gu', mode = { 'n', 'v' } } }, cmd = 'Subs' },

  -- 替换：选中
  { 'echasnovski/mini.operators', opts = {
    evaluate = { prefix = 's=' }, exchange = { prefix = 'sx' },
    sort = { prefix = 's<' },
    multiply = { prefix = '' }, replace = { prefix = '' } } },

  -- 替换：多重光标
  { 'mg979/vim-visual-multi' },

  -- 替换：用ripgrep搜索
  { 'MagicDuck/grug-far.nvim', config = true,
    cmd = { 'GrugFar', 'GrugFarWithin' } },
  { 'chrisgrieser/nvim-rip-substitute', opts_file = true,
    lazy = true, cmd = 'RipSubstitute' },

  -- 修改配对符号
  { 'machakann/vim-sandwich' },

  -- 表格对齐
  { 'echasnovski/mini.align', config = true,
    keys = { { 'ga', mode = { 'n', 'v' } }, { 'gA', mode = { 'n', 'v' } } } },

  -- 切换注释
  { 'numToStr/Comment.nvim', opts_file = true },

  -- 切换单词
  { 'monaqa/dial.nvim', config_file = true,
    keys = {
      { '<c-a>', mode = { 'n', 'v' } }, { 'g<c-a>', mode = { 'n', 'v' } },
      { '<c-x>', mode = { 'n', 'v' } }, { 'g<c-x>', mode = { 'n', 'v' } },
    } },

  -- 检测缩进
  { 'nmac427/guess-indent.nvim', lazy = false, config = true },

  -- 编辑颜色
  { 'max397574/colortils.nvim', cmd = 'Colortils', config = true },

  -- Tim Pope's dot.
  { 'tpope/vim-repeat' },

  -- 输入模式：补全
  { 'saghen/blink.cmp', version = '1.*', opts_file = 'blink-cmp' },
  { 'mikavilpas/blink-ripgrep.nvim', lazy = true },
  { 'altermo/ultimate-autopair.nvim', branch = 'v0.6', config = true },
} }

return vim.list_extend(spec_op_motion, spec_op_edit)
