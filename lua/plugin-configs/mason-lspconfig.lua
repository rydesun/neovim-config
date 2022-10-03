local lspconfig = require('lspconfig')
local util = require('lspconfig.util')

require'lua-dev'.setup {}
require'rust-tools'.setup {
  server = {
    settings = {
      ['rust-analyzer'] = {
        completion = {
          postfix = {
            enable = false
          },
          privateEditable = {
            enable = true
          }
        },
        imports = {
          -- 自动导入时优先以crate开头
          prefix = 'crate',
        }
      }
    }
  }
}

local null_ls = require 'null-ls'
local mason_null_ls = require 'mason-null-ls'

null_ls.setup()
mason_null_ls.setup()
mason_null_ls.setup_handlers {
  function(source_name)
    for _, method in pairs {
      'code_actions', 'completion', 'diagnostics', 'formatting', 'hover'
    } do
      local ok, builtin = pcall(require,
        string.format('null-ls.builtins.%s.%s', method, source_name))
      if ok then null_ls.register(builtin) end
    end
  end,

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

require('mason-lspconfig').setup()
require('mason-lspconfig').setup_handlers({
  function (server_name)
    lspconfig[server_name].setup{}
    local capabilities = require('cmp_nvim_lsp').update_capabilities(
      vim.lsp.protocol.make_client_capabilities())
    require('lspconfig')[server_name].setup{
      capabilities = capabilities
    }
  end,

  sumneko_lua = function()
    lspconfig.sumneko_lua.setup {
      settings = {
        Lua = {
          telemetry = {
            enable = true,
          },
        }
      }
    }
  end,

  pyright = function()
    local default_config = require(
      'lspconfig.server_configurations.pyright').default_config
    lspconfig.pyright.setup {
      root_dir = function(fname)
        return default_config.root_dir(fname) or util.find_git_ancestor(fname)
      end,
    }
  end,
})
