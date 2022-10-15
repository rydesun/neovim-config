require 'mason'.setup {}

require 'rust-tools'.setup {
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
  },
  tools = {
    inlay_hints = {
      highlight = 'InlayHint',
      other_hints_prefix = '⇒ ',
      show_parameter_hints = false,
    },
    hover_actions = {
      auto_focus = true,
    },
  }
}

local lspconfig = require('lspconfig')
local util = require('lspconfig.util')
local capabilities = require 'cmp_nvim_lsp'.default_capabilities()
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true
}

require('mason-lspconfig').setup()
require('mason-lspconfig').setup_handlers({
  function (server_name)
    lspconfig[server_name].setup {
      capabilities = capabilities
    }
  end,

  sumneko_lua = function()
    lspconfig.sumneko_lua.setup {
      capabilities = capabilities,
      settings = {
        Lua = {
          runtime = { version = 'LuaJIT' },
          diagnostics = { globals = { 'vim' } },
          workspace = { library = vim.api.nvim_list_runtime_paths() },
          -- 开启遥测
          telemetry = { enable = true },
        }
      }
    }
  end,

  pyright = function()
    local default_config = require(
      'lspconfig.server_configurations.pyright').default_config
    lspconfig.pyright.setup {
      capabilities = capabilities,
      root_dir = function(fname)
        return default_config.root_dir(fname) or util.find_git_ancestor(fname)
      end,
    }
  end,

  jsonls = function()
    lspconfig.jsonls.setup {
      capabilities = capabilities,
      on_attach = function(client, _)
        client.server_capabilities.documentFormattingProvider = false
      end,
      settings = {
        json = {
          schemas = require 'schemastore'.json.schemas(),
          validate = { enable = true },
        }
      },
    }
  end,
})
