-- 非开发环境中，不安装下面的插件
if not vim.g.env_dev then return {} end

return require 'libs.lazy'.setdefault(vim.g.plug_dev, 'VeryLazy', {
  -- {{{ 本地开发 (LSP)
  -- 集成LSP和DAP等工具
  {
    'williamboman/mason.nvim',
    nolazy = true,
    config_file = true,
    dependencies = {
      -- 自动配置
      'neovim/nvim-lspconfig', 'williamboman/mason-lspconfig.nvim',
      -- 在此使用default_capabilities
      'hrsh7th/cmp-nvim-lsp',
      -- JSON schema
      'b0o/schemastore.nvim',
      -- 单独配置Rust
      { 'simrat39/rust-tools.nvim', opts_file = true },
    }
  },

  -- 集成非LSP工具。用null-ls的配置 + mason安装的工具
  {
    'jayp0521/mason-null-ls.nvim',
    config_file = true,
    dependencies = { 'mason.nvim', 'jose-elias-alvarez/null-ls.nvim' },
  },

  -- 补全时显示函数签名
  { 'ray-x/lsp_signature.nvim', opts_file = true },
  -- }}}

  -- {{{ 本地开发 (tree-sitter)
  {
    'nvim-treesitter/nvim-treesitter',
    nolazy = true,
    config_file = true,
    build = ':TSUpdate',
  },

  -- 查看CST
  { 'nvim-treesitter/playground' },

  -- 上下文
  { 'nvim-treesitter/nvim-treesitter-context', nolazy = true },

  -- AST文本对象(精确)
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
    nolazy = true,
    build = function() vim.fn['mkdp#util#install']() end,
  },

  -- 为Markdown生成TOC
  { 'mzlogin/vim-markdown-toc', nolazy = true },

  -- Rust
  { 'saecki/crates.nvim', nolazy = true, opts_file = true },

  -- LaTex
  { 'lervag/vimtex', nolazy = true, enabled = vim.fn.executable('latex') > 0 },
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

  -- EditorConfig
  { 'gpanders/editorconfig.nvim', nolazy = true },
  -- }}}
})

-- vim: foldmethod=marker:foldlevel=0
