-- 非开发环境中，不安装下面的插件
if not vim.g.env_dev then return {} end

local cond = vim.g.plug_dev
return require 'libs.lazy-helper' { cond = cond, very_lazy = true, spec = {
  -- {{{ LSP+DAP
  -- 自动集成Mason安装的LSP
  { 'williamboman/mason-lspconfig.nvim', lazy = false,
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
      'neovim/nvim-lspconfig',
    },
    opts = { handlers = {
      -- 自动enable所有通过Mason安装的LSP
      function(name) vim.lsp.enable(name) end,
      -- 自动enable可以被空handler取消
      rust_analyzer = function() end, -- 交给rustaceanvim管理
      ts_ls = function() end,         -- 交给typescript-tools.nvim管理
    } },
  },

  -- 单独配置Rust
  -- LSP使用系统端安装的nightly rust-analyzer，不要从Mason安装
  -- DAP可以从Mason安装并且会自动集成
  { 'mrcjkb/rustaceanvim', version = '^6', lazy = false, config_file = true },

  -- 单独配置Typescript
  { 'pmizio/typescript-tools.nvim', opts_file = true,
    ft = { 'javascript', 'typescript' } },

  -- lua_ls：面向nvim编程
  { 'folke/lazydev.nvim', ft = 'lua',
    opts = { library = { {
      path = '${3rd}/luv/library', words = { 'vim%.uv' } } } },
  },

  -- JSON+YAML schema
  { 'b0o/schemastore.nvim', lazy = true },

  -- 自动集成Mason安装的DAP
  { 'mfussenegger/nvim-dap', lazy = true, cmd = 'DapNew',
    dependencies = {
      { 'jay-babu/mason-nvim-dap.nvim', opts = { handlers = {} },
        dependencies = { 'williamboman/mason.nvim', config = true } },
      { 'mfussenegger/nvim-dap-python', lazy = true },
      { 'igorlfs/nvim-dap-view', config = true },
      { 'theHamsta/nvim-dap-virtual-text', config = true },
    } },
  -- }}}

  -- {{{ Linter+Formatter
  -- 自动集成Mason安装的Linter+Formatter
  { 'jayp0521/mason-null-ls.nvim', opts = { handlers = {
    -- 不需要自动setup的工具，可以被空handler取消，然后交给nvim-lint处理
    markdownlint_cli2 = function() end,
  } },
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
      { 'nvimtools/none-ls.nvim', config = true },
    } },

  -- Linter(按需手动调用)
  { 'mfussenegger/nvim-lint', lazy = true, config = function()
    require 'lint'.linters_by_ft = {
      markdown = { 'markdownlint-cli2' },
      -- 不要把rust-analyzer.check.command改成clippy
      -- 而是手动调用clippy
      rust = { 'clippy' },
    }
  end },

  -- Formatter
  -- conform能调用none-ls伪装的LSP formatting
  { 'stevearc/conform.nvim', lazy = true, opts = {
    default_format_opts = { lsp_format = 'fallback' },
  } },
  -- }}}

  -- {{{ 特定语言
  -- 预览Markdown
  { 'iamcco/markdown-preview.nvim',
    ft = 'markdown',
    build = function() vim.fn['mkdp#util#install']() end,
  },

  -- Rust
  { 'saecki/crates.nvim', event = 'BufRead Cargo.toml', opts_file = true },

  -- LaTex
  { 'lervag/vimtex', ft = 'tex', enabled = vim.fn.executable 'latex' > 0 },

  -- REST
  { 'mistweaverco/kulala.nvim',
    ft = { 'http', 'rest' },
    keys = { { '<leader>R', mode = { 'n', 'v' } } },
    opts = { global_keymaps = true },
  },

  -- package.json
  { 'vuki656/package-info.nvim', config = true,
    event = 'BufRead package.json',
    dependencies = 'MunifTanjim/nui.nvim' },
  -- }}}

  -- {{{ Snippets
  -- snippets引擎
  { 'L3MON4D3/LuaSnip', opts_file = 'luasnip', version = 'v2.*' },

  -- 编辑snippets
  { 'chrisgrieser/nvim-scissors', opts = { jsonFormatter = 'jq' },
    cmd = { 'ScissorsAddNewSnippet', 'ScissorsEditSnippet' } },

  -- 文档注释
  { 'danymat/neogen', opts = { snippet_engine = 'luasnip' } },

  -- emmet
  { 'mattn/emmet-vim', keys = { { '<C-S-y>', mode = { 'n', 'v', 'i' } } },
    init = function() vim.g.user_emmet_leader_key = '<C-S-y>' end },
  -- }}}

  -- {{{ 构建执行
  -- 测试
  { 'vim-test/vim-test', init_file = true },

  -- 测试覆盖率
  { 'andythigpen/nvim-coverage', opts_file = true },

  -- Debug print
  { 'chrisgrieser/nvim-chainsaw', config = true },

  -- Jupyter
  { 'benlubas/molten-nvim', init_file = true,
    version = '^1.0.0', build = ':UpdateRemotePlugins',
    enabled = vim.fn.executable 'jupyter' > 0 },

  -- 代码块+LSP
  { 'jmbuhr/otter.nvim', config = true, lazy = true },
  -- }}}

  -- {{{ UI
  -- Peek
  { 'dnlhc/glance.nvim', cmd = 'Glance' },

  -- Code action diff
  { 'aznhe21/actions-preview.nvim', opts_file = true },
  -- }}}
} }

-- vim: foldmethod=marker:foldlevel=0
