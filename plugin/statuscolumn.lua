local M = {
  fold_sign = '%#Folded#%=',
  fold_sign_nested = '%#Folded#%=*',
  wrap_fillchar = '│',
  virt_fillchar = '',
  cursor_char = '➜',
  cursor_padding_char = ' ',
  number_padding_char = '0',

  -- signcolumn=number时，允许signs动态增加列
  signcolumn_number_auto = 2,
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

---@return string?
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
    if vim.wo.signcolumn == 'number' and with_number then
      -- 手动拼接signs
      local signs_text = M.format_signs(signs, M.signcolumn_number_auto)
      -- TODO: 什么情况下有sign无sign_text？
      if signs_text ~= '' then return signs_text end
    end
    -- fallback: 交给nvim处理
    local number = with_number and M.numbercolumn() or ''
    return '%s' .. number
  end
  return M.numbercolumn()
end

---@return string?
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

---@param lnum integer
---@return string?, vim.api.keyset.get_extmark_item[]
function M.get_fold_signs(lnum)
  local signs = M.get_signs(lnum)
  if vim.fn.foldclosed(lnum) ~= lnum then
    return nil, signs
  end
  if #signs > 0 then return M.fold_sign_nested, signs end
  for i = lnum + 1, vim.fn.foldclosedend(lnum) do
    if #M.get_signs(i) > 0 then return M.fold_sign_nested, signs end
  end
  return M.fold_sign, signs
end

---@param lnum integer
---@return vim.api.keyset.get_extmark_item[]
function M.get_signs(lnum)
  local row = lnum - 1
  return vim.api.nvim_buf_get_extmarks(0, -1, { row, 0 }, { row, -1 },
    { details = true, type = 'sign' })
end

local sign_fmt = '%%#%s#%s'
---@param signs vim.api.keyset.get_extmark_item[]
---@param auto_signs integer 选取最高优先级的个数
---@return string
function M.format_signs(signs, auto_signs)
  if auto_signs > 1 then
    table.sort(signs, function(a, b) return a[4].priority > b[4].priority end)
    return vim.iter(signs):filter(function(sign) return not sign[4].invalid end)
    :take(auto_signs):map(function(sign)
      local sign_text = sign[4].sign_text
      if not sign_text then return '' end
      return sign_fmt:format(sign[4].sign_hl_group, sign_text)
    end):join ''
  end
  -- 只取优先级最高的sign
  local found_sign
  for _, sign in ipairs(signs) do
    if not sign[4].invalid and sign[4].sign_text and (
          not found_sign or sign[4].priority > found_sign[4].priority) then
      found_sign = sign
    end
  end
  return found_sign and sign_fmt:format(
    found_sign[4].sign_hl_group, found_sign[4].sign_text
  ) or ''
end
