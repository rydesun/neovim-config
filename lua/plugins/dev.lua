-- 非开发环境中，不安装下面的插件
if not vim.g.env_dev then return {} end

local cond = vim.g.plug_dev
return require 'libs.lazy-helper' { cond = cond, very_lazy = true, spec = {
  -- {{{ 本地开发 (LSP+DAP)
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
  -- DAP从Mason安装并且会自动集成
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
  { 'jay-babu/mason-nvim-dap.nvim',
    opts = { handlers = {} },
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
      { 'mfussenegger/nvim-dap', lazy = true,
        dependencies = {
          { 'mfussenegger/nvim-dap-python' },
          { 'igorlfs/nvim-dap-view', config = true },
          { 'theHamsta/nvim-dap-virtual-text', config = true },
        } },
    } },

  -- 集成非LSP工具。用none-ls的配置 + mason安装的工具
  { 'jayp0521/mason-null-ls.nvim', opts = { handlers = {} },
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
      { 'nvimtools/none-ls.nvim', config = true },
    } },
  -- }}}

  -- {{{ 本地开发 (tree-sitter)
  { 'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = { highlight = { enable = true }, matchup = { enable = true } },
  },

  -- 自动输入闭合tag
  { 'windwp/nvim-ts-autotag', lazy = false, config = true },

  -- 显示上下文
  { 'nvim-treesitter/nvim-treesitter-context', opts_file = true },

  -- 语法节点文本对象
  -- 另外有mini.ai在使用query
  { 'nvim-treesitter/nvim-treesitter-textobjects',
    main = 'nvim-treesitter.configs', opts_file = true },

  -- 导航语法节点
  { 'aaronik/treewalker.nvim', config = true },

  -- 交换语法节点(标签选择)
  { 'mizlan/iswap.nvim', config = true },

  -- 修改语法节点(自动切换)
  { 'ckolkey/ts-node-action', config = true, lazy = true },
  { 'Wansmer/treesj', config = true, lazy = true,
    opts = { use_default_keymaps = false } },

  -- 大纲视图
  { 'oskarrrrrrr/symbols.nvim', config_file = true },
  -- }}}

  -- {{{ 本地开发 (特定语言)
  -- 预览Markdown
  { 'iamcco/markdown-preview.nvim',
    ft = 'markdown',
    build = function() vim.fn['mkdp#util#install']() end,
  },

  -- Rust
  { 'saecki/crates.nvim', event = 'BufRead Cargo.toml', opts_file = true },

  -- LaTex
  { 'lervag/vimtex', ft = 'tex', enabled = vim.fn.executable 'latex' > 0 },

  -- Hugo
  { 'phelipetls/vim-hugo',
    enabled = vim.fn.executable 'hugo' > 0,
    lazy = false,
  },

  -- REST
  { 'mistweaverco/kulala.nvim',
    ft = { 'http', 'rest' },
    keys = '<leader>R',
    opts = { global_keymaps = true },
  },
  -- }}}

  -- {{{ 本地开发 (其他)
  { 'danymat/neogen', opts = { snippet_engine = 'luasnip' } },

  -- 测试
  { 'vim-test/vim-test', init_file = true },

  -- 覆盖率
  { 'andythigpen/nvim-coverage', opts_file = true },

  -- 调试打印
  { 'chrisgrieser/nvim-chainsaw', config = true },

  -- Code Runner
  { 'michaelb/sniprun', opts_file = true, build = 'sh install.sh',
    cmd = 'SnipRun' },

  -- Code action diff
  { 'aznhe21/actions-preview.nvim', opts_file = true },
} }

-- vim: foldmethod=marker:foldlevel=0
