local M = {}

function M.border()
  return { '▄', '▄', '▄', '█', '▀', '▀', '▀', '█' }
end

local symbols = {
  Module        = ' ',
  Interface     = 'T󰫶',
  Class         = 'T󰫰',
  Struct        = 'T󰬀',
  Enum          = ' ',
  EnumMember    = ' ',
  Field         = '󰓼 ',
  Property      = '󰓼 ',
  Function      = '󰡱 ',
  Method        = '󰡱 ',
  Constructor   = '󰡱 ',
  Variable      = '󰫧 ',
  Constant      = '󰜗 ',
  Keyword       = ' ',
  TypeParameter = ' ',
  Snippet       = '󰨾 ',

  Color         = '󰏘 ',
  Event         = ' ',
  File          = '󰭷 ',
  Folder        = '󰉋 ',
  Operator      = '󰆕 ',
  Reference     = ' ',
  Unit          = '󰟢 ',
  Text          = ' ',
  Value         = '󰎠 ',
}

function M.symbols()
  -- 在virtual console中使用英文
  if vim.g.env_console then
    local tbl = {}
    for k, _ in pairs(symbols) do tbl[k] = k end
    return tbl
  end
  return vim.deepcopy(symbols)
end

return M
