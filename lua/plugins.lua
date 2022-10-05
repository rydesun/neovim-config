-- 根据全局变量按需启动插件
local plug_ui = function() return vim.g.plug_ui end
local plug_view = function() return vim.g.plug_view end
local plug_op = function() return vim.g.plug_op end
local plug_cmd = function() return vim.g.plug_cmd end
local plug_dev = function() return vim.g.plug_dev end

return require('packer').startup(function(use)
  -- <<< 必需品
  -- 插件管理器
  use 'wbthomason/packer.nvim'

  -- 缓存lua
  use 'lewis6991/impatient.nvim'

  -- 补充lua API
  use 'nvim-lua/plenary.nvim'

  -- 检查启动时间
  use 'dstein64/vim-startuptime'
  -- >>>-----------------------------------

  -- <<< 自身界面 plug_ui
  -- 配色主题
  use { 'sainnhe/everforest', cond = plug_ui,
    config = function() require 'plugin-configs/everforest' end }

  -- 状态栏
  use { 'nvim-lualine/lualine.nvim', cond = plug_ui,
    config = function() require 'plugin-configs/lualine' end }

  -- 图标字体
  use { 'kyazdani42/nvim-web-devicons', cond = plug_ui }

  -- 浮动通知
  use { 'rcarriga/nvim-notify', cond = plug_ui,
    config = function() require 'plugin-configs/nvim-notify' end }

  -- 搜索提示
  use { 'kevinhwang91/nvim-hlslens', cond = plug_ui,
    config = function() require 'plugin-configs/nvim-hlslens' end }

  -- 文件浏览器
  use { 'kyazdani42/nvim-tree.lua', cond = plug_ui,
    config = function() require 'plugin-configs/nvim-tree' end }

  -- 编辑目录
  use { 'elihunter173/dirbuf.nvim', cond = plug_ui }

  -- 查找
  use { 'nvim-telescope/telescope.nvim', cond = plug_ui,
    config = function() require 'plugin-configs/telescope' end }

  -- 保持窗口布局
  use { 'famiu/bufdelete.nvim', cond = plug_ui }
  -- >>>-----------------------------------

  -- <<< 查看文本 plug_view
  -- 平滑滚动
  use { 'psliwka/vim-smoothie', cond = plug_view }

  -- 缩进线
  use { 'lukas-reineke/indent-blankline.nvim', cond = plug_view,
    config = function() require 'plugin-configs/indent-blankline' end }

  -- 检测缩进
  use { 'nmac427/guess-indent.nvim', cond = plug_view,
    config = function() require 'guess-indent'.setup {} end }

  -- 空白符
  use { 'ntpeters/vim-better-whitespace', cond = plug_view,
    setup = function() require 'plugin-configs/vim-better-whitespace' end }

  -- 选区diff
  use { 'AndrewRadev/linediff.vim', cond = plug_view }

  -- 查看hex
  use { 'fidian/hexmode', cond = plug_view }

  -- 翻译
  use { 'voldikss/vim-translator', cond = plug_view }
  -- >>>-----------------------------------

  -- <<< 操作文本 plug_op
  -- 增强%
  use { 'andymass/vim-matchup', cond = plug_op,
    config = function() require 'plugin-configs/vim-matchup' end }

  -- 增强[
  use { 'tpope/vim-unimpaired', cond = plug_op }

  -- 移动光标
  use { 'ggandor/leap.nvim', cond = plug_op,
    setup = function() end }

  -- 多重光标
  use { 'mg979/vim-visual-multi', cond = plug_op }

  -- 成对符号
  use { 'machakann/vim-sandwich', cond = plug_op }

  -- 缩进对象
  use { 'urxvtcd/vim-indent-object', cond = plug_op }

  -- 拆分合并
  use { 'AndrewRadev/splitjoin.vim', cond = plug_op }

  -- 快速注释
  use { 'numToStr/Comment.nvim', cond = plug_op,
    config = function() require 'Comment'.setup() end }

  -- 切换单词
  use { 'monaqa/dial.nvim', cond = plug_op,
    config = function() require 'plugin-configs/dial' end }

  -- 编辑颜色
  use { 'ziontee113/color-picker.nvim', cond = plug_op,
    config = function() require 'color-picker' end }

  -- 重复执行
  use { 'tpope/vim-repeat', cond = plug_op }

  -- 补全
  use { 'hrsh7th/nvim-cmp', cond = plug_op,
    config = function() require 'plugin-configs/nvim-cmp' end,
    requires = {
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-cmdline' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'L3MON4D3/LuaSnip', cond = plug_op,
        config = function() require 'plugin-configs/luasnip' end }
    } }

  -- 自动匹配
  use { 'windwp/nvim-autopairs', cond = plug_op,
    -- 与补全插件集成
    after = { 'nvim-cmp' },
    config = function() require 'plugin-configs/nvim-autopairs' end }
  -- >>>-----------------------------------

  -- <<< 命令集成 plug_cmd
  -- 异步执行
  use { 'skywind3000/asyncrun.vim', cond = plug_cmd,
    config = function() require 'plugin-configs/asyncrun' end }

  -- 终端窗口
  use { 'voldikss/vim-floaterm', cond = plug_cmd }

  -- 集成Git
  use { 'lewis6991/gitsigns.nvim', cond = plug_cmd,
    config = function() require 'plugin-configs/gitsigns' end }

  -- Git diff
  use { 'sindrets/diffview.nvim', cond = plug_cmd }

  -- 切换输入法
  use { 'lilydjwg/fcitx.vim', cond = plug_cmd,
    setup = function() vim.g.fcitx5_remote = 'fcitx5-remote' end }

  -- 嵌入浏览器
  use { 'glacambre/firenvim',
    cond = function() return vim.g.plug_cmd and vim.g.env_firenvim end,
    config = function() require 'plugin-configs/firenvim' end,
    run = function() vim.fn['firenvim#install'](0) end }
  -- >>>-----------------------------------

  -- 非开发环境中，不安装下面的插件
  if vim.g.env_mini then return end

  -- <<< 本地开发 plug_dev (LSP)
  -- 集成LSP和DAP等工具
  use { 'williamboman/mason.nvim', cond = plug_dev,
    config = function() require 'plugin-configs/mason' end,
    after = {
      -- 自动配置
      'nvim-lspconfig', 'mason-lspconfig.nvim',
      -- 额外配置
      'rust-tools.nvim', 'lua-dev.nvim',
      -- 集成非LSP工具
      'null-ls.nvim', 'mason-null-ls.nvim',
      -- 在此使用update_capabilities增强补全能力
      'cmp-nvim-lsp',
    } }

  -- LSP的默认配置
  use { 'neovim/nvim-lspconfig', cond = plug_dev }

  -- 自动配置LSP
  use { 'williamboman/mason-lspconfig.nvim', cond = plug_dev }

  -- 单独配置LSP
  use { 'simrat39/rust-tools.nvim', cond = plug_dev }
  use { 'folke/lua-dev.nvim', cond = plug_dev }

  -- 用null-ls集成非LSP工具
  use { 'jose-elias-alvarez/null-ls.nvim', cond = plug_dev }
  use { 'jayp0521/mason-null-ls.nvim', cond = plug_dev }

  -- 用LSP补全代码
  use { 'hrsh7th/cmp-nvim-lsp', cond = plug_dev }

  -- 增强LSP界面
  use { 'glepnir/lspsaga.nvim', cond = plug_dev,
    config = function() require 'plugin-configs/lspsaga' end }

  -- 补全时显示函数签名
  use { 'ray-x/lsp_signature.nvim', cond = plug_dev,
    config = function() require 'plugin-configs/lsp_signature' end }
  -- >>>-----------------------------------

  -- <<< 本地开发 plug_dev (tree-sitter)
  -- CST
  use { 'nvim-treesitter/nvim-treesitter', cond = plug_dev,
    config = function() require 'plugin-configs/nvim-treesitter' end,
    run = ':TSUpdate' }
  use { 'nvim-treesitter/playground', cond = plug_dev }
  use { 'nvim-treesitter/nvim-treesitter-context', cond = plug_dev }
  use { 'nvim-treesitter/nvim-treesitter-textobjects', cond = plug_dev }
  -- >>>-----------------------------------

  -- <<< 本地开发 plug_dev (特定语言)
  -- 预览markdown
  use { 'iamcco/markdown-preview.nvim', cond = plug_dev,
    run = function() vim.fn['mkdp#util#install']() end }

  -- 为markdown生成toc
  use { 'mzlogin/vim-markdown-toc', cond = plug_dev }

  -- rust
  use { 'saecki/crates.nvim', cond = plug_dev,
    config = function() require 'plugin-configs.crates' end }

  -- latex
  if vim.fn.executable('latex') > 0 then
    use { 'lervag/vimtex', cond = plug_dev }
  end

  -- golang
  if vim.fn.executable('go') > 0 then
    use { 'fatih/vim-go', cond = plug_dev,
      config = function() require 'plugin-configs/vim-go' end }
  end
  -- >>>-----------------------------------

  -- <<< 本地开发 plug_dev (其他)
  -- 任务系统
  use { 'skywind3000/asynctasks.vim', cond = plug_dev }

  -- 代码大纲
  use { 'stevearc/aerial.nvim', cond = plug_dev,
    config = function() require 'aerial'.setup {} end }

  -- 显示颜色(需要go编译)
  if vim.fn.executable('make') > 0 and vim.fn.executable('go') > 0 then
    use { 'rrethy/vim-hexokinase', cond = plug_dev,
      run = 'make hexokinase' }
  end

  -- EditorConfig
  use { 'gpanders/editorconfig.nvim', cond = plug_dev }
  -- >>>-----------------------------------
end)

-- vim: foldmethod=marker:foldmarker=<<<,>>>:foldlevel=0
