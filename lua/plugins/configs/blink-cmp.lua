---@module 'blink.cmp'
---@type blink.cmp.Config
local opts = { completion = {} }
opts.completion.menu = {
  border = 'rounded',
  winhighlight = '',
  draw = {
    columns = { { 'label' }, { 'kind_icon', 'label_description', gap = 1 } },
  },
}
opts.completion.documentation = {
  window = { border = 'rounded', winhighlight = '' },
  auto_show = true,
}
opts.appearance = { kind_icons = require 'libs.style'.symbols() }

opts.completion.accept = { auto_brackets = { enabled = false } }

-- 使用luasnip API跳转LSP提供的snippets
opts.snippets = { preset = 'luasnip' }
opts.sources = {
  -- 不要显示luasnip提供的snippets，只用luasnip API展开
  default = { 'lsp', 'buffer', 'path' },
  per_filetype = {
    lua = { 'lazydev', 'lsp', 'buffer', 'path' },
    ['rip-substitute'] = {}, -- 应该手动调用show函数
  },
}
opts.sources.providers = {
  lazydev = {
    name = 'LazyDev',
    module = 'lazydev.integrations.blink',
    score_offset = 100,
  },
  ripgrep = {
    name = 'Ripgrep',
    module = 'blink-ripgrep',
    ---@module "blink-ripgrep"
    ---@type blink-ripgrep.Options
    opts = {
      prefix_min_len = 1,
    },
    transform_items = function(_, items)
      for _, item in ipairs(items) do item.kind_icon = 'rg' end
      return items
    end,
  },
  buffer = {
    -- 来源是buffer则不需要显示图标
    transform_items = function(_, items)
      for _, item in ipairs(items) do item.kind_icon = '' end
      return items
    end,
  },
  cmdline = {
    -- cmdline补全时不需要显示图标
    transform_items = function(_, items)
      for _, item in ipairs(items) do item.kind_icon = '' end
      return items
    end,
  },
  path = {
    transform_items = function(_, items)
      local ok, devicons = pcall(require, 'nvim-web-devicons')
      if not ok then return items end
      for _, item in ipairs(items) do
        local icon, hl = devicons.get_icon(item.label)
        if icon then item.kind_icon = icon end
        if hl then item.kind_hl = hl end
      end
      return items
    end,
  },
}

opts.keymap = {
  ['<C-e>'] = {}, -- 留给<End>
  ['<Tab>'] = {},
  ['<S-Tab>'] = {},
  ['<C-l>'] = { 'show', 'select_and_accept', 'fallback' },
  ['<C-u>'] = { 'cancel', 'fallback' },
}

opts.cmdline = {
  completion = {
    menu = { auto_show = function() return #vim.fn.getcmdline() > 2 end },
    ghost_text = { enabled = false },
  },
  keymap = {
    ['<C-n>'] = {},
    ['<C-p>'] = {},
    ['<C-e>'] = {},
    ['<C-l>'] = { 'select_and_accept', 'fallback' },
    ['<C-u>'] = { 'cancel', 'fallback' },
  },
}

return opts
