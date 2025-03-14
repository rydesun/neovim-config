local cmp = require 'cmp'
local types = require 'cmp.types'
local view_kinds = require 'libs.style'.symbols()

cmp.setup {
  mapping = cmp.mapping.preset.insert {
    -- 滚动文档(补全项菜单右侧出现的文档)
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    -- 如果没有选中项，select = true 使用第一条进行展开
    ['<C-y>'] = cmp.mapping.confirm { select = true },
    ['<C-l>'] = cmp.mapping.confirm { select = true,
      -- 候选项覆盖后面的文本
      behavior = cmp.ConfirmBehavior.Replace,
    },
  },
  snippet = {
    expand = function(args) require 'luasnip'.lsp_expand(args.body) end,
  },
  sources = cmp.config.sources(
    { { name = 'lazydev' } },
    { { name = 'nvim_lsp' }, { name = 'luasnip' }, { name = 'path' } },
    { { name = 'omni' },
      {
        name = 'buffer',
        option = {
          get_bufnrs = function() return vim.api.nvim_list_bufs() end },
      },
    }
  ),
  window = {
    completion = cmp.config.window.bordered {
      col_offset = -1,
    },
    documentation = cmp.config.window.bordered(),
  },
  ---@diagnostic disable-next-line: missing-fields
  formatting = {
    format = function(entry, vim_item)
      if vim_item.kind == 'Snippet' and
          entry.source:get_debug_name() == 'nvim_lsp:emmet_ls' then
        vim_item.abbr = 'Emmet'
      end

      if vim_item.kind == 'Text' and entry.source.name == 'buffer' then
        vim_item.kind = ''
      end
      vim_item.kind = view_kinds[vim_item.kind] or vim_item.kind

      if entry.source.name == 'cmdline' or vim_item.menu == nil then
        return vim_item
      end
      vim_item.menu_hl_group = 'Comment'
      vim_item.menu = vim.fn.trim(vim_item.menu)

      local menu = vim_item.menu
      local maxwidth = 20
      if #menu > maxwidth then
        local truncated_menu = vim.fn.strcharpart(menu, 0, maxwidth)
        local i = maxwidth
        -- 可能包含中文
        while vim.fn.strdisplaywidth(truncated_menu) > maxwidth do
          i = i - 1
          truncated_menu = vim.fn.strcharpart(menu, 0, i)
        end
        vim_item.menu = truncated_menu .. '⋯'
      end

      return vim_item
    end,
  },
}

cmp.setup.cmdline(':', {
  sources = { { name = 'cmdline', keyword_length = 3 } },
  ---@diagnostic disable-next-line: missing-fields
  formatting = { fields = { 'abbr' } },
  mapping = {
    ['<Tab>'] = {
      c = function()
        if not cmp.visible() then cmp.complete() end
        cmp.select_next_item { behavior = types.cmp.SelectBehavior.Insert }
      end,
    },
    ['<S-Tab>'] = {
      c = function()
        if not cmp.visible() then cmp.complete() end
        cmp.select_prev_item { behavior = types.cmp.SelectBehavior.Insert }
      end,
    },
  },
})
