vim.g.rustaceanvim = {
  server = {
    settings = {
      ['rust-analyzer'] = {
        completion = {
          -- 去掉postfix snippet
          postfix = { enable = false },
          -- 允许补全私有字段
          privateEditable = { enable = true },
        },
        -- 自动导入时优先以crate开头
        imports = { prefix = 'crate' },
      }
    }
  },
}
