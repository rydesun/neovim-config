local M = {}

function M.git_add(path)
  vim.api.nvim_command('silent !git add ' .. path)
end

function M.git_unstage(path)
  vim.api.nvim_command('silent !git restore --staged ' .. path)
end

return M
