require 'luasnip.loaders.from_vscode'.lazy_load { paths = { './snippets' } }

return {
  keep_roots = true,
  link_roots = true,
  link_children = true,
}
