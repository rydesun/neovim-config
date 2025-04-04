local neoscroll = require 'neoscroll'

local keymap = {
  -- 允许滚动文档
  ['<C-b>'] = function()
    NoiceScrollDoc(-4, function() neoscroll.ctrl_b { duration = 450 } end, 'n')
  end,
  ['<C-f>'] = function()
    NoiceScrollDoc(4, function() neoscroll.ctrl_f { duration = 450 } end, 'n')
  end,

  -- 其他保持默认
  ['<C-u>'] = function() neoscroll.ctrl_u { duration = 250 } end,
  ['<C-d>'] = function() neoscroll.ctrl_d { duration = 250 } end,
  ['zt']    = function() neoscroll.zt { half_win_duration = 250 } end,
  ['zz']    = function() neoscroll.zz { half_win_duration = 250 } end,
  ['zb']    = function() neoscroll.zb { half_win_duration = 250 } end,
}

-- 不要设置smap
local modes = { 'n', 'x' }
for key, func in pairs(keymap) do
  vim.keymap.set(modes, key, func)
end

return {
  -- 取消默认键位设置
  mappings = {},

  -- 不要隐藏光标
  hide_cursor = false,

  easing_function = 'cubic'
}
