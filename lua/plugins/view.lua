local cond = vim.g.plug_view
return require 'libs.lazy-helper' { cond = cond, very_lazy = true, spec = {
  -- 高亮变化的文本
  { 'rachartier/tiny-glimmer.nvim', opts_file = true },

  -- 平滑滚动
  { 'karb94/neoscroll.nvim', opts_file = true },

  -- 缩进线
  { 'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts_file = true },

  -- 检测缩进
  { 'nmac427/guess-indent.nvim', lazy = false, config = true },

  -- 空白符
  { 'ntpeters/vim-better-whitespace', lazy = false, init_file = true },

  -- 折叠
  { 'kevinhwang91/nvim-ufo', opts_file = true, lazy = false,
    dependencies = 'kevinhwang91/promise-async' },
  { 'chrisgrieser/nvim-origami', opts = {
    foldKeymaps = { hOnlyOpensOnFirstColumn = true } } },

  -- 选区diff
  { 'AndrewRadev/linediff.vim', config_file = true },

  -- 查看hex
  { 'fidian/hexmode', lazy = false },

  -- 预览markdown
  { 'OXY2DEV/markview.nvim', config = true, ft = 'markdown' },

  -- 显示颜色
  { 'brenoprata10/nvim-highlight-colors', lazy = false, opts_file = true },
} }
