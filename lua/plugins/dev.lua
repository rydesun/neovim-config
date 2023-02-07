-- 非开发环境中，不安装下面的插件
if not vim.g.env_dev then return {} end

local cond = vim.g.plug_dev
local event = 'VeryLazy'
local autoconfig = require 'lib'.autoconfig

return {
  -- {{{ 本地开发 (LSP)
  -- 集成LSP和DAP等工具
  { 'williamboman/mason.nvim',
    cond = cond, config = autoconfig(),
    dependencies = {
      -- 自动配置
      'neovim/nvim-lspconfig', 'williamboman/mason-lspconfig.nvim',
      -- 在此使用default_capabilities
      'hrsh7th/cmp-nvim-lsp',
      -- JSON schema
      'b0o/schemastore.nvim',
      -- 单独配置Rust
      { 'simrat39/rust-tools.nvim', opts = autoconfig() },
    } },

  -- 集成非LSP工具。用null-ls的配置 + mason安装的工具
  { 'jayp0521/mason-null-ls.nvim',
    cond = cond, event = event, config = autoconfig(),
    dependencies = {
      'mason.nvim', 'jose-elias-alvarez/null-ls.nvim',
    } },

  -- 补全时显示函数签名
  { 'ray-x/lsp_signature.nvim',
    cond = cond, event = event, opts = autoconfig() },
  -- }}}

  -- {{{ 本地开发 (tree-sitter)
  { 'nvim-treesitter/nvim-treesitter',
    cond = cond, config = autoconfig(),
    build = ':TSUpdate' },

  -- 查看CST
  { 'nvim-treesitter/playground',
    cond = cond, event = event },

  -- 上下文
  { 'nvim-treesitter/nvim-treesitter-context',
    cond = cond },

  -- 文本对象
  { 'nvim-treesitter/nvim-treesitter-textobjects',
    cond = cond, event = event },

  -- 交换对象
  { 'mizlan/iswap.nvim',
    cond = cond, event = event, config = true },

  -- SplitJoin
  { 'Wansmer/treesj',
    cond = cond, event = event, config = true },

  -- 编辑注入代码块
  { 'AckslD/nvim-FeMaco.lua',
    cond = cond, event = event, config = true },

  -- 大纲视图
  { 'stevearc/aerial.nvim',
    cond = cond, event = event, opts = autoconfig() },
  -- }}}

  -- {{{ 本地开发 (特定语言)
  -- 预览Markdown
  { 'iamcco/markdown-preview.nvim',
    cond = cond,
    build = function() vim.fn['mkdp#util#install']() end },

  -- 为Markdown生成TOC
  { 'mzlogin/vim-markdown-toc',
    cond = cond },

  -- Rust
  { 'saecki/crates.nvim',
    cond = cond, opts = autoconfig() },

  -- LaTex
  { 'lervag/vimtex',
    enabled = vim.fn.executable('latex') > 0,
    cond = cond },
  -- }}}

  -- {{{ 本地开发 (其他)
  -- Structural search and replace
  { 'cshuaimin/ssr.nvim',
    cond = cond, event = event, config = true },

  -- 测试
  { 'vim-test/vim-test',
    cond = cond, event = event, init = autoconfig() },

  -- 覆盖率
  { 'andythigpen/nvim-coverage',
    cond = cond, event = event, opts = autoconfig() },

  -- 调试打印
  { 'andrewferrier/debugprint.nvim',
    cond = cond, event = event, config = true },

  -- Code Runner
  { 'michaelb/sniprun',
    cond = cond, event = event, config = true,
    build = 'bash ./install.sh' },

  -- EditorConfig
  { 'gpanders/editorconfig.nvim',
    cond = cond },
  -- }}}
}

-- vim: foldmethod=marker:foldlevel=0
