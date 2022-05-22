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
    config = function() require'config/everforest' end}
  -- 状态栏
  use {'nvim-lualine/lualine.nvim', cond = plug_ui,
    config = function() require'config/lualine' end}
  -- 图标字体
  use {'kyazdani42/nvim-web-devicons', cond = plug_ui}
  -- 搜索提示
  use {'kevinhwang91/nvim-hlslens', cond = plug_ui,
    config = function() require'config/nvim-hlslens' end}
  -- 文件浏览器
  use {'kyazdani42/nvim-tree.lua', cond = plug_ui,
    config = function() require'config/nvim-tree' end}
  -- 查找
  use {'nvim-telescope/telescope.nvim', cond = plug_ui}
  -- 改进wildmenu
  use {'gelguy/wilder.nvim', cond = plug_ui,
    run = ':UpdateRemotePlugins',
    config = function() require'config/wilder' end}

  -- 平滑滚动
  use {'psliwka/vim-smoothie', cond = plug_view}
  -- 缩进线
  use {'lukas-reineke/indent-blankline.nvim', cond = plug_view,
    config = function() require'config/indent-blankline' end}
  -- 检测缩进
  use {'nmac427/guess-indent.nvim', cond = plug_view,
    config = function() require'guess-indent'.setup{} end}
  -- 空白符
  use {'ntpeters/vim-better-whitespace', cond = plug_view,
    config = function() require'config/vim-better-whitespace' end}
  -- 选区diff
  use {'AndrewRadev/linediff.vim', cond = plug_view}
  -- 查看hex
  use {'fidian/hexmode', cond = plug_view}
  -- 翻译
  use {'voldikss/vim-translator', cond = plug_view}

  -- 增强%
  use {'andymass/vim-matchup', cond = plug_op}
  -- 增强[
  use {'tpope/vim-unimpaired', cond = plug_op}
  -- 移动光标
  use {'justinmk/vim-sneak', cond = plug_op,
    setup = function() require'config/vim-sneak' end}
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
    config = function() require'config/axring' end}
  -- 重复执行
  use {'tpope/vim-repeat', cond = plug_op}

  -- 异步执行
  use {'skywind3000/asyncrun.vim', cond = plug_cmd,
    config = function() require'config/asyncrun' end}
  -- 终端窗口
  use {'voldikss/vim-floaterm', cond = plug_cmd}
  -- 集成Git
  use {'lewis6991/gitsigns.nvim', cond = plug_cmd,
    config = function() require'config/gitsigns' end}
  -- 集成Git
  use {'lambdalisue/gina.vim', cond = plug_cmd}
  -- 切换输入法
  use {'lilydjwg/fcitx.vim', cond = plug_cmd,
    setup = function() vim.g.fcitx5_remote = 'fcitx5-remote' end}
  -- 嵌入浏览器
  use {'glacambre/firenvim',
    cond = function() return vim.g.plug_cmd and vim.g.env_firenvim end,
    config = function() require'config/firenvim' end,
    run = function() vim.fn['firenvim#install'](0) end}

  if vim.g.env_mini then return end

  use {'neoclide/coc.nvim', branch='release', cond = plug_dev,
    config = function() require'config/coc' end}
  use {'nvim-treesitter/nvim-treesitter', cond = plug_dev,
    config = function() require'config/nvim-treesitter' end,
    run = ':TSUpdate'}
  use {'nvim-treesitter/playground', cond = plug_dev}
  use {'romgrk/nvim-treesitter-context', cond = plug_dev}
  use {'nvim-treesitter/nvim-treesitter-textobjects', cond = plug_dev}
  -- 任务系统
  use {'skywind3000/asynctasks.vim', cond = plug_dev}
  -- 代码大纲
  use {'stevearc/aerial.nvim', cond = plug_dev,
    config = function() require'aerial'.setup{} end}
  -- 显示颜色
  use {'rrethy/vim-hexokinase', cond = plug_dev,
    run = 'make hexokinase'}
  -- 展开缩写
  use {'mattn/emmet-vim', cond = plug_dev}
  -- editorconfig
  use {'editorconfig/editorconfig-vim', cond = plug_dev}
  -- 预览markdown
  use {'iamcco/markdown-preview.nvim', cond = plug_dev,
    run = function() vim.fn['mkdp#util#install']() end}
  -- 为markdown生成toc
  use {'mzlogin/vim-markdown-toc', cond = plug_dev}
  -- latex
  use {'lervag/vimtex', cond = plug_dev}
  -- golang
  use {'fatih/vim-go', cond = plug_dev,
    config = function() require'config/vim-go' end}
end)
