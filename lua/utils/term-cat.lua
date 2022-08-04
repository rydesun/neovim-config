local M = {}

function M.run(utf8, replace)
  if utf8 then
    -- 非utf-8编码的输入自动转换
    vim.o.fileencoding = 'utf-8'
  end
  local tempfile = vim.fn.tempname()
  vim.api.nvim_command('write '..tempfile)
  if replace then
    vim.api.nvim_command('bdelete')
  end
  vim.api.nvim_command('term cat '..tempfile..'; cat')
end

return M
