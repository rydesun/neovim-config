-- 与nvim-cmp集成
require 'cmp'.event:on(
  'confirm_done',
  require 'nvim-autopairs.completion.cmp'.on_confirm_done()
)

local npairs = require 'nvim-autopairs'

npairs.setup {
  -- 直接输入右匹配而不是移动光标
  enable_moveright = false,
}
