local cmp = require 'cmp'
local types = require 'cmp.types'
local view_kinds = require 'libs.style'.symbols()

cmp.setup {
  mapping = cmp.mapping.preset.insert {
    -- 滚动文档
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    -- 如果没有选中项，select = true 使用第一条进行展开
    ['<C-y>'] = cmp.mapping.confirm { select = true },
    ['<C-l>'] = cmp.mapping.confirm { select = true },
  },
  snippet = {
    expand = function(args) require('luasnip').lsp_expand(args.body) end,
  },
  sources = cmp.config.sources(
    { { name = 'nvim_lsp' }, { name = 'luasnip' }, { name = 'path' } },
    { { name = 'omni' },
      {
        name = 'buffer',
        option = {
          get_bufnrs = function() return vim.api.nvim_list_bufs() end }
      },
    }
  ),
  window = {
    completion = cmp.config.window.bordered {
      col_offset = -1,
    },
    documentation = cmp.config.window.bordered(),
  },
  formatting = {
    format = function(entry, vim_item)
      if vim_item.kind == 'Snippet' and
          entry.source:get_debug_name() == 'nvim_lsp:emmet_ls' then
          vim_item.abbr = 'Emmet'
      end

      if vim_item.kind == 'Text' then
        local source_name = entry.source.name
        if source_name == 'buffer' then
          vim_item.kind = ''
        else
          vim_item.kind = string.format('(%s)', source_name)
          vim_item.kind_hl_group = 'CmpItemKind'
        end
      else
        vim_item.kind = '│ ' .. (view_kinds[vim_item.kind] or vim_item.kind)
      end

      local maxwidth = 20
      local label = vim_item.abbr
      if entry.source.name ~= 'cmdline' and #label > maxwidth then
        local truncated_label = vim.fn.strcharpart(label, 0, maxwidth)
        local i = maxwidth
        -- 可能包含中文
        while vim.fn.strdisplaywidth(truncated_label) > maxwidth do
          i = i - 1
          truncated_label = vim.fn.strcharpart(label, 0, i)
        end
        vim_item.abbr = truncated_label .. '⋯'
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

cmp.setup.cmdline(':',
  vim.tbl_extend('error', cmdline_opts, {
    sources = { { name = 'cmdline', keyword_length = 3 } }
  })
)
