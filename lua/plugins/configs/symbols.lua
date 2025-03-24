local r = require 'symbols.recipes'
r.AsciiSymbols.providers.lsp.kinds.jsonc =
    r.AsciiSymbols.providers.lsp.kinds.json

require 'symbols'.setup(r.DefaultFilters, r.AsciiSymbols, {
  sidebar = {
    hide_cursor = false,
    show_inline_details = true,
    auto_resize = {
      min_width = 30,
    },
    chars = { folded = '+', unfolded = '-' },
  },
  providers = {
    lsp = {
      kinds = { default = require 'libs.style'.symbols(true) },
    },
  },
})
