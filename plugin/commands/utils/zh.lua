local M = {}

vim.api.nvim_create_user_command('CountZhChars',
  function() M.count() end, {})

-- 修复中英文间空格
vim.api.nvim_create_user_command('TypoSpace',
  function() M.typo_space() end, {})

local han = '[\\u3400-\\u4DBF\\u4E00-\\u9FFF\\uF900-\\uFAFF\\U20000-\\U323AF]'
local latin = '[a-zA-Z0-9\'"$&`]'

function M.count()
  vim.cmd('%s/' .. han .. '//gn')
end

function M.typo_space()
  local cmd = [[silent! %s/\(%s\)\(%s\)/\1 \2/g]]
  vim.cmd(cmd:format('%s', han, latin))
  vim.cmd(cmd:format('%s', latin, han))
  vim.cmd.nohlsearch()
end
