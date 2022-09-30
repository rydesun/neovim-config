local cmp = require 'cmp'
local types = require 'cmp.types'

local view_kinds = {
  Method = '方法', Function = '函数', Constructor = '构造器', Field = '字段',
  Variable = '变量', Class = '类', Interface = '接口', Module = '模块',
  Property = '属性', Value = '值', Enum = '枚举', Keyword = '关键字',
  Snippet = ' ', Color = ' ', File = ' ', Reference = ' ', Folder = ' ',
  EnumMember = '枚举成员', Constant = '常量', Struct = '结构体', Event = '事件',
  Operator = '运算符', TypeParameter = '类型参数',
}

cmp.setup {
  mapping = cmp.mapping.preset.insert {
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
  },
  snippet = {
    expand = function(args) require('luasnip').lsp_expand(args.body) end,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' }, { name = 'luasnip' }, { name = 'path' }
  }, {
    { name = 'buffer' },
  }),
  window = {
    completion = cmp.config.window.bordered {
      col_offset = -1,
    },
    documentation = cmp.config.window.bordered(),
  },
  formatting = {
    format = function(_, vim_item)
      if vim_item.kind == 'Text' then
        vim_item.kind = ''
      else
        vim_item.kind = '│ ' .. (view_kinds[vim_item.kind] or vim_item.kind)
      end
      return vim_item
    end
  },
}

local cmdline_opts = {
  view = {
    entries = { name = 'wildmenu', separator = ' · ' }
  },
  mapping = {
    ['<Tab>'] = {
      c = function()
        if not cmp.visible() then return end
        cmp.select_next_item { behavior = types.cmp.SelectBehavior.Insert }
      end,
    },
    ['<S-Tab>'] = {
      c = function()
        if not cmp.visible() then return end
        cmp.select_prev_item { behavior = types.cmp.SelectBehavior.Insert }
      end,
    },
  },
}

cmp.setup.cmdline('/', cmdline_opts)
cmp.setup.cmdline('?', cmdline_opts)
cmp.setup.cmdline(':',
  vim.tbl_extend('error', cmdline_opts, {
    sources = {
      { name = 'cmdline' }
    }
  })
)
