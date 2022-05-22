local M = {}

function M.bool(val)
  local t = type(val)
  if t == 'number' then return val > 0
  elseif t == 'boolean' then return val
  elseif t == 'string' then return val == 'true' or val == '1'
  else return false end
end

return M
