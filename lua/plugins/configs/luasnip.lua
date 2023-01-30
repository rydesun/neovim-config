require 'luasnip.loaders.from_snipmate'.lazy_load {
  paths = { '~/.config/snippets' }
}

return {
  -- 退出后允许回跳
  history = true,
}
