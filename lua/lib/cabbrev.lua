local M = {}
local fn = vim.fn

function M.alias(input, replace)
  local cmd = 'cnoreabbrev <expr> %s v:lua._cmd_expr("%s", "%s")'
  vim.cmd(cmd:format(input, input, replace))
end

function _G._cmd_expr(input, replace)
  if fn.getcmdtype() == ':' and
    fn.getcmdline():match('^'..input..'$') then
    return replace
  else
    return input
  end
end

return M
