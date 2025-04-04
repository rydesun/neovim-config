---@module 'lazy'
---@class LazyHelperPluginSpec: LazyPluginSpec
---@field opts_file? string|true
---@field config_file? string|true
---@field init_file? string|true
---@field dependencies? string|(string|LazyHelperPluginSpec)[]

local M = {}

---@class LazyHelperOpts
---@field cond? boolean
---@field very_lazy? boolean
---@field spec LazyHelperPluginSpec[]
---@param opts LazyHelperOpts
---@return LazyHelperPluginSpec[]
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
    local deps = plugin.dependencies
    if type(deps) == 'table' then
      for _, dep in pairs(deps) do
        if type(dep) == 'table' then M.set_config_file(dep) end
      end
    end
  end
  return opts.spec
end

---@param plugin LazyHelperPluginSpec
---@return nil
function M.set_config_file(plugin)
  if plugin.opts_file then
    plugin.opts = M.loading(plugin.opts_file)
  elseif plugin.config_file then
    plugin.config = M.loading(plugin.config_file)
  elseif plugin.init_file then
    plugin.init = M.loading(plugin.init_file)
  end
end

---@param filename string|true
---@return fun(lazy_plugin: LazyPlugin): table?
function M.loading(filename)
  return function(lazy_plugin)
    if filename == true then
      filename = vim.fn.fnamemodify(lazy_plugin.name, ':r')
    end
    return require('plugins.configs.' .. filename)
  end
end

return M.hook
