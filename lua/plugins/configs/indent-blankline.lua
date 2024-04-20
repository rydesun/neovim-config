return {
  indent = {
    -- 缩进线字符
    char = vim.g.env_console and '│' or '┊',
    tab_char = '│',

    -- wrap行上也能显示
    repeat_linebreak = true,
  },

  -- 不显示上下文范围
  scope = { enabled = false },
}
