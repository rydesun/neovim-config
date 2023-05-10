local M = {}

function M.setup()
  vim.o.tabline = [[%{%v:lua.require('tabline').draw()%}]]

  vim.api.nvim_create_autocmd({ 'TermClose' }, {
    pattern = { '*' },
    callback = function(msg)
      local bufnr = msg.buf
      vim.api.nvim_buf_set_var(bufnr, 'term_exit_code', vim.v.event.status)
      vim.api.nvim_command('redrawtabline')
    end
  })
end

local function title(bufnr)
  local bufname = vim.api.nvim_buf_get_name(bufnr)
  local filetype = vim.api.nvim_buf_get_option(bufnr, 'filetype')
  local buftype = vim.api.nvim_buf_get_option(bufnr, 'buftype')

  if buftype == 'terminal' then
    local ok, exit_code = pcall(vim.api.nvim_buf_get_var, bufnr, 'term_exit_code')
    if not ok then
      return ' '
    elseif exit_code == 0 then
      return '✔'
    else
      return '✖'
    end
  end
  return (bufname ~= '') and vim.fn.fnamemodify(bufname, ':t')
      or (filetype ~= '') and filetype
      or ' '
end

function M.draw()
  local tabline = {}

  for _, tabpage in ipairs(vim.api.nvim_list_tabpages()) do
    local bufnr = vim.api.nvim_win_get_buf(vim.api.nvim_tabpage_get_win(tabpage))
    local is_selected = tabpage == vim.api.nvim_get_current_tabpage()
    local hl_tab = is_selected and '%#TabLineSel#' or '%#TabLine#'
    local hl_space = '%#TabLineFill#'

    local label = {
      hl_tab, ' ', title(bufnr), ' ',
      -- 两个标签的中间
      hl_space, ' ',
    }
    table.insert(tabline, table.concat(label))
  end

  return table.concat(tabline)
end

return M
