local cfg = { settings = {} }
cfg.settings.basedpyright = {
  analysis = {
    diagnosticMode = 'workspace',

    -- 允许忽略未知类型错误，可以在pyproject.toml里修改回strict
    typeCheckingMode = 'standard',
  },
}
return cfg
