local M = {}

function M.border()
  return { '▄', '▄', '▄', '█', '▀', '▀', '▀', '█' }
end

local symbols = {
  Class         = { '󰆦 ', '类' },
  Color         = { '󰏘 ', '󰏘 ' },
  Constant      = { '󰐀 ', '常量' },
  Constructor   = { ' ', '构造器' },
  Enum          = { ' ', '枚举' },
  EnumMember    = { ' ', '枚举成员' },
  Event         = { '󰉁 ', '󰉁 ' },
  Field         = { '󰌕 ', '字段' },
  File          = { '󰈙 ', '󰈙 ' },
  Folder        = { ' ', ' ' },
  Function      = { '󰯻 ', '函数' },
  Interface     = { ' ', '接口' },
  Keyword       = { '󰌆 ', '关键字' },
  Method        = { '󰬍 ', '方法' },
  Module        = { '󰏖 ', '模块' },
  Operator      = { '󰆖 ', '运算符' },
  Package       = { '󰏖 ', '包' },
  Property      = { '󰌕 ', '属性' },
  Reference     = { '󰈇 ', '󰈇 ' },
  Snippet       = { '󰚄 ', '片段' },
  String        = { '󰅳 ', '字符串' },
  Struct        = { '󰆧 ', '结构体' },
  Text          = { ' ', '文本' },
  TypeParameter = { ' ', '类型参数' },
  Unit          = { '󰑭', '󰑭' },
  Value         = { '󰎠 ', '󰎠 ' },
  Variable      = { '󰈜 ', '变量' },
  Collapsed     = { ' ', ' ' },
}

function M.symbols()
  local tbl = {}
  if vim.g.env_console then
    for k, v in pairs(symbols) do tbl[k] = '•' end
  else
    for k, v in pairs(symbols) do tbl[k] = v[1] end
  end
  return tbl
end

function M.texts()
  local tbl = {}
  if vim.g.env_console then
    -- 在virtual console中使用英文
    for k, v in pairs(symbols) do tbl[k] = k end
  else
    for k, v in pairs(symbols) do tbl[k] = v[2] end
  end
  return tbl
end

return M
