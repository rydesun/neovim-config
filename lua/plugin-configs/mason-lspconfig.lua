require'lua-dev'.setup {}

local lspconfig = require('lspconfig')
local util = require('lspconfig.util')

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
