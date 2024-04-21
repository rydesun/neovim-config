-- 非开发环境中，不安装下面的插件
if not vim.g.env_dev then return {} end

return require 'libs.lazy'.setdefault(vim.g.plug_dev, 'VeryLazy', {
  -- {{{ 本地开发 (LSP)
  {
    'williamboman/mason-lspconfig.nvim',
    nolazy = true,
    config_file = true,
    dependencies = {
      -- 集成LSP和DAP等工具
      { 'williamboman/mason.nvim', config = true },
      'neovim/nvim-lspconfig',
      -- 提供被cmp修改后的default_capabilities
      'hrsh7th/cmp-nvim-lsp',
      -- JSON schema
      'b0o/schemastore.nvim',
      -- 单独配置Rust
      { 'simrat39/rust-tools.nvim', opts_file = true },
    }
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

  -- 补全时显示函数签名
  { 'ray-x/lsp_signature.nvim', opts_file = true },
  -- }}}

  -- {{{ 本地开发 (tree-sitter)
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = { highlight = { enable = true }, autotag = { enable = true } },
  },

  -- 自动输入闭合tag
  { 'windwp/nvim-ts-autotag', nolazy = true },

  -- 上下文
  { 'nvim-treesitter/nvim-treesitter-context', nolazy = true },

  -- AST文本对象(精确)
  -- 不需要开启，因为有mini.ai在使用query
  { 'nvim-treesitter/nvim-treesitter-textobjects' },

  -- AST文本对象(选择标签)
  { 'ggandor/leap-ast.nvim' },

  -- 导航和交换AST节点
  { 'ziontee113/syntax-tree-surfer', config = true },

  -- 按标签交换AST节点
  { 'mizlan/iswap.nvim', config = true },

  -- SplitJoin
  { 'Wansmer/treesj', config = true },

  -- 编辑注入代码块
  { 'AckslD/nvim-FeMaco.lua', config = true },

  -- 大纲视图
  { 'stevearc/aerial.nvim', opts_file = true },
  -- }}}

  -- {{{ 本地开发 (特定语言)
  -- 预览Markdown
  {
    'iamcco/markdown-preview.nvim',
    ft = 'markdown',
    build = function() vim.fn['mkdp#util#install']() end,
  },

  -- 为Markdown生成TOC
  { 'mzlogin/vim-markdown-toc', ft = 'markdown' },

  -- Rust
  { 'saecki/crates.nvim', event = 'BufRead Cargo.toml', opts_file = true },

  -- LaTex
  { 'lervag/vimtex', ft = 'tex', enabled = vim.fn.executable('latex') > 0 },

  -- Hugo
  {
    'phelipetls/vim-hugo',
    enabled = vim.fn.executable('hugo') > 0,
    nolazy = true,
  },
  -- }}}

  -- {{{ 本地开发 (其他)
  -- Structural search and replace
  { 'cshuaimin/ssr.nvim', config = true },

  -- 测试
  { 'vim-test/vim-test', init_file = true },

  -- 覆盖率
  { 'andythigpen/nvim-coverage', opts_file = true },

  -- 调试打印
  { 'andrewferrier/debugprint.nvim', config = true },

  -- Code Runner
  { 'michaelb/sniprun', config = true, build = 'bash ./install.sh' },

  -- 文档
  { 'luckasRanarison/nvim-devdocs', opts_file = true },
  -- }}}
})

-- vim: foldmethod=marker:foldlevel=0
