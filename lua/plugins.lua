---@diagnostic disable: redefined-local

return require('packer').startup(function(use)
  -- <<< 必需品
  -- 插件管理器
  use 'wbthomason/packer.nvim'

  -- 缓存lua
  use 'lewis6991/impatient.nvim'

  -- 补充lua API
  use 'nvim-lua/plenary.nvim'

  -- 集成sqlite
  use "kkharji/sqlite.lua"

  -- tpope's dot.
  use 'tpope/vim-repeat'
  -- >>>-----------------------------------

  -- <<< 自身界面
  local cond = function() return vim.g.plug_ui end

  -- 配色主题
  use { 'sainnhe/everforest', cond = cond,
    config = function() require 'plugin-configs/everforest' end }

  -- 状态栏
  use { 'nvim-lualine/lualine.nvim', cond = cond,
    config = function() require 'plugin-configs/lualine' end }

  -- 图标字体
  use { 'kyazdani42/nvim-web-devicons', cond = cond }

  -- 浮动通知
  use { 'rcarriga/nvim-notify', cond = cond,
    config = function() require 'plugin-configs/nvim-notify' end }

  -- 搜索提示
  use { 'kevinhwang91/nvim-hlslens', cond = cond,
    config = function() require 'plugin-configs/nvim-hlslens' end }

  -- 文件浏览器
  use { 'kyazdani42/nvim-tree.lua', cond = cond,
    config = function() require 'plugin-configs/nvim-tree' end }

  -- 编辑目录
  use { 'elihunter173/dirbuf.nvim', cond = cond }

  -- 查找
  use { 'nvim-telescope/telescope.nvim', cond = cond,
    requires = {
      -- 搜索支持fzf语法
      { 'nvim-telescope/telescope-fzf-native.nvim', cond = cond,
        run = 'make' },
      -- 补全符号
      { 'nvim-telescope/telescope-symbols.nvim', cond = cond },
      -- 管理yank
      { 'AckslD/nvim-neoclip.lua', cond = cond },
      -- 索引文件
      { "nvim-telescope/telescope-frecency.nvim", cond = cond },
    },
    config = function() require 'plugin-configs/telescope' end }

  -- 保持窗口布局
  use { 'famiu/bufdelete.nvim', cond = cond }
  -- >>>-----------------------------------

  -- <<< 查看文本
  local cond = function() return vim.g.plug_view end

  -- 平滑滚动
  use { 'karb94/neoscroll.nvim', cond = cond,
    config = function() require 'plugin-configs/neoscroll' end }

  -- 缩进线
  use { 'lukas-reineke/indent-blankline.nvim', cond = cond,
    config = function() require 'plugin-configs/indent-blankline' end }

  -- 检测缩进
  use { 'nmac427/guess-indent.nvim', cond = cond,
    config = function() require 'guess-indent'.setup {} end }

  -- 空白符
  use { 'ntpeters/vim-better-whitespace', cond = cond,
    setup = function() require 'plugin-configs/vim-better-whitespace' end }

  -- 折叠
  use { 'kevinhwang91/nvim-ufo', cond = cond,
    requires = { 'kevinhwang91/promise-async', cond = cond },
    after = { 'promise-async' },
    config = function() require 'plugin-configs/nvim-ufo' end }

  -- 选区diff
  use { 'AndrewRadev/linediff.vim', cond = cond }

  -- 查看hex
  use { 'fidian/hexmode', cond = cond }

  -- 翻译
  use { 'voldikss/vim-translator', cond = cond }

  -- 显示颜色
  use { 'NvChad/nvim-colorizer.lua', cond = cond,
    config = function() require 'plugin-configs/nvim-colorizer' end }
  -- >>>-----------------------------------

  -- <<< 操作文本
  local cond = function() return vim.g.plug_op end

  -- 增强%
  use { 'andymass/vim-matchup', cond = cond,
    config = function() require 'plugin-configs/vim-matchup' end }

  -- 增强[
  use { 'tpope/vim-unimpaired', cond = cond }

  -- 移动光标
  use { 'ggandor/leap.nvim', cond = cond }

  -- 多重光标
  use { 'mg979/vim-visual-multi', cond = cond }

  -- 成对符号
  use { 'machakann/vim-sandwich', cond = cond }

  -- 缩进对象
  use { 'urxvtcd/vim-indent-object', cond = cond }

  -- 快速注释
  use { 'numToStr/Comment.nvim', cond = cond,
    config = function() require 'Comment'.setup() end }

  -- 表格对齐
  use { 'junegunn/vim-easy-align', cond = cond }

  -- 切换单词
  use { 'monaqa/dial.nvim', cond = cond,
    config = function() require 'plugin-configs/dial' end }

  -- 补全
  use { 'hrsh7th/nvim-cmp', cond = cond,
    config = function() require 'plugin-configs/nvim-cmp' end,
    requires = {
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-cmdline' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'L3MON4D3/LuaSnip', cond = cond,
        config = function() require 'plugin-configs/luasnip' end }
    } }

  -- 自动匹配
  use { 'windwp/nvim-autopairs', cond = cond,
    -- 与补全插件集成
    after = { 'nvim-cmp' },
    config = function() require 'plugin-configs/nvim-autopairs' end }

  -- 撤销历史
  use { 'mbbill/undotree', cond = cond }
  -- >>>-----------------------------------

  -- <<< 命令集成
  local cond = function() return vim.g.plug_cmd end

  -- 异步执行
  use { 'skywind3000/asyncrun.vim', cond = cond }

  -- 任务系统
  use { 'skywind3000/asynctasks.vim', cond = cond,
    config = function() require 'plugin-configs/asynctasks' end }

  -- 终端窗口
  use { 'akinsho/toggleterm.nvim', tag = '*', cond = cond,
    config = function() require 'plugin-configs/toggleterm' end }

  -- 集成Git
  use { 'lewis6991/gitsigns.nvim', cond = cond,
    config = function() require 'plugin-configs/gitsigns' end }

  -- Git diff
  use { 'sindrets/diffview.nvim', cond = cond }

  -- 切换输入法
  use { 'lilydjwg/fcitx.vim', cond = cond,
    setup = function() vim.g.fcitx5_remote = 'fcitx5-remote' end }

  -- 嵌入浏览器
  use { 'glacambre/firenvim',
    cond = function() return vim.g.plug_cmd and vim.g.env_firenvim end,
    config = function() require 'plugin-configs/firenvim' end,
    run = function() vim.fn['firenvim#install'](0) end }

  -- 检查启动时间
  use { 'dstein64/vim-startuptime', cond = cond }
  -- >>>-----------------------------------

  -- 非开发环境中，不安装下面的插件
  if vim.g.env_mini then return end

  local cond = function() return vim.g.plug_dev end

  -- <<< 本地开发 (LSP)
  -- 集成LSP和DAP等工具
  use { 'williamboman/mason.nvim', cond = cond,
    config = function() require 'plugin-configs/mason' end,
    requires = {
      -- JSON schema
      { 'b0o/schemastore.nvim', cond = cond },
      -- 让Lua可以查询nvim的API
      -- 手动配置LSP即可，不需要加载
      { 'folke/lua-dev.nvim', cond = false },
    },
    after = {
      -- 自动配置
      'nvim-lspconfig', 'mason-lspconfig.nvim',
      -- 额外配置
      'rust-tools.nvim',
      -- 在此使用update_capabilities增强补全能力
      'cmp-nvim-lsp',
    } }

  -- 集成非LSP工具。用null-ls的配置 + mason安装的工具
  use { 'jose-elias-alvarez/null-ls.nvim', cond = cond }
  use { 'jayp0521/mason-null-ls.nvim', cond = cond,
    config = function() require 'plugin-configs/mason-null-ls' end,
    after = { 'null-ls.nvim', 'mason.nvim' },
  }

  -- LSP的默认配置
  use { 'neovim/nvim-lspconfig', cond = cond }

  -- 自动配置LSP
  use { 'williamboman/mason-lspconfig.nvim', cond = cond }

  -- 单独配置LSP
  use { 'simrat39/rust-tools.nvim', cond = cond }

  -- 用LSP补全代码
  use { 'hrsh7th/cmp-nvim-lsp', cond = cond }

  -- 增强LSP界面
  use { 'glepnir/lspsaga.nvim', cond = cond,
    config = function() require 'plugin-configs/lspsaga' end }

  -- 补全时显示函数签名
  use { 'ray-x/lsp_signature.nvim', cond = cond,
    config = function() require 'plugin-configs/lsp_signature' end }
  -- >>>-----------------------------------

  -- <<< 本地开发 (tree-sitter)
  use { 'nvim-treesitter/nvim-treesitter', cond = cond,
    config = function() require 'plugin-configs/nvim-treesitter' end,
    run = ':TSUpdate' }

  -- 查看CST
  use { 'nvim-treesitter/playground', cond = cond }

  -- 上下文
  use { 'nvim-treesitter/nvim-treesitter-context', cond = cond }

  -- 文本对象
  use { 'nvim-treesitter/nvim-treesitter-textobjects', cond = cond }

  -- 交换对象
  use { 'mizlan/iswap.nvim', cond = cond,
    config = function() require 'iswap'.setup {} end }

  -- 编辑注入代码块
  use { 'AckslD/nvim-FeMaco.lua', cond = cond,
    config = function() require 'femaco'.setup() end }

  -- 大纲视图
  use { 'stevearc/aerial.nvim', cond = cond,
    config = function() require 'plugin-configs/aerial' end }
  -- >>>-----------------------------------

  -- <<< 本地开发 (特定语言)
  -- 预览Markdown
  use { 'iamcco/markdown-preview.nvim', cond = cond,
    run = function() vim.fn['mkdp#util#install']() end }

  -- 为Markdown生成toc
  use { 'mzlogin/vim-markdown-toc', cond = cond }

  -- Rust
  use { 'saecki/crates.nvim', cond = cond,
    config = function() require 'plugin-configs/crates' end }

  -- LaTex
  if vim.fn.executable('latex') > 0 then
    use { 'lervag/vimtex', cond = cond }
  end

  -- kitty配置文件
  if vim.fn.executable('kitty') > 0 then
    use { 'fladson/vim-kitty', cond = cond }
  end
  -- >>>-----------------------------------

  -- <<< 本地开发 (其他)
  -- 测试
  use { 'vim-test/vim-test', cond = cond,
    setup = function() require 'plugin-configs/vim-test' end }

  -- 覆盖率
  use { 'andythigpen/nvim-coverage', cond = cond,
    config = function() require 'plugin-configs/nvim-coverage' end }

  -- 调试打印
  use { 'andrewferrier/debugprint.nvim', cond = cond,
    config = function() require 'debugprint'.setup() end }

  -- Code Runner
  use { 'michaelb/sniprun', cond = cond,
    config = function() require 'sniprun'.setup {} end,
    run = 'bash ./install.sh' }

  -- EditorConfig
  use { 'gpanders/editorconfig.nvim', cond = cond }
  -- >>>-----------------------------------
end)

-- vim: foldmethod=marker:foldmarker=<<<,>>>:foldlevel=0
