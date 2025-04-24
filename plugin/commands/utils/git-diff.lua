local M = {}

vim.api.nvim_create_user_command('GitDiffCurrent',
  function() M.run('diff', true) end, {})
vim.api.nvim_create_user_command('GitDiffAll',
  function() M.run('diff', false) end, {})
vim.api.nvim_create_user_command('GitDiffStagedCurrent',
  function() M.run('diff --staged', true) end, {})
vim.api.nvim_create_user_command('GitDiffStagedAll',
  function() M.run('diff --staged', false) end, {})

function M.run(subcmd, only_this)
  local dir = vim.fn.expand '%:p:h'
  local cmd = string.format(
    'edit term://%s//git -c delta.paging=never %s', dir, subcmd)
  if only_this then
    local file = vim.fn.expand '%:p:t'
    cmd = cmd .. ' ' .. file
  end
  vim.api.nvim_command(cmd)
  vim.api.nvim_buf_set_keymap(0, 'n', 'q', '', {
    noremap = true,
    callback = function()
      local buf = vim.api.nvim_get_current_buf()
      local alt = vim.fn.bufnr '#'
      if alt ~= buf and vim.fn.buflisted(alt) == 1 then vim.cmd 'bprevious' end
      vim.api.nvim_buf_delete(buf, {})
    end,
  })
end
