local augend = require 'dial.augend'
local map = require 'dial.map'

vim.keymap.set('n', '<C-a>',
  function() map.manipulate('increment', 'normal') end)
vim.keymap.set('v', '<C-a>',
  function() map.manipulate('increment', 'visual') end)
vim.keymap.set('n', '<C-x>',
  function() map.manipulate('decrement', 'normal') end)
vim.keymap.set('v', '<C-x>',
  function() map.manipulate('decrement', 'visual') end)
vim.keymap.set('n', 'g<C-a>',
  function() map.manipulate('increment', 'gnormal') end)
vim.keymap.set('n', 'g<C-x>',
  function() map.manipulate('decrement', 'gnormal') end)
vim.keymap.set('v', 'g<C-a>',
  function() map.manipulate('increment', 'gvisual') end)
vim.keymap.set('v', 'g<C-x>',
  function() map.manipulate('decrement', 'gvisual') end)

require 'dial.config'.augends:register_group {
  default = {
    augend.semver.alias.semver,

    -- 数字
    augend.integer.alias.decimal,
    augend.integer.alias.hex,
    augend.integer.alias.octal,
    augend.integer.alias.binary,

    -- 常量
    augend.constant.alias.bool,
    augend.constant.new { elements = { 'FALSE', 'TRUE' } },
    augend.constant.new { elements = { 'False', 'True' } },

    -- 日期
    augend.date.alias['%Y/%m/%d'],
    augend.date.alias['%Y-%m-%d'],
    augend.date.alias['%Y年%-m月%-d日'],
    augend.date.alias['%H:%M:%S'],
    augend.date.alias['%H:%M'],
    augend.constant.alias.ja_weekday_full,

    -- RGB
    augend.hexcolor.new { case = 'prefer_upper' },

    -- 运算符
    augend.constant.new { elements = { 'and', 'or' } },
    augend.constant.new { elements = { 'AND', 'OR' } },
    augend.constant.new { elements = { 'And', 'Or' }, word = false },
    augend.constant.new { elements = { '&&', '||' }, word = false },
    augend.constant.new { elements = { '==', '!=' }, word = false },
    augend.constant.new { elements = { '===', '!==' }, word = false },
    augend.constant.new { elements = { '->', '<-' }, word = false },

    -- 关键字
    augend.constant.new { elements = { 'let', 'const', 'var', 'static' } },
    augend.constant.new { elements = { 'break', 'continue' } },
    augend.constant.new { elements = { 'assert_eq', 'assert_ne' } },
    augend.constant.new { elements = { 'max', 'min' } },
    augend.constant.new { elements = { 'background', 'foreground' } },
    augend.constant.new { elements = { 'top', 'bottom' } },
    augend.constant.new { elements = { 'left', 'right' } },
    augend.constant.new { elements = { 'margin', 'padding' } },

    -- 日志等级
    augend.constant.new { elements = {
      'trace', 'debug', 'info', 'warn', 'error', 'critical', 'fatal',
    } },
    augend.constant.new { elements = {
      'TRACE', 'DEBUG', 'INFO', 'WARN', 'ERROR', 'CRITICAL', 'FATAL',
    } },
    augend.constant.new { elements = {
      'Trace', 'Debug', 'Info', 'Warn', 'Error', 'Critical', 'Fatal',
    }, word = false },
  },
}
