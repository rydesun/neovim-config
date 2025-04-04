local M = {}

local symbols = {
  -- CompletionItemKind
  Module        = { '󰆧 ', 'mod' },
  Interface     = { '𝐈󰬁', 'interface' },
  Class         = { '𝐂󰬁', 'class' },
  Struct        = { '𝐒󰬁', 'struct' },
  Enum          = { '󰒻 ', 'enum' },
  EnumMember    = { '󰒻 ', 'enum' },
  Field         = { '󰌷 ', '<>' },
  Property      = { '󰌷 ', '<>' },
  Function      = { '󰡱 ', 'fn' },
  Method        = { '󰡱 ', 'fn' },
  Constructor   = { '󰡱 ', 'fn' },
  Variable      = { '󰫧 ', 'var' },
  Constant      = { '󰜗 ', 'const' },
  Keyword       = { '󰌹 ', 'keyword' },
  TypeParameter = { ' ', '<?>' },
  Snippet       = { '󰨾 ', 'code' },
  Color         = { '󰏘 ', 'color' },
  Event         = { ' ', 'event' },
  File          = { '󰭷 ', 'file' },
  Folder        = { '󰉋 ', 'dir' },
  Operator      = { '󰆕 ', 'operator' },
  Reference     = { ' ', 'ref' },
  Unit          = { '󰟢 ', 'unit' },
  Text          = { ' ', 'txt' },
  Value         = { '󰎠 ', 'value' },

  -- +SymbolKind
  Package       = { '󰆦 ', 'pkg' },
  Namespace     = { '󰘦 ', 'ns' },
  String        = { ' ', 'str' },
  Number        = { ' ', '#' },
  Boolean       = { ' ', 'bool' },
  Array         = { '󰨾 ', '[]' },
  Object        = { '󰠲 ', '{}' },
  Key           = { ' ', 'key' },
  Null          = { '󰟢 ', 'null' },

  -- +extended
  Component     = { '󰅴 ', 'component' },
  Fragment      = { '󰅴 ', 'fragment' },
}

---@param use_ascii? boolean
---@return table<string, string>
function M.symbols(use_ascii)
  local tbl = {}
  -- 在virtual console中使用英文
  if vim.g.env_console or use_ascii then
    for k, v in pairs(symbols) do tbl[k] = v[2] end
  else
    for k, v in pairs(symbols) do tbl[k] = v[1] end
  end
  return tbl
end

return M
