M = {}

local searcher = require 'rooter.searcher'

function M.setup(rules)
  M.rules = rules
  M.pinned_rootpaths = {}
  M.disabled = false

  vim.api.nvim_create_autocmd('BufEnter',
    { pattern = '*', callback = M.set_buffer_cwd })

  vim.api.nvim_create_user_command(
    'RooterPin',
    function(opts)
      local dir = vim.fn.fnamemodify(opts.args, ':p')
      if dir:sub(-1) ~= '/' then
        vim.notify('rooter: Invalid dir: ' .. dir, vim.log.levels.ERROR)
        return
      end
      M.pin_rootpath(dir)
      M.set_buffer_cwd() -- pin后需要立即生效
      M.inspect()
    end,
    { nargs = 1, complete = 'dir' })

  vim.api.nvim_create_user_command(
    'RooterUnpinAll',
    function()
      M.unpin_all()
      M.inspect()
    end,
    {})

  vim.api.nvim_create_user_command(
    'RooterInspect',
    function() M.inspect() end,
    {})

  vim.api.nvim_create_user_command(
    'RooterDisable',
    function() M.disabled = true end,
    {})

  vim.api.nvim_create_user_command(
    'RooterEnable',
    function() M.disabled = false end,
    {})
end

function M.set_buffer_cwd()
  if M.disabled then return end

  -- 跳过特殊类型的buffer
  if vim.o.buftype ~= '' then return end

  -- 优先选择pinned dir
  local pinned_rootpath = M.get_pinned_rootpath()
  if pinned_rootpath then
    M._lcd(pinned_rootpath)
    return
  end

  -- 设置rootpath变量然后改变cwd
  if vim.b.rootpath == nil then vim.b.rootpath = M.get_rootpath() end
  M._lcd(vim.b.rootpath)
end

function M._lcd(dir)
  -- BufEnter事件触发，不要报错
  if vim.fn.isdirectory(dir) then -- 目录可能未创建
    pcall(vim.cmd.lcd, dir)       -- 可忽略权限错误
  end
end

function M.pin_rootpath(dir)
  for _, pinned_rootpath in ipairs(M.pinned_rootpaths) do
    if dir == pinned_rootpath then return end
  end
  table.insert(M.pinned_rootpaths, dir)
end

function M.unpin_all()
  M.pinned_rootpaths = {}
end

function M.get_pinned_rootpath()
  if #M.pinned_rootpaths == 0 then return end
  local current_dir = vim.fn.expand '%:p:h' .. '/'
  for _, pinned_rootpath in ipairs(M.pinned_rootpaths) do
    if current_dir:sub(1, #pinned_rootpath) == pinned_rootpath then
      return pinned_rootpath
    end
  end
end

function M.get_rootpath()
  local start_dir = vim.fn.expand '%:p:h'
  local found_dir = searcher.search(start_dir, M.rules)
  return found_dir and found_dir or start_dir
end

function M.inspect()
  if #M.pinned_rootpaths > 0 then
    local list = table.concat(M.pinned_rootpaths, '\n')
    vim.notify('rooter: pinned dirs:\n' .. list)
  else
    vim.notify 'rooter: pinned dirs: {}'
  end
end

return M
