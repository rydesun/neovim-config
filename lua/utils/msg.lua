local M = {}

function M.err(str)
  vim.api.nvim_command('redraw')
  vim.api.nvim_command('echohl ErrorMsg')
  vim.api.nvim_command(string.format('echo "%s"', str))
  vim.api.nvim_command('echohl NONE')
end

return M
