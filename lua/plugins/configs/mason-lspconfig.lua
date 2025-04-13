return {
  handlers = {
    -- mason安装的ls如果没有单独配置，则使用此配置自动setup
    function(name) vim.lsp.enable(name) end,

    -- mason-lspconfig的自动enable可以被空handler取消
    -- 交给rustaceanvim管理
    rust_analyzer = function() end,
    -- 交给typescript-tools.nvim管理
    ts_ls = function() end,
  },
}
