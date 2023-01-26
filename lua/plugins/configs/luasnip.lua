require 'luasnip.loaders.from_snipmate'.lazy_load {
  paths = { '~/.config/snippets' }
}

require 'luasnip'.setup {
  -- 退出后允许回跳
  history = true,
}
