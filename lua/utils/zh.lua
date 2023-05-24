local M = { }

local hans = '[\\u3400-\\u4DBF\\u4E00-\\u9FFF\\uF900-\\uFAFF\\U20000-\\U323AF]'
local alnum = '[a-zA-Z0-9]'

function M.count()
  vim.cmd('%s/' .. hans .. '//gn')
end

function M.typo_space()
  local cmd = [[silent! %s/\(%s\)\(%s\)/\1 \2/g]]
  vim.cmd(cmd:format('%s', hans, alnum))
  vim.cmd(cmd:format('%s', alnum, hans))
end

return M
