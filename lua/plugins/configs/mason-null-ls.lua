local null_ls = require 'null-ls'

return {
  automatic_setup = true,
  handlers = {
    markdownlint = function()
      null_ls.register(null_ls.builtins.diagnostics.markdownlint.with {
        diagnostic_config = { underline = false, virtual_text = false },
      })
    end,
  }
}
