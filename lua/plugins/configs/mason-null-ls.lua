local null_ls = require 'null-ls'
local mason_null_ls = require 'mason-null-ls'

vim.schedule(null_ls.setup)

mason_null_ls.setup {
  automatic_setup = true,
  handlers = {
    flake8 = function()
      null_ls.register(null_ls.builtins.diagnostics.flake8.with {
        diagnostics_postprocess = function(diagnostic)
          diagnostic.severity = vim.diagnostic.severity["HINT"]
        end,
      })
    end,
    markdownlint = function()
      null_ls.register(null_ls.builtins.formatting.markdownlint)
      null_ls.register(null_ls.builtins.diagnostics.markdownlint.with {
        diagnostic_config = {
          underline = false,
          virtual_text = false,
        },
        diagnostics_postprocess = function(diagnostic)
          diagnostic.severity = vim.diagnostic.severity["HINT"]
        end,
      })
    end,
  }
}
