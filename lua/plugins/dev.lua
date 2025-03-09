-- 非开发环境中，不安装下面的插件
if not vim.g.env_dev then return {} end

return require 'libs.lazy'.setdefault(vim.g.plug_dev, 'VeryLazy', {
  -- {{{ 本地开发 (LSP)
  {
    'williamboman/mason-lspconfig.nvim',
    lazy = false,
    config_file = true,
    dependencies = {
      -- 集成LSP和DAP等工具
      { 'williamboman/mason.nvim', config = true },
      'neovim/nvim-lspconfig',
      -- 提供被cmp修改后的default_capabilities
      'hrsh7th/cmp-nvim-lsp',
      -- JSON schema
      'b0o/schemastore.nvim',
    }
  },

  -- 单独配置Rust: 使用系统端的rust-analyzer，不要从mason安装
  { 'mrcjkb/rustaceanvim', version = '^5', lazy = false, config_file = true },

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
    opts = { highlight = { enable = true }, autotag = { enable = true } },
  },

  -- 自动输入闭合tag
  { 'windwp/nvim-ts-autotag', lazy = false },

  -- 上下文
  { 'nvim-treesitter/nvim-treesitter-context', lazy = false },

  -- AST文本对象(精确)
  -- 不需要开启，因为有mini.ai在使用query
  { 'nvim-treesitter/nvim-treesitter-textobjects' },

  -- 交换AST节点(标签选择)
  { 'mizlan/iswap.nvim', config = true },

  -- 导航AST节点
  { 'aaronik/treewalker.nvim', config = true },

  -- SplitJoin
  { 'Wansmer/treesj', config = true, opts = { use_default_keymaps = false } },

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
  { 'lervag/vimtex', ft = 'tex', enabled = vim.fn.executable('latex') > 0 },

  -- Hugo
  {
    'phelipetls/vim-hugo',
    enabled = vim.fn.executable('hugo') > 0,
    lazy = false,
  },
  -- }}}

  -- {{{ 本地开发 (其他)
  -- 测试
  { 'vim-test/vim-test', init_file = true },

  -- 覆盖率
  { 'andythigpen/nvim-coverage', opts_file = true },

  -- 调试打印
  { 'chrisgrieser/nvim-chainsaw', config = true },

  -- Code Runner
  { 'michaelb/sniprun', opts_file = true, build = 'sh install.sh' },
})

-- vim: foldmethod=marker:foldlevel=0
