local cfg = { settings = {} }
cfg.settings.yaml = {
  schemaStore = { enable = false, url = '' },
  schemas = require 'schemastore'.yaml.schemas(),
}
return cfg
