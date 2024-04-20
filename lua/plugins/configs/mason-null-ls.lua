local null_ls = require 'null-ls'

return {
  automatic_setup = true,
  handlers = {
    markdownlint = function()
      null_ls.register(null_ls.builtins.formatting.markdownlint)
      null_ls.register(null_ls.builtins.diagnostics.markdownlint.with {
        diagnostic_config = {
          underline = false,
          virtual_text = false,
        },
        diagnostics_postprocess = function(diagnostic)
          diagnostic.severity = vim.diagnostic.severity.HINT
        end,
      })
    end,
  }
}
