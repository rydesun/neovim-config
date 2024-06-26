local augend = require 'dial.augend'
local map = require 'dial.map'

local kopts = { noremap = true }
vim.keymap.set('n', '<C-a>', map.inc_normal(), kopts)
vim.keymap.set('n', '<C-x>', map.dec_normal(), kopts)
vim.keymap.set('v', '<C-a>', map.inc_visual(), kopts)
vim.keymap.set('v', '<C-x>', map.dec_visual(), kopts)
vim.keymap.set('v', 'g<C-a>', map.inc_gvisual(), kopts)
vim.keymap.set('v', 'g<C-x>', map.dec_gvisual(), kopts)

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
    augend.constant.new { elements = { "FALSE", "TRUE" } },
    augend.constant.new { elements = { "False", "True" } },

    -- 日期
    augend.date.alias["%Y/%m/%d"],
    augend.date.alias["%Y-%m-%d"],
    augend.date.alias["%Y年%-m月%-d日"],
    augend.date.alias["%H:%M:%S"],
    augend.date.alias["%H:%M"],
    augend.constant.alias.ja_weekday_full,

    -- 运算符
    augend.constant.new { elements = { "and", "or" } },
    augend.constant.new { elements = { "AND", "OR" } },
    augend.constant.new { elements = { "And", "Or" }, word = false },
    augend.constant.new { elements = { "&&", "||" }, word = false },
    augend.constant.new { elements = { "&", "|", "^" }, word = false },
    augend.constant.new { elements = { "&=", "|=", "^=" }, word = false },
    augend.constant.new { elements = { "==", "!=" }, word = false },
    augend.constant.new { elements = { "===", "!==" }, word = false },
    augend.constant.new { elements = { ">=", "<=", ">", "<" }, word = false },
    augend.constant.new { elements = { "++", "--" }, word = false },

    -- 关键字
    augend.constant.new { elements = { "let", "const", "var", "static" } },
    augend.constant.new { elements = { "break", "continue" } },
    augend.constant.new { elements = { "assert_eq", "assert_ne" } },
    augend.constant.new { elements = { "max", "min" } },
    augend.constant.new { elements = { "background", "foreground" } },
    augend.constant.new { elements = { "top", "bottom" } },
    augend.constant.new { elements = { "left", "right" } },
    augend.constant.new { elements = { "margin", "padding" } },
    augend.constant.new { elements = { "disable", "enable"}, word = false },

    -- 日志等级
    augend.constant.new { elements = {
      "trace", "debug", "info", "warn", "warning", "error", "critical", "fatal",
    } },
    augend.constant.new { elements = {
      "TRACE", "DEBUG", "INFO", "WARN", "WARNING", "ERROR", "CRITICAL", "FATAL",
    } },
    augend.constant.new { elements = {
      "Trace", "Debug", "Info", "Warn", "Warning", "Error", "Critical", "Fatal",
    }, word = false },
  },
}
