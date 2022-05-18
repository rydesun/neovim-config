local M = {}
local fn = vim.fn

function M.expr(input, replace)
  cmd = 'cnoreabbrev <expr> %s v:lua.cmd_expr("%s", "%s")'
  vim.cmd(cmd:format(input, input, replace))
end

function _G.cmd_expr(input, replace)
  if fn.getcmdtype() == ':' and fn.getcmdline():match('^'..input..'$') then
    return replace
  else
    return input
  end
end

return M
