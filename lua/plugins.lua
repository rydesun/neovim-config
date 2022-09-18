local plug_ui = function() return vim.g.plug_ui end
local plug_view = function() return vim.g.plug_view end
local plug_op = function() return vim.g.plug_op end
local plug_cmd = function() return vim.g.plug_cmd end
local plug_dev = function() return vim.g.plug_dev end

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  -- 补充lua API
  use 'nvim-lua/plenary.nvim'
  -- 检查启动时间
  use 'dstein64/vim-startuptime'
  -- 缓存lua
  use 'lewis6991/impatient.nvim'

  -- 配色主题
  use {'sainnhe/everforest', cond = plug_ui,
    config = function() require'plugin-configs/everforest' end}
  -- 状态栏
  use {'nvim-lualine/lualine.nvim', cond = plug_ui,
    config = function() require'plugin-configs/lualine' end}
  -- 图标字体
  use {'kyazdani42/nvim-web-devicons', cond = plug_ui}
  -- 搜索提示
  use {'kevinhwang91/nvim-hlslens', cond = plug_ui,
    config = function() require'plugin-configs/nvim-hlslens' end}
  -- 文件浏览器
  use {'kyazdani42/nvim-tree.lua', cond = plug_ui,
    config = function() require'plugin-configs/nvim-tree' end}
  -- 查找
  use {'nvim-telescope/telescope.nvim', cond = plug_ui,
    config = function() require'plugin-configs/telescope' end}

  -- 平滑滚动
  use {'psliwka/vim-smoothie', cond = plug_view}
  -- 缩进线
  use {'lukas-reineke/indent-blankline.nvim', cond = plug_view,
    config = function() require'plugin-configs/indent-blankline' end}
  -- 检测缩进
  use {'nmac427/guess-indent.nvim', cond = plug_view,
    config = function() require'guess-indent'.setup{} end}
  -- 空白符
  use {'ntpeters/vim-better-whitespace', cond = plug_view,
    config = function() require'plugin-configs/vim-better-whitespace' end}
  -- 选区diff
  use {'AndrewRadev/linediff.vim', cond = plug_view}
  -- 查看hex
  use {'fidian/hexmode', cond = plug_view}
  -- 翻译
  use {'voldikss/vim-translator', cond = plug_view}

  -- 增强%
  use {'andymass/vim-matchup', cond = plug_op,
    config = function() require'plugin-configs/vim-matchup' end}
  -- 增强[
  use {'tpope/vim-unimpaired', cond = plug_op}
  -- 移动光标
  use {'ggandor/leap.nvim', cond = plug_op,
    setup = function() end}
  -- 多重光标
  use {'mg979/vim-visual-multi', cond = plug_op}
  -- 成对符号
  use {'machakann/vim-sandwich', cond = plug_op}
  -- 缩进对象
  use {'urxvtcd/vim-indent-object', cond = plug_op}
  -- 拆分合并
  use {'AndrewRadev/splitjoin.vim', cond = plug_op}
  -- 快速注释
  use {'numToStr/Comment.nvim', cond = plug_op,
    config = function() require'Comment'.setup() end}
  -- 切换单词
  use {'tenfyzhong/axring.vim', cond = plug_op,
    config = function() require'plugin-configs/axring' end}
  -- 编辑颜色
  use {'ziontee113/color-picker.nvim', cond = plug_op,
    config = function() require'color-picker' end}
  -- 重复执行
  use {'tpope/vim-repeat', cond = plug_op}
  -- 补全
  use {'hrsh7th/nvim-cmp', cond = plug_op,
    config = function() require'plugin-configs/nvim-cmp' end}
  use {'hrsh7th/cmp-buffer', cond = plug_op}
  use {'hrsh7th/cmp-path', cond = plug_op}
  use {'hrsh7th/cmp-cmdline', cond = plug_op}

  -- 异步执行
  use {'skywind3000/asyncrun.vim', cond = plug_cmd,
    config = function() require'plugin-configs/asyncrun' end}
  -- 终端窗口
  use {'voldikss/vim-floaterm', cond = plug_cmd}
  -- 集成Git
  use {'lewis6991/gitsigns.nvim', cond = plug_cmd,
    config = function() require'plugin-configs/gitsigns' end}
  -- 集成Git
  use {'lambdalisue/gina.vim', cond = plug_cmd}
  -- 切换输入法
  use {'lilydjwg/fcitx.vim', cond = plug_cmd,
    setup = function() vim.g.fcitx5_remote = 'fcitx5-remote' end}
  -- 嵌入浏览器
  use {'glacambre/firenvim',
    cond = function() return vim.g.plug_cmd and vim.g.env_firenvim end,
    config = function() require'plugin-configs/firenvim' end,
    run = function() vim.fn['firenvim#install'](0) end}

  if vim.g.env_mini then return end

  -- LSP
  use {'neovim/nvim-lspconfig', cond = plug_dev}
  use {'williamboman/mason.nvim', cond = plug_dev,
    config = function() require'mason'.setup() end}
  use {'williamboman/mason-lspconfig.nvim', cond = plug_dev,
    config = function() require'plugin-configs/mason-lspconfig' end,
    after = {'nvim-lspconfig', 'mason.nvim', 'cmp-nvim-lsp'}}
  use {'simrat39/rust-tools.nvim', cond = plug_dev,
    config = function() require'plugin-configs/rust-tools' end}
  use {'saecki/crates.nvim', cond = plug_dev,
    config = function() require'crates'.setup() end}
  -- 代码补全
  use {'hrsh7th/cmp-nvim-lsp', cond = plug_dev}
  use {'hrsh7th/cmp-nvim-lsp-signature-help', cond = plug_dev}
  use {'L3MON4D3/LuaSnip', cond = plug_dev,
    config = function() require'plugin-configs/luasnip' end}
  use {'saadparwaiz1/cmp_luasnip', cond = plug_dev}
  -- CST
  use {'nvim-treesitter/nvim-treesitter', cond = plug_dev,
    config = function() require'plugin-configs/nvim-treesitter' end,
    run = ':TSUpdate'}
  use {'nvim-treesitter/playground', cond = plug_dev,
    after = 'nvim-treesitter'}
  use {'romgrk/nvim-treesitter-context', cond = plug_dev,
    after = 'nvim-treesitter'}
  use {'nvim-treesitter/nvim-treesitter-textobjects', cond = plug_dev,
    after = 'nvim-treesitter'}
  -- 任务系统
  use {'skywind3000/asynctasks.vim', cond = plug_dev}
  -- 代码大纲
  use {'stevearc/aerial.nvim', cond = plug_dev,
    config = function() require'aerial'.setup{} end}
  -- 显示颜色(需要go编译)
  if vim.fn.executable('make') > 0 and vim.fn.executable('go') > 0 then
    use {'rrethy/vim-hexokinase', cond = plug_dev,
      run = 'make hexokinase'}
  end
  -- EditorConfig
  use {'gpanders/editorconfig.nvim', cond = plug_dev}
  -- 预览markdown
  use {'iamcco/markdown-preview.nvim', cond = plug_dev,
    run = function() vim.fn['mkdp#util#install']() end}
  -- 为markdown生成toc
  use {'mzlogin/vim-markdown-toc', cond = plug_dev}
  -- latex
  if vim.fn.executable('latex') > 0 then
    use {'lervag/vimtex', cond = plug_dev}
  end
  -- golang
  if vim.fn.executable('go') > 0 then
    use {'fatih/vim-go', cond = plug_dev,
      config = function() require'plugin-configs/vim-go' end}
  end
end)
