local cmp = require'cmp'
local sources = {
  buffer = "Buffer",
  nvim_lsp = "LSP",
  luasnip = "LuaSnip",
}
local kinds = {
  Text = '文本',
  Method = '方法',
  Function = '函数',
  Constructor = '构造器',
  Field = '字段',
  Variable = '变量',
  Class = '类',
  Interface = '接口',
  Module = '模块',
  Property = '属性',
  Value = '值',
  Enum = '枚举',
  Keyword = '关键字',
  Snippet = ' ',
  Color = ' ',
  File = ' ',
  Reference = ' ',
  Folder = ' ',
  EnumMember = '枚举成员',
  Constant = '常量',
  Struct = '结构体',
  Event = '事件',
  Operator = '运算符',
  TypeParameter = '类型形参',
}

cmp.setup{
  mapping = cmp.mapping.preset.insert{},
  snippet = {
    expand = function(args) require('luasnip').lsp_expand(args.body) end,
  },
  sources = cmp.config.sources(
    { { name = 'nvim_lsp' }, { name = 'nvim_lsp_signature_help' },
      { name = 'luasnip' }, { name = 'path' } },
    { { name = 'buffer' } }
  ),
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = '│ ' .. (
        kinds[vim_item.kind] or vim_item.kind or '')
      vim_item.menu = '│ ' .. (
        sources[entry.source.name] or entry.source.name or '')
      return vim_item
    end
  },
}
