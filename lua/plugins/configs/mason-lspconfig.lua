local lspconfig = require 'lspconfig'
local capabilities = require 'cmp_nvim_lsp'.default_capabilities()
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true
}

require 'mason-lspconfig'.setup()
require 'mason-lspconfig'.setup_handlers {
  function(server_name)
    lspconfig[server_name].setup { capabilities = capabilities }
  end,

  lua_ls = function()
    lspconfig.lua_ls.setup {
      capabilities = capabilities,
      settings = {
        Lua = {
          runtime = { version = 'LuaJIT' },
          diagnostics = { globals = { 'vim' } },
          workspace = {
            library = vim.api.nvim_list_runtime_paths(),
            checkThirdParty = false,
          },
        }
      }
    }
  end,

  pyright = function()
    local default_config = require 'lspconfig.configs.pyright'
        .default_config
    lspconfig.pyright.setup {
      capabilities = capabilities,
      settings = {
        python = {
          analysis = {
            diagnosticSeverityOverrides = {
              reportOptionalMemberAccess = 'warning',
              reportPrivateImportUsage = 'information',
              reportWildcardImportFromLibrary = 'information',
            }
          },
        },
      },
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

  cssls = function()
    lspconfig.cssls.setup {
      capabilities = capabilities,
      init_options = {
        provideFormatter = false, -- 只用 prettier
      },
    }
  end,

  stylelint_lsp = function()
    lspconfig.cssls.setup {
      filetypes = { 'css', 'scss', 'less' },
      capabilities = capabilities,
    }
  end,

  yamlls = function()
    lspconfig.yamlls.setup {
      capabilities = capabilities,
      settings = {
        yaml = {
          schemas = require 'schemastore'.yaml.schemas(),
        },
      },
    }
  end,
}

-- 使用系统端安装的包
if vim.fn.executable 'clangd' > 0 then
  lspconfig.clangd.setup { capabilities = capabilities }
end
if vim.fn.executable 'haskell-language-server' > 0 then
  lspconfig.hls.setup { capabilities = capabilities }
end
