local M = {}

---@class LazyHelperOpts
---@field cond? boolean
---@field very_lazy? boolean
---@field spec table[]
---@param opts LazyHelperOpts
function M.hook(opts)
  for _, plugin in pairs(opts.spec) do
    if opts.very_lazy and plugin.lazy == nil
        and not plugin.cmd and not plugin.ft
        and not plugin.keys and plugin.event == nil then
      plugin.event = 'VeryLazy'
    end

    if plugin.cond == nil then
      plugin.cond = opts.cond
    else
      plugin.cond = opts.cond and plugin.cond
    end

    M.set_config_file(plugin)
    if type(plugin.dependencies) == 'table' then
      for _, dep in pairs(plugin.dependencies) do
        if type(dep) == 'table' then M.set_config_file(dep) end
      end
    end
  end
  return opts.spec
end

function M.set_config_file(plugin)
  if plugin.opts_file == true then
    plugin.opts = M.loading()
  elseif type(plugin.opts_file) == 'string' then
    plugin.opts = M.loading(plugin.opts_file)
  elseif plugin.config_file == true then
    plugin.config = M.loading()
  elseif type(plugin.config_file) == 'string' then
    plugin.config = M.loading(plugin.config_file)
  elseif plugin.init_file == true then
    plugin.init = M.loading()
  elseif type(plugin.init_file) == 'string' then
    plugin.init = M.loading(plugin.init_file)
  end
end

function M.loading(name)
  return function(lazy_plugin)
    if name == nil then
      name = vim.fn.fnamemodify(lazy_plugin.name, ':r')
    end
    return require('plugins.configs.' .. name)
  end
end

return M.hook
