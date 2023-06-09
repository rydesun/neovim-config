M = {}

local lib = require 'rooter.lib'

function M.setup(right_own, left_own, right_names)
  vim.api.nvim_create_autocmd(
    { 'VimEnter', 'BufReadPost', 'BufEnter', 'BufWritePost' }, {
    pattern = { '*' },
    callback = function()
      if vim.w.rooter_disabled or vim.t.rooter_disabled then return end
      if vim.o.buftype ~= '' then return end

      local p = lib.get(right_own, left_own, right_names)
      if vim.fn.isdirectory(p) then
        pcall(vim.api.nvim_command, 'lcd ' .. p)
      end
    end,
  })

  vim.api.nvim_create_user_command(
    'RooterLcd',
    function(opts)
      vim.api.nvim_command('lcd ' .. opts.args)
      vim.w.rooter_disabled = true
    end,
    { nargs = 1, complete = 'dir' })

  vim.api.nvim_create_user_command(
    'RooterTcd',
    function(opts)
      vim.api.nvim_command('tcd ' .. opts.args)
      vim.t.rooter_disabled = true
    end,
    { nargs = 1, complete = 'dir' })

  vim.api.nvim_create_user_command(
    'RooterDisable',
    function()
      vim.w.rooter_disabled = true
      vim.t.rooter_disabled = true
    end,
    {})

  vim.api.nvim_create_user_command(
    'RooterEnable',
    function()
      vim.w.rooter_disabled = false
      vim.t.rooter_disabled = false
    end,
    {})
end

return M
