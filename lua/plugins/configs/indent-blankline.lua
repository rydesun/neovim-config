return {
  -- 缩进线字符
  char = vim.g.env_console and '│' or '┊',

  -- 不显示第一层
  show_first_indent_level = false,

  -- 不在末尾行上显示
  show_trailing_blankline_indent = false,
}
