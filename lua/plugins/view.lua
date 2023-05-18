return require 'libs.lazy'.setdefault(vim.g.plug_view, 'VeryLazy', {
  -- 平滑滚动
  { 'karb94/neoscroll.nvim', opts_file = true },

  -- 缩进线
  { 'lukas-reineke/indent-blankline.nvim', nolazy = true, opts_file = true },

  -- 检测缩进
  { 'nmac427/guess-indent.nvim', nolazy = true, config = true },

  -- 空白符
  { 'ntpeters/vim-better-whitespace', nolazy = true, init_file = true },

  -- 折叠
  {
    'kevinhwang91/nvim-ufo',
    nolazy = true,
    opts_file = true,
    dependencies = 'kevinhwang91/promise-async',
  },

  -- 选区diff
  { 'AndrewRadev/linediff.vim', config_file = true },

  -- 查看hex
  { 'fidian/hexmode', nolazy = true },

  -- 翻译
  { 'voldikss/vim-translator' },

  -- 显示颜色
  { 'NvChad/nvim-colorizer.lua', nolazy = true, opts_file = true },
})
