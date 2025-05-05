local M = {}

vim.api.nvim_create_user_command('IndentNavPrev',
  function() M.nav_indent(false) end, {})
vim.api.nvim_create_user_command('IndentNavNext',
  function() M.nav_indent(true) end, {})

---@param forward boolean
function M.nav_indent(forward)
  local cur_line = vim.api.nvim_win_get_cursor(0)[1]
  local cur_virtcol = vim.fn.virtcol '.'
  local cur_indent = vim.fn.indent(cur_line)
  local target_indent = cur_virtcol - 1 < cur_indent and cur_virtcol - 1 or
      cur_indent

  local l_start, l_end, step
  if forward then
    l_start, l_end, step = cur_line + 1, vim.api.nvim_buf_line_count(0), 1
  else
    l_start, l_end, step = cur_line - 1, 1, -1
  end
  for l = l_start, l_end, step do
    if vim.fn.indent(l) == target_indent then
      if not vim.fn.getline(l):match '^$' then
        M.goto_visual_col(l, cur_virtcol)
        return
      end
    end
  end
end

--- 移动光标到指定行和视觉列（virtcol）
--- @param target_line number 目标行（1-based）
--- @param target_virtcol number 目标视觉列（1-based）
function M.goto_visual_col(target_line, target_virtcol)
  vim.api.nvim_win_set_cursor(0, { target_line, 0 })
  vim.cmd('normal! ' .. target_virtcol .. '|')
end
