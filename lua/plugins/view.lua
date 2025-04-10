local cond = vim.g.plug_view
return require 'libs.lazy-helper' { cond = cond, very_lazy = true, spec = {
  -- 平滑滚动
  { 'karb94/neoscroll.nvim', opts_file = true },

  -- 缩进线
  { 'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts_file = true },

  -- 检测缩进
  { 'nmac427/guess-indent.nvim', lazy = false, config = true },

  -- 空白符
  { 'ntpeters/vim-better-whitespace', lazy = false, init_file = true },

  -- 折叠
  {
    'kevinhwang91/nvim-ufo',
    lazy = false,
    opts_file = true,
    dependencies = 'kevinhwang91/promise-async',
  },

  -- 选区diff
  { 'AndrewRadev/linediff.vim', config_file = true },

  -- 查看hex
  { 'fidian/hexmode', lazy = false },

  -- 预览markdown
  { 'OXY2DEV/markview.nvim', lazy = false, config = true },

  -- 显示颜色
  { 'brenoprata10/nvim-highlight-colors', lazy = false, opts_file = true },
} }
