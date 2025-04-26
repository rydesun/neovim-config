local M = require 'lualine.component':extend()

M.processing = false
M.spinner_index = 1

local spinner_symbols = { '', '', '', '', '', '' }
local spinner_symbols_len = #spinner_symbols

function M:init(options)
  M.super.init(self, options)

  vim.api.nvim_create_autocmd({ 'User' }, {
    pattern = 'CodeCompanionRequest*',
    group = vim.api.nvim_create_augroup('CodeCompanionHooks', {}),
    callback = function(request)
      if request.match == 'CodeCompanionRequestStarted' then
        self.processing = true
      elseif request.match == 'CodeCompanionRequestFinished' then
        self.processing = false
      end
    end,
  })
end

function M:update_status()
  if self.processing then
    self.spinner_index = (self.spinner_index % spinner_symbols_len) + 1
    return spinner_symbols[self.spinner_index] .. 'AI'
  end
end

return M
