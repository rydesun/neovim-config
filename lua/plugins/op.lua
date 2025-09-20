local spec_op_motion = require 'libs.lazy-helper' { cond = vim.g.plug_op_motion,
  very_lazy = true, spec = {
  -- 增强y：保持光标、存储复制内容
  -- 增强p：切换粘贴内容
  { 'gbprod/yanky.nvim', opts_file = true,
    dependencies = 'kkharji/sqlite.lua' },

  -- 增强%
  { 'andymass/vim-matchup', init_file = true,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      opts = { matchup = { enable = true } } } },

  -- 增强[
  { 'nvim-mini/mini.bracketed', opts = {
    indent  = { suffix = '' }, -- snacks.scope
    window  = { suffix = '' }, -- document_highlight
    oldfile = { suffix = '' }, -- toggle options
    undo    = { suffix = '' }, -- vim-repeat
  } },

  -- 移动光标
  { 'ggandor/leap.nvim', opts_file = true },
  -- 增强f和t
  { 'ggandor/flit.nvim', opts_file = true, dependencies = 'leap.nvim' },

  -- 移动至任意语法节点
  { 'aaronik/treewalker.nvim', config = true },

  -- 文本对象
  { 'nvim-mini/mini.ai', opts_file = 'mini-ai' },
  { 'chrisgrieser/nvim-various-textobjs', config = true },
  -- mini.ai和mini.surround也可以使用来自此插件的queries
  { 'nvim-treesitter/nvim-treesitter-textobjects',
    main = 'nvim-treesitter.configs', opts_file = true },
} }

local spec_op_edit = require 'libs.lazy-helper' { cond = vim.g.plug_op_edit,
  very_lazy = true, spec = {
  -- 增强q
  { 'chrisgrieser/nvim-recorder', config = true },

  -- 增强gu (gu -> gul, guu -> Vgul)
  { 'johmsalas/text-case.nvim', opts = { prefix = 'gu' },
    keys = { { 'gu', mode = { 'n', 'v' } } }, cmd = 'Subs' },

  -- 替换：计算器，交换，排序
  { 'nvim-mini/mini.operators', opts = {
    evaluate = { prefix = 's=' }, exchange = { prefix = 'sx' },
    sort = { prefix = 's<' },
    multiply = { prefix = '' }, replace = { prefix = '' } } },

  -- 替换：多重光标
  { 'mg979/vim-visual-multi', keys = { { '<C-n>', mode = { 'n', 'v' } } } },

  -- 替换：用ripgrep搜索
  { 'MagicDuck/grug-far.nvim', config = true,
    cmd = { 'GrugFar', 'GrugFarWithin' } },
  { 'chrisgrieser/nvim-rip-substitute', opts_file = true,
    lazy = true, cmd = 'RipSubstitute' },

  -- 替换：匹配引用语法节点
  { 'cshuaimin/ssr.nvim', config = true, lazy = true },

  -- 替换：移动语法节点(标签选择)
  { 'mizlan/iswap.nvim', config = true },

  -- 修改配对符号
  { 'nvim-mini/mini.surround', opts_file = 'mini-surround' },

  -- 表格对齐
  { 'nvim-mini/mini.align', config = true,
    keys = { { 'ga', mode = { 'n', 'v' } }, { 'gA', mode = { 'n', 'v' } } } },

  -- 切换注释
  { 'numToStr/Comment.nvim', opts_file = true },

  -- 切换单词
  { 'monaqa/dial.nvim', config_file = true,
    keys = {
      { '<c-a>', mode = { 'n', 'v' } }, { 'g<c-a>', mode = { 'n', 'v' } },
      { '<c-x>', mode = { 'n', 'v' } }, { 'g<c-x>', mode = { 'n', 'v' } },
    } },

  -- 切换语法节点
  { 'ckolkey/ts-node-action', config = true, lazy = true },
  { 'Wansmer/treesj', config = true, lazy = true,
    opts = { use_default_keymaps = false } },

  -- 检测缩进
  { 'nmac427/guess-indent.nvim', lazy = false, config = true },

  -- Color Picker
  { 'uga-rosa/ccc.nvim', opts_file = true, cmd = { 'CccPick', 'CccConvert' } },
  { 'nvzone/minty', cmd = { 'Shades', 'Huefy' }, dependencies = 'nvzone/volt' },

  -- Tim Pope's dot.
  { 'tpope/vim-repeat' },

  -- 输入模式：补全
  { 'saghen/blink.cmp', version = '1.*', opts_file = 'blink-cmp' },
  { 'mikavilpas/blink-ripgrep.nvim', lazy = true },
  -- 输入模式：自动配对
  { 'altermo/ultimate-autopair.nvim', branch = 'v0.6', config = true },
  { 'windwp/nvim-ts-autotag', config = true },
} }

return vim.list_extend(spec_op_motion, spec_op_edit)
