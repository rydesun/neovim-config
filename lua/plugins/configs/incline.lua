vim.api.nvim_create_user_command('InclineWink', function()
  local ok, incline = pcall(require, 'incline')
  if not ok then return end
  incline.toggle()
  vim.defer_fn(function() incline.toggle() end, 2000)
end, {})

return {
  hide = {
    -- 当前窗口不显示
    focused_win = true,
    -- 只有一个窗口时不显示
    only_win = 'count_ignored',
  },

  window = {
    margin = { horizontal = 0, vertical = 0 },
    zindex = 1,
  },

  render = function(props)
    local focused_buf = vim.fn.bufnr '%'
    -- 与当前buffer相同时，不显示
    if props.buf == focused_buf then return nil end
    local bufname = vim.api.nvim_buf_get_name(props.buf)
    if bufname == '' then return nil end

    local prefix = ''
    -- 判断是否在同一个cwd
    local focused_cwd = vim.fn.getcwd()
    local cwd = vim.fn.getcwd(props.win)
    if focused_cwd ~= cwd then prefix = prefix .. ' ' end

    -- 判断是否平级
    local parent = vim.fn.fnamemodify(bufname, ':h')
    local focused_parent = vim.fn.fnamemodify(
      vim.api.nvim_buf_get_name(focused_buf), ':h'
    )
    if parent == focused_parent then prefix = prefix .. '󰿡 ' end

    return prefix .. vim.fn.fnamemodify(bufname, ':t')
  end,
}
