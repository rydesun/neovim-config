-- {{{ 环境
local bool = require 'libs'.bool

-- 是否需要处理ANSI转义序列(在内置终端中输出)
-- 值必须是指定的文件描述符
if bool(vim.g.termcat) then
  vim.g.pager, vim.g.pipe_fd = true, vim.g.termcat
end

-- 是否作为pager处理文本
vim.g.pager = bool(vim.g.pager)

if bool(vim.g.pipe_fd) then
  vim.o.scrollback = 100000
  vim.api.nvim_create_autocmd('VimEnter', {
    pattern = { '*' },
    callback = function()
      local cmd = 'cat </dev/fd/%d && sleep 10000'
      vim.cmd.term(cmd:format(vim.g.pipe_fd))
      vim.bo.filetype = 'termcat'
    end,
  })
end

-- 是否在开发环境中 (判断依据为文件.install_dev)
vim.g.env_dev = bool(vim.fn.filereadable(
  vim.fn.stdpath('data') .. '/lazy/.install_dev'))

-- 是否处于Linux console
vim.g.env_console = vim.env.TERM == 'linux'

-- 是否启用该类型的插件
-- 自身界面
vim.g.plug_ui = true
-- 查看文本
vim.g.plug_view = true
-- 操作文本
vim.g.plug_op = true
-- 命令集成
vim.g.plug_cmd = true
-- 本地开发
vim.g.plug_dev = vim.g.env_dev

-- pager不需要启用这些插件
if vim.g.pager then
  vim.g.plug_cmd = false
  vim.g.plug_dev = false
end

-- obsidian目录
vim.g.obsidian_dir = '~/Data/Documents/Obsidian Vault'
vim.g.obsidian_diary_dir = '日记'
-- }}}

-- {{{ 选项 (自身界面)
if not vim.g.env_console then
  vim.o.termguicolors = true
end
-- 去除启动页面的介绍
vim.opt.shortmess:append 'I'
-- 不在右下角提示搜索
vim.opt.shortmess:append 'S'
-- 不在lastline显示当前模式
vim.o.showmode = false
-- 设置虚拟终端的标题
vim.o.title = true
-- 只显示一个窗口的状态栏
vim.o.laststatus = 3
-- 之后让插件来设置状态栏
if vim.g.plug_ui then vim.o.statusline = ' ' end
-- 滚动页面时光标距离上下边缘的预留行数
vim.o.scrolloff = 5
-- 水平拆分窗口保持内容不动
vim.o.splitkeep = 'screen'
-- 弹出菜单的最大高度
vim.o.pumheight = 16

-- 开启侧边栏的相对行号
vim.o.relativenumber = true
-- 其他的侧边栏符号覆盖在行号上面
vim.o.signcolumn = 'number'
-- 行号的最低宽度
vim.o.numberwidth = 3
-- 终端不需要侧边栏
vim.api.nvim_create_autocmd('TermOpen', {
  pattern = { '*' },
  callback = function() vim.opt_local.relativenumber = false end
})

if vim.g.pager then
  -- 分页时不需要行号和命令行
  vim.o.number = false
  vim.o.relativenumber = false
  vim.o.cmdheight = 0
end

-- LSP
vim.diagnostic.config {
  -- 不在侧边栏显示符号
  signs = false,
  underline = {
    severity = { min = vim.diagnostic.severity.ERROR },
  },
  virtual_text = {
    severity = { min = vim.diagnostic.severity.WARN },
    prefix = '🞬',
  }
}
-- }}}

-- {{{ 选项 (文本内容)
-- 常见文件编码(中文用户)
vim.o.fileencodings = 'ucs-bom,utf-8,gbk,sjis,euc-jp,big5,gb18030,latin1'
-- 默认使用unix换行符(并且识别mac)
vim.o.fileformats = 'unix,dos,mac'
-- list模式的可见字符
vim.o.listchars = 'tab:|·,space:␣,trail:☷,extends:►,precedes:◄'
-- 软换行保持缩进
vim.o.breakindent = true
vim.o.showbreak = '└─'
-- 修改窗口分隔符，隐藏空行的tilde
vim.o.fillchars = 'horiz:▄,horizup:█,horizdown:▄'
    .. ',vert:█,vertleft:█,vertright:█,verthoriz:█'
    .. ',eob: '
if not vim.g.env_console then vim.opt.fillchars:append { diff = '╲' } end
-- 去掉鼠标右键的菜单
vim.o.mousemodel = 'extend'
-- 合并中文行时不加空格
vim.opt.formatoptions:append 'B'
-- pattern搜索无视大小写，含大写字符时则必须匹配大小写
vim.o.ignorecase = true
vim.o.smartcase = true
-- 补全路径时的过滤规则
vim.o.wildignore = '*~,*.swp,*.o,*.py[co],__pycache__'
-- 更好看的diff
vim.opt.diffopt:append 'linematch:60'
-- }}}

-- {{{ 插件
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
vim.opt.rtp:prepend(lazypath)

local ok, lazy = pcall(require, 'lazy')
if ok then
  vim.g.mapleader = ' ' -- lazy需要
  lazy.setup 'plugins'
else
  local msg = '插件没有加载(缺失插件管理器lazy.nvim): 需要执行bootstrap.lua'
  vim.schedule(function() vim.api.nvim_err_writeln(msg) end)
end

-- 本地插件
-- 恢复lazy.nvim修改过的packpath
vim.opt.packpath:prepend(vim.fn.stdpath 'config')

-- 标签栏
vim.cmd 'packadd tabline'
require 'tabline'.setup()

-- 自动设置工作目录
vim.cmd 'packadd rooter'
require 'rooter'.setup { '.git', 'Makefile', 'package.json' }

-- 修改quickfix界面
vim.cmd 'packadd qftf'
-- }}}

-- {{{ 命令行
-- 统计中文字符数量
vim.api.nvim_create_user_command(
  'CountZhChars',
  function() require 'uilts.zh'.count() end,
  {}
)

-- 修复中英文间空格
vim.api.nvim_create_user_command(
  'TypoSpace',
  function() require 'uilts.zh'.typo_space() end,
  {}
)

local cabbrev = require 'utils.cabbrev'

-- 以root权限写入
cabbrev.alias('ww', 'w !sudo tee % >/dev/null')

-- 创建不存在的父目录
cabbrev.alias('mp', '!mkdir -p %:h')

-- 设置缩进
for _, n in pairs { 2, 4, 8 } do
  local c = tostring(n)
  local input = 'i' .. c
  local replace = string.format('setl sw=%s ts=%s et', c, c)
  cabbrev.alias(input, replace)
  input = 'i' .. c .. 't'
  replace = string.format('setl sw=%s ts=%s noet', c, c)
  cabbrev.alias(input, replace)
end
-- }}}

-- {{{ 其他
-- 高亮yank文本
vim.api.nvim_create_autocmd('TextYankPost', {
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'Visual', timeout = 80 }
  end,
})
-- }}}

-- vim: foldmethod=marker:foldlevel=0
