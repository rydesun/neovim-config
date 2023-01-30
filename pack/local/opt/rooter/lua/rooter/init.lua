M = {}

local lib = require 'rooter.lib'

function M.setup(patterns)
  if type(patterns) ~= 'table' or #patterns == 0 then error 'bad arg' end

  vim.api.nvim_create_autocmd(
    { 'VimEnter', 'BufReadPost', 'BufEnter', 'BufWritePost' }, {
    pattern = { '*' },
    callback = function()
      if vim.w.rooter_disabled == true then return end
      if vim.o.buftype ~= '' then return end

      local p = lib.get(patterns)
      if vim.fn.isdirectory(p) then
        pcall(function() vim.api.nvim_command('lcd ' .. p) end)
      end
    end,
  })

  vim.api.nvim_create_user_command(
    'RooterLcd',
    function(opts)
      vim.w.rooter_disabled = true
      vim.api.nvim_command('lcd ' .. opts.args)
    end,
    { nargs = 1, complete = 'dir' })

  vim.api.nvim_create_user_command(
    'RooterDisable',
    function() vim.w.rooter_disabled = true end,
    {})

  vim.api.nvim_create_user_command(
    'RooterEnable',
    function() vim.w.rooter_disabled = false end,
    {})
end

return M
