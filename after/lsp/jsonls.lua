local cfg = { settings = {} }

-- 用prettier格式化
cfg.init_options = { provideFormatter = false }

local ok, schemastore = pcall(require, 'schemastore')
if ok then
  cfg.settings.json = {
    schemas = schemastore.json.schemas(),
    validate = { enable = true },
  }
end

return cfg
