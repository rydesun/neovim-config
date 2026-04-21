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
  -- https://github.com/lewis6991/gitsigns.nvim/issues/1344
  diff_opts = { internal = true, linematch = false },
}
