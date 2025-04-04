local signs = {
  add = { text = '+│' },
  change = { text = '~│' },
  delete = { text = '_│' },
  topdelete = { text = '‾│' },
  changedelete = { text = '≃│' },
  -- 不提示未追踪的文件
  untracked = { text = '' },
}

return {
  signs = signs,
  signs_staged = signs,
}
