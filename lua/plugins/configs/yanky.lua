vim.keymap.set({ 'n', 'x' }, 'y', '<Plug>(YankyYank)')

vim.keymap.set({ 'n', 'x' }, 'p', '<Plug>(YankyPutAfter)')
vim.keymap.set({ 'n', 'x' }, 'P', '<Plug>(YankyPutBefore)')
vim.keymap.set({ 'n', 'x' }, 'gp', '<Plug>(YankyGPutAfter)')
vim.keymap.set({ 'n', 'x' }, 'gP', '<Plug>(YankyGPutBefore)')

-- tpope/vim-unimpaired
vim.keymap.set('n', ']p', '<Plug>(YankyPutIndentAfterLinewise)')
vim.keymap.set('n', '[p', '<Plug>(YankyPutIndentBeforeLinewise)')
vim.keymap.set('n', ']P', '<Plug>(YankyPutIndentAfterLinewise)')
vim.keymap.set('n', '[P', '<Plug>(YankyPutIndentBeforeLinewise)')
vim.keymap.set('n', '>p', '<Plug>(YankyPutIndentAfterShiftRight)')
vim.keymap.set('n', '<p', '<Plug>(YankyPutIndentAfterShiftLeft)')
vim.keymap.set('n', '>P', '<Plug>(YankyPutIndentBeforeShiftRight)')
vim.keymap.set('n', '<P', '<Plug>(YankyPutIndentBeforeShiftLeft)')
vim.keymap.set('n', '=p', '<Plug>(YankyPutAfterFilter)')
vim.keymap.set('n', '=P', '<Plug>(YankyPutBeforeFilter)')

return {
  ring = {
    storage = 'sqlite',
    update_register_on_cycle = true,
  },
  -- 在init.lua中已经设置
  highlight = { on_yank = false },
  system_clipboard = { sync_with_ring = false },
}
