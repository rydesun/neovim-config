-- 在terminal中打开时，启用以下设置
-- terminal以tab的方式打开
vim.g.asynctasks_term_pos = 'TAB'
-- terminal复用tab
vim.g.asynctasks_term_reuse = 1
-- terminal无焦点
vim.g.asynctasks_term_focus = 0
-- terminal不在bufferlist中出现
vim.g.asynctasks_term_listed = 0

vim.api.nvim_create_user_command('AsyncTaskPos', function()
  local pos = { 'TAB', 'right', 'bottom' }
  vim.ui.select(pos, { prompt = 'Select asynctasks_term_pos' }, function(choice)
    if not choice then return end
    vim.g.asynctasks_term_pos = choice
    vim.notify('asynctasks_term_pos: ' .. vim.g.asynctasks_term_pos)
  end)
end, {})
