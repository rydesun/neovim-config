local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = function(_, bufnr)
      vim.keymap.set("n", "<Leader>wa",
        rt.code_action_group.code_action_group, { buffer = bufnr })
      vim.keymap.set("n", "<Leader>wt",
        rt.open_cargo_toml.open_cargo_toml)
      vim.keymap.set("n", "<Leader>wp",
        rt.parent_module.parent_module)
      vim.keymap.set("n", "<Leader>wm",
        rt.expand_macro.expand_macro)
    end,
  },
})
