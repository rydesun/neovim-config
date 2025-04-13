local cfg = { settings = {} }
cfg.settings.json = {
  schemas = require 'schemastore'.json.schemas(),
  validate = { enable = true },
}
cfg.on_attach = function(client)
  -- 让prettier来格式化
  client.server_capabilities.documentFormattingProvider = false
end
return cfg
