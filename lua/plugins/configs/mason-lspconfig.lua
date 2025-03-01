local lspconfig = require 'lspconfig'
local capabilities = require 'cmp_nvim_lsp'.default_capabilities()
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false, lineFoldingOnly = true,
}

local handlers = {
  function(server_name)
    lspconfig[server_name].setup { capabilities = capabilities }
  end
}

handlers.lua_ls = function()
  local settings = {}
  settings.Lua = {
    runtime = { version = 'LuaJIT' },
    workspace = {
      checkThirdParty = false,
      library = {
        vim.env.VIMRUNTIME,
        '${3rd}/luv/library',
      },
    },
  }
  lspconfig.lua_ls.setup {
    capabilities = capabilities,
    settings = settings,
  }
end

handlers.jsonls = function()
  capabilities.documentFormattingProvider = false
  local settings = {}
  settings.json = {
    schemas = require 'schemastore'.json.schemas(),
    validate = { enable = true },
  }
  lspconfig.jsonls.setup {
    capabilities = capabilities,
    settings = settings,
  }
end

handlers.yamlls = function()
  local settings = {}
  settings.yaml = {
    schemaStore = { enable = false, url = '' },
    schemas = require 'schemastore'.yaml.schemas(),
  }
  lspconfig.yamlls.setup {
    capabilities = capabilities,
    settings = settings,
  }
end

handlers.cssls = function()
  lspconfig.cssls.setup {
    capabilities = capabilities,
    init_options = { provideFormatter = false },
  }
end

require 'mason-lspconfig'.setup { handlers = handlers }
