-- 与nvim-cmp集成
require 'cmp'.event:on(
  'confirm_done',
  require 'nvim-autopairs.completion.cmp'.on_confirm_done()
)

local npairs = require 'nvim-autopairs'
local rule = require 'nvim-autopairs.rule'
local conds = require 'nvim-autopairs.conds'

npairs.setup {
  -- 直接输入右匹配而不是移动光标
  enable_moveright = false,
}

-- https://github.com/windwp/nvim-autopairs/wiki/Custom-rules
local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' } }
npairs.add_rules { rule(' ', ' ')
    :with_pair(function(opts)
      local pair = opts.line:sub(opts.col - 1, opts.col)
      return vim.tbl_contains({
        brackets[1][1] .. brackets[1][2],
        brackets[2][1] .. brackets[2][2],
        brackets[3][1] .. brackets[3][2]
      }, pair)
    end)
    :with_move(conds.none())
    :with_cr(conds.none())
    :with_del(function(opts)
      local col = vim.api.nvim_win_get_cursor(0)[2]
      local context = opts.line:sub(col - 1, col + 2)
      return vim.tbl_contains({
        brackets[1][1] .. '  ' .. brackets[1][2],
        brackets[2][1] .. '  ' .. brackets[2][2],
        brackets[3][1] .. '  ' .. brackets[3][2]
      }, context)
    end)
}
for _, bracket in pairs(brackets) do
  rule('', ' ' .. bracket[2])
      :with_pair(conds.none())
      :with_move(function(opts) return opts.char == bracket[2] end)
      :with_cr(conds.none())
      :with_del(conds.none())
      :use_key(bracket[2])
end
