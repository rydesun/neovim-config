local M = {}

function M.run(to_utf8, replace)
  -- 非utf-8编码的输入自动转换
  if to_utf8 then vim.o.fileencoding = 'utf-8' end

  -- 写入缓存文件
  local tempfile = vim.fn.tempname()
  vim.api.nvim_command('write ' .. tempfile)
  if replace then vim.api.nvim_command('bdelete') end

  -- 在内置终端中打开
  vim.api.nvim_command('term cat ' .. tempfile .. '; cat')
  vim.bo.filetype = 'vim-paging'
end

return M
