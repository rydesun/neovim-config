M = {}

local lib = require 'rooter.lib'

function M.setup(right_own, left_own, right_names)
  M.pinned = {}

  vim.api.nvim_create_autocmd(
    { 'VimEnter', 'BufReadPost', 'BufEnter', 'BufWritePost' }, {
      pattern = { '*' },
      callback = function()
        if M.disabled then return end
        if vim.o.buftype ~= '' then return end

        local current_dir = vim.fn.expand '%:p:h'
        for _, dir in ipairs(M.pinned) do
          if current_dir:sub(1, string.len(dir)) == dir then
            pcall(vim.api.nvim_command, 'lcd ' .. dir)
            return
          end
        end

        local dir = lib.get(right_own, left_own, right_names)
        if vim.fn.isdirectory(dir) then
          pcall(vim.api.nvim_command, 'lcd ' .. dir)
        end
      end,
    })

  vim.api.nvim_create_user_command(
    'RooterPin',
    function(opts)
      local dir = vim.fn.fnamemodify(opts.args, ':p')
      if dir:sub(-1) == '/' then dir = dir:sub(1, -2) end
      M.pinned = { dir }
      vim.api.nvim_command('lcd ' .. dir)
    end,
    { nargs = 1, complete = 'dir' })

  vim.api.nvim_create_user_command(
    'RooterDisable',
    function() M.disabled = true end,
    {})

  vim.api.nvim_create_user_command(
    'RooterEnable',
    function() M.disabled = false end,
    {})
end

return M
