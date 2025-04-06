local M = {
  fold_sign = '%#Folded#%=',
  fold_sign_nested = '%#Folded#%=*',
  wrap_fillchar = '│',
  virt_fillchar = '',
  cursor_char = '➜',
  cursor_padding_char = ' ',
  number_padding_char = '0',
}

vim.o.statuscolumn = '%{%v:lua.StatusColumn()%}'
function StatusColumn()
  local text = M.number_signcolumn()
  if not text then return '' end
  text = '%=' .. text
  if vim.wo.number or vim.wo.relativenumber then text = text .. ' ' end
  if vim.wo.foldcolumn ~= '0' then text = '%C ' .. text end
  return text
end

function M.number_signcolumn()
  -- 填充虚拟行
  if vim.v.virtnum > 0 then return M.wrap_fillchar end
  if vim.v.virtnum < 0 then return M.virt_fillchar end

  local fold_sign, signs = M.get_fold_signs(vim.v.lnum)
  -- 折叠行只显示折叠符号
  if fold_sign then return fold_sign end
  -- 非折叠行显示其他符号
  if #signs > 0 then
    local with_number = vim.wo.number or vim.wo.relativenumber
    if vim.wo.signcolumn == 'number' and with_number then return '%l' end
    local number = with_number and M.numbercolumn() or ''
    return '%s' .. number
  end
  return M.numbercolumn()
end

function M.numbercolumn()
  -- 带填充的相对行号
  if vim.wo.relativenumber then
    local padding_char, text
    if vim.v.relnum == 0 then
      padding_char, text = M.cursor_padding_char, M.cursor_char
    else
      padding_char, text = M.number_padding_char, tostring(vim.v.relnum)
    end
    local padding_len = vim.wo.numberwidth - vim.fn.strdisplaywidth(text)
    if padding_len > 0 then
      local padding = string.rep(padding_char, padding_len)
      return padding .. text
    else
      return text
    end
  end

  if vim.wo.number then return '%l' end
end

function M.get_fold_signs(lnum)
  local signs = M._get_signs(lnum)
  if vim.fn.foldclosed(lnum) ~= lnum then
    return nil, signs
  end
  if #signs > 0 then return M.fold_sign_nested, signs end
  for i = lnum + 1, vim.fn.foldclosedend(lnum) do
    if #M._get_signs(i) > 0 then return M.fold_sign_nested, signs end
  end
  return M.fold_sign, signs
end

function M._get_signs(lnum)
  return vim.fn.sign_getplaced(vim.fn.bufnr(),
    { group = '*', lnum = lnum })[1].signs
end
