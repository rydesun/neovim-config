return function()
  local first_line = vim.fn.getline(vim.v.foldstart)
  local folded_cnt = vim.v.foldend - vim.v.foldstart

  if vim.o.foldmethod == 'marker' then
    local comment = vim.o.commentstring:format('')
    local marker = vim.o.foldmarker:sub(1, vim.o.foldmarker:find(',')-1)
    local text = first_line:gsub(marker, ''):gsub(comment, '')
    return '＋❰' .. vim.fn.printf('%3d', folded_cnt-1) .. '❱ '
      .. vim.fn.trim(text)
  end

  return first_line..' ❰'..folded_cnt..'❱ '
end
