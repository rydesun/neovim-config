local cond = vim.g.plug_ui

-- 先占位等待lualine加载，防止加载前的闪烁
if cond then
  vim.o.statusline = ' '
  vim.o.winbar = ' '
end

local spec_ui = require 'libs.lazy-helper' { cond = cond,
  very_lazy = true, spec = {
  { 'folke/snacks.nvim', lazy = false, priority = 1000, opts_file = true },

  -- 配色主题
  { 'sainnhe/everforest', lazy = false, priority = 1000, config_file = true },

  -- 状态栏
  { 'nvim-lualine/lualine.nvim', opts_file = true },

  -- 命令行
  { 'folke/noice.nvim', opts_file = true, lazy = false,
    dependencies = {
      'MunifTanjim/nui.nvim',
      { 'rcarriga/nvim-notify',
        opts = { render = 'wrapped-compact', stages = 'fade' } },
    } },

  -- 图标字体
  { 'nvim-tree/nvim-web-devicons', opts_file = true,
    cond = not vim.g.env_no_icon },
  -- 图标字体回退到ASCII
  { 'echasnovski/mini.icons',
    cond = vim.g.env_no_icon,
    config = function()
      require 'mini.icons'.setup { style = 'ascii' }
      require 'mini.icons'.mock_nvim_web_devicons()
    end },

  -- 平滑滚动
  { 'karb94/neoscroll.nvim', opts_file = true },
} }

local spec_ui_panel = require 'libs.lazy-helper' { cond = cond,
  very_lazy = true, spec = {
  -- 文件浏览器：文件树
  { 'nvim-tree/nvim-tree.lua', opts_file = true,
    cmd = { 'NvimTreeOpen', 'NvimTreeFindFile', 'NvimTreeFindFileToggle' } },

  -- 文件浏览器：编辑目录
  { 'stevearc/oil.nvim', lazy = false, opts_file = true },

  -- 代码大纲结构
  { 'oskarrrrrrr/symbols.nvim', config_file = true, cmd = 'SymbolsToggle' },

  -- QuickFix
  { 'stevearc/quicker.nvim', ft = 'qf', opts_file = true },
  { 'kevinhwang91/nvim-bqf', ft = 'qf', opts_file = true },

  -- 终端窗口
  { 'akinsho/toggleterm.nvim', version = '*', opts_file = true },

  -- 查询
  { 'lewis6991/hover.nvim', opts_file = true, lazy = true },

  -- diff选中文本
  { 'AndrewRadev/linediff.vim', config_file = true },
} }

-- 影响查看文本的方式
local spec_ui_content = require 'libs.lazy-helper' { cond = cond,
  very_lazy = true, spec = {
  -- 高亮文本修改
  { 'rachartier/tiny-glimmer.nvim', opts_file = true },

  -- 高亮非法空白符
  { 'ntpeters/vim-better-whitespace', lazy = false, init_file = true },

  -- 显示颜色代码
  { 'brenoprata10/nvim-highlight-colors', lazy = false, opts_file = true },

  -- 缩进线
  { 'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts_file = true },

  -- 顶部显示上下文
  { 'nvim-treesitter/nvim-treesitter-context', opts_file = true },

  -- 搜索
  { 'kevinhwang91/nvim-hlslens', config_file = true },

  -- 折叠
  { 'kevinhwang91/nvim-ufo', opts_file = true, lazy = false,
    dependencies = 'kevinhwang91/promise-async' },
  { 'chrisgrieser/nvim-origami', opts = {
    foldKeymaps = { hOnlyOpensOnFirstColumn = true } } },

  -- HexEditor
  { 'RaafatTurki/hex.nvim', config = true, lazy = false,
    enabled = vim.fn.executable 'xxd' > 0 },

  -- 预览Markdown
  { 'OXY2DEV/markview.nvim', config = true, ft = 'markdown' },
} }

-- 不可见的交互方式
local spec_ui_hidden = require 'libs.lazy-helper' { cond = cond,
  very_lazy = true, spec = {
  -- Session
  { 'jedrzejboczar/possession.nvim', opts_file = true },
} }

return vim.iter { spec_ui, spec_ui_panel, spec_ui_content, spec_ui_hidden }
    :flatten():totable()
