vim.api.nvim_create_user_command('SetColorColumn', function()
  local ec = vim.b.editorconfig
  local max_line_length = ec and ec.max_line_length or '80'
  vim.wo.colorcolumn = max_line_length
end, {})
