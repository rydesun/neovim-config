local M = {}

function M.run(subcmd, only_this)
  local dir = vim.fn.expand('%:p:h')
  local cmd = string.format(
    'edit term://%s//git -c delta.paging=never %s', dir, subcmd)
  if only_this then
    local file = vim.fn.expand('%:p:t')
    cmd = cmd .. ' ' .. file
  end
  vim.api.nvim_command(cmd)
  vim.api.nvim_buf_set_keymap(0, 'n', 'q', '', {
      noremap = true,
      callback = function() vim.api.nvim_buf_delete(0, {}) end,
  })
end

return M
