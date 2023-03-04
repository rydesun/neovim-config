local M = {}

local symbols = {
  Class         = { ' ', '类' },
  Color         = { ' ', ' ' },
  Constant      = { ' ', '常量' },
  Constructor   = { ' ', '构造器' },
  Enum          = { ' ', '枚举' },
  EnumMember    = { ' ', '枚举成员' },
  Event         = { ' ', ' ' },
  Field         = { ' ', '字段' },
  File          = { ' ', ' ' },
  Folder        = { ' ', ' ' },
  Function      = { ' ', '函数' },
  Interface     = { ' ', '接口' },
  Keyword       = { ' ', '关键字' },
  Method        = { ' ', '方法' },
  Module        = { ' ', '模块' },
  Operator      = { ' ', '运算符' },
  Package       = { ' ', '包' },
  Property      = { ' ', '属性' },
  Reference     = { ' ', ' ' },
  Snippet       = { '⇇⇉', '⇇S⇉' },
  String        = { 's]', '字符串' },
  Struct        = { ' ', '结构体' },
  Text          = { ' ', '文本' },
  TypeParameter = { ' ', '类型参数' },
  Unit          = { '塞', '塞' },
  Value         = { ' ', ' ' },
  Variable      = { ' ', '变量' },
  Collapsed     = { ' ', ' ' },
}

function M.symbols()
  local tbl = {}
  for k,v in pairs(symbols) do
    tbl[k] = v[1]
  end
  return tbl
end

function M.texts()
  local tbl = {}
  for k,v in pairs(symbols) do
    tbl[k] = v[2]
  end
  return tbl
end

return M
