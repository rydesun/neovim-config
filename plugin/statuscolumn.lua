local M = {
  fold_sign = '%#Folded#%=',
  fold_sign_nested = '%#Folded#%=*',
  wrap_fillchar = '│',
  virt_fillchar = '',
  cursorline = '➜',
}

vim.o.statuscolumn = '%{%v:lua.StatusColumn()%}'
function StatusColumn()
  local text = M.relnum_signcolumn()
  if not text then return '' end
  text = '%=' .. text .. ' '
  if vim.wo.foldcolumn ~= '0' then text = '%C ' .. text end
  return text
end

function M.relnum_signcolumn()
  -- 填充虚拟行
  if vim.v.virtnum > 0 then return M.wrap_fillchar end
  if vim.v.virtnum < 0 then return M.virt_fillchar end

  local fold_sign, signs = M.get_fold_signs(vim.v.lnum)
  -- 折叠行只显示折叠符号
  if fold_sign then return fold_sign end
  -- 非折叠行显示其他符号
  if #signs > 0 then
    if vim.wo.signcolumn == 'number' and
        (vim.wo.number or vim.wo.relativenumber) then
      return '%l'
    end
    return '%s'
  end

  -- 带填充的相对行号
  if vim.wo.relativenumber then
    if vim.v.relnum == 0 then return M.cursorline end
    local relnum = tostring(vim.v.relnum)
    local padding_len = vim.wo.numberwidth - #relnum
    if padding_len > 0 then
      local padding = string.rep('0', padding_len)
      return padding .. relnum
    else
      return '%l'
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
