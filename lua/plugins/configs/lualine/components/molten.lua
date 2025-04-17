local M = require 'lualine.component':extend()

function M:init(options)
  M.super.init(self, options)
  -- 不要直接用require'molten.status'.initialized()获取Jupyter状态，
  -- 否则会等待插件加载
  vim.api.nvim_create_autocmd('User', {
    pattern = 'MoltenKernelReady',
    callback = function() self.molten_is_ready = true end,
  })
end

function M:update_status()
  if not self.molten_is_ready then return end
  return (' (%s)'):format(require 'molten.status'.kernels())
end

return M
