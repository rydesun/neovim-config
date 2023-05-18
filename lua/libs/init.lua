local M = {}

function M.bool(val)
  local t = type(val)
  if t == 'number' then
    return val > 0
  elseif t == 'boolean' then
    return val
  elseif t == 'string' then
    return val == 'true' or val == '1'
  else
    return false
  end
end

function M.transform_color(contrast_factor, brightness_offset)
  return function(hex)
    local res = {}
    for i = 2, 6, 2 do
      local raw = hex:sub(i, i + 1)
      local val = contrast_factor * (tonumber(raw, 16) - 128)
          + 128 + brightness_offset
      if val < 0 then val = 0 elseif val > 255 then val = 255 end
      table.insert(res, string.format('%02x', math.floor(val + 0.5)))
    end
    return '#' .. table.concat(res, '')
  end
end

return M
