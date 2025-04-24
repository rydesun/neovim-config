-- 关闭ruff的hover，只用basedpyright提供的hover
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp_attach_disable_ruff_hover',
    { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then return end
    if client.name == 'ruff' then
      client.server_capabilities.hoverProvider = false
    end
  end,
  desc = 'LSP: Disable hover capability from Ruff',
})

local cfg = {}
cfg.init_options = {
  -- 让basedpyright提供lint，ruff只提供format
  settings = { lint = { enable = false } },
}
return cfg
