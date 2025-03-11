local lspconfig = require 'lspconfig'

local capabilities = require 'cmp_nvim_lsp'.default_capabilities()
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false, lineFoldingOnly = true,
}

local handlers = {
  -- mason安装的ls如果没有单独配置，则使用此配置
  function(name) lspconfig[name].setup { capabilities = capabilities } end,
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

handlers.basedpyright = function(name)
  local settings = {
    basedpyright = {
      analysis = {
        diagnosticMode = 'workspace',
        -- 允许忽略未知类型错误，需要在pyproject.toml里修改回strict
        typeCheckingMode = 'standard',
      },
    },
  }
  lspconfig[name].setup { capabilities = capabilities, settings = settings }
end

handlers.ruff = function(name)
  local init_options = {
    -- 让basedpyright提供lint，ruff只提供format
    settings = { lint = { enable = false } },
  }
  lspconfig[name].setup {
    capabilities = capabilities,
    init_options = init_options,
  }
end

-- 关闭ruff的hover，只用basedpyright提供的hover
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp_attach_disable_ruff_hover',
    { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then return end
    if client.name == 'ruff' then
      client.server_capabilities.hoverProvider = false
    end
  end,
  desc = 'LSP: Disable hover capability from Ruff',
})

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
    -- 让prettier来格式化
    init_options = { provideFormatter = false },
  }
end

require 'mason-lspconfig'.setup { handlers = handlers }
