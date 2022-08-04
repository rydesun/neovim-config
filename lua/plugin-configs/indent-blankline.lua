require'indent_blankline'.setup {
  -- 缩进线字符
  char = '┊',

  -- 不显示第一层
  show_first_indent_level = false,

  -- 不在末尾行上显示
  show_trailing_blankline_indent = false,

  -- 优先使用treesitter计算缩进
  use_treesitter = true,
  use_treesitter_scope = true,
}
