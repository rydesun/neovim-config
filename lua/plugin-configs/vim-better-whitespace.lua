vim.g.better_whitespace_guicolor = 'NONE'

-- 显示TAB前面的空格
vim.g.show_spaces_that_precede_tabs = 1

vim.g.better_whitespace_filetypes_blacklist = { 'qf', 'help', 'markdown',
  'vim-paging' }

-- 不在内置终端中显示
vim.api.nvim_create_autocmd({ 'TermOpen' }, {
  pattern = { '*' },
  callback = function() vim.api.nvim_command 'DisableWhitespace' end
})
