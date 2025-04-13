local cfg = { settings = {} }

local ok, schemastore = pcall(require, 'schemastore')
if ok then
  cfg.settings.json = {
    schemas = schemastore.json.schemas(),
    validate = { enable = true },
  }
end

cfg.on_attach = function(client)
  -- 让prettier来格式化
  client.server_capabilities.documentFormattingProvider = false
end

return cfg
