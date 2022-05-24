local M = {
  hans = '[\\u3400-\\u4DBF\\u4E00-\\u9FFC]',
  alnum = '[a-zA-Z0-9]',
}

function M:count()
  vim.api.nvim_command("%s/" .. self.hans .. "//gn")
end

function M:typo_space()
  local cmd = [[silent! %s/\(%s\)\(%s\)/\1 \2/g]]
  vim.api.nvim_command(cmd:format('%s', self.hans, self.alnum))
  vim.api.nvim_command(cmd:format('%s', self.alnum, self.hans))
end

return M
