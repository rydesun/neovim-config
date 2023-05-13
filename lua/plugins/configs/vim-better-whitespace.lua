-- 显示TAB前面的空格
vim.g.show_spaces_that_precede_tabs = 1

vim.g.better_whitespace_filetypes_blacklist = {
  'qf', 'help', 'markdown', 'ansi', 'xxd',
}

-- 不在内置终端中显示
vim.api.nvim_create_autocmd({ 'TermOpen' }, {
  pattern = { '*' },
  callback = function() vim.api.nvim_command 'DisableWhitespace' end
})

-- 不自动设置按键映射
vim.g.better_whitespace_operator = ''
