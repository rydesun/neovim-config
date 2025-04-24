local cfg = { settings = {} }

local ok, schemastore = pcall(require, 'schemastore')
if ok then
  cfg.settings.yaml = {
    schemaStore = { enable = false, url = '' },
    schemas = schemastore.yaml.schemas(),
  }
end

return cfg
