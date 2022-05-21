require'hlslens'.setup{nearest_only = true}

local keymap = vim.api.nvim_set_keymap
local kopts = {noremap = true, silent = true}
keymap('n', 'n',
  [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
  kopts)
keymap('n', 'N',
  [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
  kopts)
keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)

vim.api.nvim_create_autocmd({"User"}, {
  pattern = {"visual_multi_start"},
  callback = function() require'config/vmlens'.start() end
})
vim.api.nvim_create_autocmd({"User"}, {
  pattern = {"visual_multi_exit"},
  callback = function() require'config/vmlens'.exit() end
})
