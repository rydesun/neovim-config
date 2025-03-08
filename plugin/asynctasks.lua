local pos = { 'TAB', 'right', 'bottom' }

vim.api.nvim_create_user_command('AsyncTaskTogglePos', function()
  local next_i = 0
  for i, v in ipairs(pos) do
    if vim.g.asynctasks_term_pos == v then
      next_i = i == #pos and 1 or i + 1
      break
    end
  end
  if next_i == 0 then next_i = 1 end
  vim.g.asynctasks_term_pos = pos[next_i]
  vim.notify('asynctasks_term_pos: ' .. vim.g.asynctasks_term_pos)
end, {})
