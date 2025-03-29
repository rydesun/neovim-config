vim.g.rustaceanvim = {
  server = {
    settings = {
      ['rust-analyzer'] = {
        completion = {
          -- 允许补全私有字段
          privateEditable = { enable = true },
        },
        -- 自动导入时优先以crate开头
        imports = { prefix = 'crate' },
      }
    }
  },
}
