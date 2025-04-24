local M = {}

M.opts = {
  sep = ' ',
  terminal_running = '%%',
  terminal_ok = vim.g.env_no_icon and 'O' or '✔',
  terminal_fail = vim.g.env_no_icon and 'X' or '✖',
}

vim.o.tabline = [[%{%v:lua.Tabline()%}]]

-- Terminal在退出时记录状态
vim.api.nvim_create_autocmd('TermClose', {
  pattern = '*',
  callback = function(msg)
    pcall(vim.api.nvim_buf_set_var, msg.buf, 'exit_code', vim.v.event.status)
    vim.cmd 'redrawtabline'
  end,
})

function Tabline()
  local tabline = {}

  local cur_tabid = vim.api.nvim_get_current_tabpage()
  for i, tabid in ipairs(vim.api.nvim_list_tabpages()) do
    local is_selected = tabid == cur_tabid
    local hl_tab = is_selected and '%#TabLineSel#' or '%#TabLine#'

    local title = M.get_tab_title(i, tabid)
    local label = { hl_tab, '%' .. i .. 'T ', title, ' %T' }
    table.insert(tabline, table.concat(label))
  end

  local hl_space = '%#TabLineFill#'
  local hl_sep = hl_space
  local sep = hl_sep .. M.opts.sep
  return table.concat(tabline, sep) .. hl_space
end

function M.get_tab_title(index, tabid)
  local fmt = '%d %s'
  -- 如果有主动设置的标题，则直接使用
  local ok, tab_title = pcall(vim.api.nvim_tabpage_get_var, tabid, 'title')
  if ok and tab_title then return fmt:format(index, tab_title) end

  -- 优先选择当前焦点的buffer作为标题
  local winid = vim.api.nvim_tabpage_get_win(tabid)
  local bufid = vim.api.nvim_win_get_buf(winid)
  local buf_title = M.get_buf_title(bufid)
  if buf_title then return fmt:format(index, buf_title) end

  -- 如果当前焦点的buffer不是真实文件，则重新在其他buffers里寻找有效值
  local found, valid_filetype = M.find_valid_buf_title(tabid, bufid)
  if found then return fmt:format(index, valid_filetype) else return index end
end

function M.get_buf_title(bufid)
  local buftype = vim.api.nvim_get_option_value('buftype', { buf = bufid })
  if buftype == 'help' then return 'help' end
  if buftype == 'terminal' then return '[Term] ' .. M.get_term_status(bufid) end

  local filetype = vim.api.nvim_get_option_value('filetype', { buf = bufid })
  if vim.startswith(filetype, 'Neogit') then return filetype end

  local buflisted = vim.api.nvim_get_option_value('buflisted', { buf = bufid })
  if not buflisted then return end

  if buftype == '' and filetype ~= '' then return filetype end
end

function M.find_valid_buf_title(tabid, exclude_bufid)
  local win_list = vim.api.nvim_tabpage_list_wins(tabid)
  if #win_list < 2 then return false end
  for _, winid in ipairs(win_list) do
    local bufid = vim.api.nvim_win_get_buf(winid)
    if bufid ~= exclude_bufid then
      local buf_title = M.get_buf_title(bufid)
      if buf_title then return true, buf_title end
    end
  end
end

function M.get_term_status(bufid)
  local ok, exit_code = pcall(vim.api.nvim_buf_get_var, bufid, 'exit_code')
  if not ok then return M.opts.terminal_running end
  if exit_code == 0 then
    return M.opts.terminal_ok
  else
    return string.format('%s (%d)', M.opts.terminal_fail, exit_code)
  end
end
