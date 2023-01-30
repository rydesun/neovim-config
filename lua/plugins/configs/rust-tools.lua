return {
  server = {
    settings = {
      ['rust-analyzer'] = {
        completion = {
          -- 去掉snippet
          postfix = { enable = false },
          -- 允许补全私有字段
          privateEditable = { enable = true },
        },
        -- 自动导入时优先以crate开头
        imports = { prefix = 'crate' },
      }
    }
  },
  tools = {
    inlay_hints = {
      highlight = 'InlayHint',
      other_hints_prefix = '⇒ ',
      show_parameter_hints = false,
    },
    hover_actions = { auto_focus = true },
  }
}
