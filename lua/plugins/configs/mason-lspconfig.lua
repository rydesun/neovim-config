local lspconfig = require 'lspconfig'

local capabilities = require 'cmp_nvim_lsp'.default_capabilities()
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false, lineFoldingOnly = true,
}

local handlers = {
  -- mason安装的ls如果没有单独配置，则使用此配置
  function(name) lspconfig[name].setup { capabilities = capabilities } end
}

handlers.lua_ls = function(name)
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
  lspconfig[name].setup { capabilities = capabilities, settings = settings }
end

handlers.jsonls = function(name)
  local settings = {}
  settings.json = {
    schemas = require 'schemastore'.json.schemas(),
    validate = { enable = true },
  }
  lspconfig[name].setup {
    capabilities = capabilities,
    settings = settings,
    on_attach = function(client)
      -- 让prettier来格式化
      client.server_capabilities.documentFormattingProvider = false
    end,
  }
end

handlers.yamlls = function(name)
  local settings = {}
  settings.yaml = {
    schemaStore = { enable = false, url = '' },
    schemas = require 'schemastore'.yaml.schemas(),
  }
  lspconfig[name].setup { capabilities = capabilities, settings = settings }
end

handlers.cssls = function(name)
  lspconfig[name].setup {
    capabilities = capabilities,
    init_options = { provideFormatter = false },
  }
end

require 'mason-lspconfig'.setup { handlers = handlers }
