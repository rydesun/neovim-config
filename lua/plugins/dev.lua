-- 非开发环境中，不安装下面的插件
if not vim.g.env_dev then return {} end

local cond = vim.g.plug_dev
return require 'libs.lazy-helper' { cond = cond, very_lazy = true, spec = {
  -- {{{ 本地开发 (LSP)
  {
    'williamboman/mason-lspconfig.nvim',
    lazy = false,
    config_file = true,
    dependencies = {
      -- 集成LSP和DAP等工具
      { 'williamboman/mason.nvim', config = true },
      'neovim/nvim-lspconfig',
      -- JSON schema
      'b0o/schemastore.nvim',
    },
  },

  -- 单独配置Rust
  { 'mrcjkb/rustaceanvim', version = '^5', lazy = false, config_file = true },

  -- 单独配置Typescript
  { 'pmizio/typescript-tools.nvim', lazy = false, opts_file = true },

  -- lua_ls：面向nvim编程
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = { library = { { path = '${3rd}/luv/library', words = { 'vim%.uv' } } } },
  },

  -- 集成非LSP工具。用none-ls的配置 + mason安装的工具
  {
    'jayp0521/mason-null-ls.nvim',
    opts_file = true,
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
      { 'nvimtools/none-ls.nvim', config = true },
    },
  },
  -- }}}

  -- {{{ 本地开发 (tree-sitter)
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = { highlight = { enable = true } },
  },

  -- 自动输入闭合tag
  { 'windwp/nvim-ts-autotag', lazy = true, config = true },

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
  { 'Wansmer/treesj', config = true, opts = { use_default_keymaps = false } },
  { 'ckolkey/ts-node-action', config = true },

  -- 大纲视图
  { 'oskarrrrrrr/symbols.nvim', config_file = true },
  -- }}}

  -- {{{ 本地开发 (特定语言)
  -- 预览Markdown
  {
    'iamcco/markdown-preview.nvim',
    ft = 'markdown',
    build = function() vim.fn['mkdp#util#install']() end,
  },

  -- Rust
  { 'saecki/crates.nvim', event = 'BufRead Cargo.toml', opts_file = true },

  -- LaTex
  { 'lervag/vimtex', ft = 'tex', enabled = vim.fn.executable 'latex' > 0 },

  -- Hugo
  {
    'phelipetls/vim-hugo',
    enabled = vim.fn.executable 'hugo' > 0,
    lazy = false,
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
  { 'michaelb/sniprun', opts_file = true, build = 'sh install.sh' },
} }

-- vim: foldmethod=marker:foldlevel=0
