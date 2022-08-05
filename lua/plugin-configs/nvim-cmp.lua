local cmp = require'cmp'
if not cmp then return end

local sources = {
  buffer = "Buffer",
  nvim_lsp = "LSP",
  luasnip = "LuaSnip",
}
local kinds = {
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
    {
      { name = 'nvim_lsp' }, { name = 'nvim_lsp_signature_help' },
      { name = 'luasnip' }, { name = 'path' }
    }, {
      {
        name = 'buffer',
        option = {
          get_bufnrs = function()
            local bufs = {}
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
              local byte_size = vim.api.nvim_buf_get_offset(
                buf, vim.api.nvim_buf_line_count(buf))
              if byte_size < 1024 * 1024 then
                table.insert(bufs, buf)
              end
            end
            return bufs
          end
        },
      },
    }
  ),
  formatting = {
    format = function(entry, vim_item)
      if vim_item.kind == 'Text' then
        vim_item.kind = ''
        return vim_item
      end
      vim_item.kind = '│ ' .. (
        kinds[vim_item.kind] or vim_item.kind or '')
      vim_item.menu = '│ ' .. (
        sources[entry.source.name] or entry.source.name or '')
      return vim_item
    end
  },
}

local types = require('cmp.types')
local cmdline_mapping = {
    ['<Tab>'] = {
      c = function()
        if cmp.visible() then
          cmp.select_next_item({ behavior = types.cmp.SelectBehavior.Insert })
        end
      end,
    },
    ['<S-Tab>'] = {
      c = function()
        if cmp.visible() then
          cmp.select_prev_item({ behavior = types.cmp.SelectBehavior.Insert })
        end
      end,
    },
}

cmp.setup.cmdline('/', {
  mapping = cmdline_mapping,
  view = {
    entries = {name = 'wildmenu', separator = ' · ' }
  },
})

cmp.setup.cmdline('?', {
  mapping = cmdline_mapping,
  view = {
    entries = {name = 'wildmenu', separator = ' · ' }
  },
})

cmp.setup.cmdline(':', {
  mapping = cmdline_mapping,
  view = {
    entries = {name = 'wildmenu', separator = ' · ' }
  },
  sources = cmp.config.sources(
    {
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    }
  ),
})
