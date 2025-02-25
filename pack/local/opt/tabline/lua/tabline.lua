local M = {}

local default_opts = {
  terminal = '%%',
  terminal_ok = '☻',
  terminal_fail = 'x',
}

function M.setup(opts)
  vim.o.tabline = [[%{%v:lua.require('tabline').draw()%}]]
  M.opts = vim.tbl_deep_extend('keep', opts or {}, default_opts)

  vim.api.nvim_create_autocmd('TermClose', {
    pattern = '*',
    callback = function(msg)
      pcall(
        vim.api.nvim_buf_set_var,
        msg.buf,
        'term_exit_code',
        vim.v.event.status
      )
      vim.cmd 'redrawtabline'
    end
  })
end

function M.term_title(bufnr)
  local ok, exit_code = pcall(vim.api.nvim_buf_get_var, bufnr, 'term_exit_code')
  if not ok then return M.opts.terminal end
  return exit_code == 0 and M.opts.terminal_ok or M.opts.terminal_fail
end

function M.custom_title(index, tabpage)
  local bufnr = vim.api.nvim_win_get_buf(vim.api.nvim_tabpage_get_win(tabpage))
  local buftype = vim.api.nvim_get_option_value('buftype', { buf = bufnr })
  return (buftype == 'terminal') and M.term_title(bufnr) or index
end

function M.draw()
  local tabline = {}

  for i, tabpage in ipairs(vim.api.nvim_list_tabpages()) do
    local is_selected = tabpage == vim.api.nvim_get_current_tabpage()
    local hl_tab = is_selected and '%#TabLineSel#' or '%#TabLine#'

    local label = { hl_tab, ' ', M.custom_title(i, tabpage), ' ' }
    table.insert(tabline, table.concat(label))
  end

  local hl_space = '%#TabLineFill#'
  local hl_sep = hl_space
  local sep = hl_sep .. ' '
  return table.concat(tabline, sep) .. hl_space
end

return M
