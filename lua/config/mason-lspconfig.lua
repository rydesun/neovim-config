local lspconfig = require('lspconfig')

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
          runtime = {
            version = 'LuaJIT',
          },
          diagnostics = {
            globals = {'vim'},
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
          },
          telemetry = {
            enable = false,
          },
        }
      }
    }
  end,

  pylsp = function()
    lspconfig.pylsp.setup {
      settings = {
        pylsp = {
          plugins = {
            flake8 = {
              enabled = true
            }
          }
        }
      }
    }
  end,
})
