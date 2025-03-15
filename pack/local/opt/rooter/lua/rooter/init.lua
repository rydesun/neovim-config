M = {}

local lib = require 'rooter.lib'

function M.setup(rules)
  M.pinned = {}

  vim.api.nvim_create_autocmd(
    { 'VimEnter', 'BufReadPost', 'BufEnter', 'BufWritePost' }, {
      pattern = { '*' },
      callback = function()
        if M.disabled then return end

        -- 跳过特殊类型的buffer
        if vim.o.buftype ~= '' then return end

        -- 优先选择pinned dir
        if #M.pinned > 0 then
          local current_dir = vim.fn.expand '%:p:h'
          for _, dir in ipairs(M.pinned) do
            if current_dir:sub(1, string.len(dir)) == dir then
              vim.cmd('silent! lcd ' .. dir)
              return
            end
          end
        end

        -- 设置rootpath变量然后改变cwd
        if vim.b.rootpath == nil then lib.set_bufvar_rootpath(rules) end
        local dir = vim.b.rootpath
        if vim.fn.isdirectory(dir) then
          vim.cmd('silent! lcd ' .. dir)
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
