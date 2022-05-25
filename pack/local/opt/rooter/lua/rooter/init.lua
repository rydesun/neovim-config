M = {}

local rootpath_patterns = {}

function M.setup(patterns)
  if type(patterns) ~= 'table' or #patterns == 0 then return end
  rootpath_patterns = patterns

  local lib = require('rooter.lib')
  vim.api.nvim_create_autocmd(
    {"VimEnter", "BufReadPost", "BufEnter", "BufWritePost"}, {
      pattern = {"*"},
      callback = function()
        if vim.o.buftype ~= '' then return end
        local p = lib.get(rootpath_patterns)
        if vim.fn.isdirectory(p) then
          pcall(function() vim.api.nvim_command('lcd '..p) end)
        end
      end,
    }
  )
end

return M
