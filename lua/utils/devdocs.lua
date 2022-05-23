M = {
  url = 'https://devdocs.io/#q=',
}

function M.open(lang, keyword)
  local query = ''
  if lang == '' then
    query = keyword
  else
    query = lang .. ' ' .. keyword
  end
  local url = M.url .. query
  vim.fn['netrw#BrowseX'](url, vim.fn['netrw#CheckIfRemote']())
end

function M:open_cursor()
  self.open(vim.o.ft, vim.fn.expand('<cword>'))
end

return M
