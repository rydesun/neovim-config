local null_ls = require 'null-ls'

null_ls.setup {
  sources = {
    -- python
    null_ls.builtins.diagnostics.flake8.with {
      diagnostics_postprocess = function(diagnostic)
        diagnostic.severity = vim.diagnostic.severity["HINT"]
      end,
    },
    null_ls.builtins.formatting.autopep8,
    null_ls.builtins.formatting.isort,
  },
}
