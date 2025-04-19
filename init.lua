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
  vim.fn.stdpath 'data' .. '/lazy/.install_dev'))

-- 是否处于Linux console
vim.g.env_console = vim.env.TERM == 'linux' and vim.fn.has 'gui_running' == 0

vim.g.env_no_icon = vim.g.env_console

-- 是否启用该类型的插件
-- Bar、面板、视觉效果
vim.g.plug_ui = true
-- 改进文本操作方式
vim.g.plug_op_motion = true
vim.g.plug_op_edit = true
-- 与外部命令和资源集成
vim.g.plug_cmd = true
-- 本地开发
vim.g.plug_dev = vim.g.env_dev

-- pager不需要启用这些插件
if vim.g.pager then
  vim.g.plug_op_edit = false
  vim.g.plug_cmd = false
  vim.g.plug_dev = false
end

-- obsidian目录
vim.g.obsidian_dir = '~/Data/Documents/Obsidian Vault'

vim.g.rust_playground_dir = '~/test/playground'
-- }}}

-- {{{ 选项 (自身界面)
if not vim.g.env_console then
  vim.o.termguicolors = true
end
-- 去除启动页面的介绍
vim.opt.shortmess:append 'I'
-- 不在lastline显示当前模式
vim.o.showmode = false
-- 设置虚拟终端的标题
vim.o.title = true
-- 滚动页面时光标距离上下边缘的预留行数
vim.o.scrolloff = 5
vim.cmd 'autocmd FileType qf setlocal scrolloff=0'
-- 水平拆分窗口保持内容不动
vim.o.splitkeep = 'screen'
-- 弹出菜单的最大高度
vim.o.pumheight = 16
-- 预览整个文件范围的替换
vim.o.inccommand = 'split'

-- 开启侧边栏的相对行号
vim.o.relativenumber = true
-- 其他的侧边栏符号覆盖在行号上面
vim.o.signcolumn = 'number'
-- 行号的最低宽度
vim.o.numberwidth = 2
-- 然后交给plugin/statuscolumn.lua设置stc

local function disable_number()
  vim.opt_local.number = false
  vim.opt_local.relativenumber = false
end
-- 分页或者终端不需要行号
if vim.g.pager then disable_number() end
vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '*', callback = disable_number,
})

-- LSP
vim.diagnostic.config {
  -- 不在侧边栏显示符号
  signs = false,
  virtual_text = { prefix = '🞬' },
  jump = { float = true },
}
-- }}}

-- {{{ 选项 (文本内容)
-- 常见文件编码(中文用户)
vim.o.fileencodings = 'ucs-bom,utf-8,gbk,sjis,euc-jp,big5,gb18030,latin1'
-- 默认使用unix换行符(并且识别mac)
vim.o.fileformats = 'unix,dos,mac'
-- list模式的可见字符
vim.o.listchars = 'tab:|·,space:␣,trail:␣,extends:►,precedes:◄'
-- 软换行保持缩进
vim.o.breakindent = true
vim.o.showbreak = '▲'
-- 隐藏空行的tilde
vim.o.fillchars = 'eob: ,diff:·'
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
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
vim.opt.rtp:prepend(lazypath)

local ok, lazy = pcall(require, 'lazy')
if ok then
  vim.g.mapleader = ' ' -- lazy需要
  vim.g.maplocalleader = '\\'
  lazy.setup 'plugins'
else
  local msg = '插件没有加载(缺失插件管理器lazy.nvim): 需要执行bootstrap.lua'
  vim.schedule(function() vim.notify(msg, vim.log.levels.WARN) end)
end

-- 本地插件
-- 恢复lazy.nvim修改过的packpath
vim.opt.packpath:prepend(vim.fn.stdpath 'config')

-- 标签栏
vim.cmd 'packadd tabline'
require 'tabline'.setup(vim.g.env_no_icon and {} or {
  terminal_ok = '✔', terminal_fail = '✖',
})

-- 自动设置工作目录
vim.cmd 'packadd rooter'
require 'rooter'.setup {
  -- 目录内包含(向上检查每一级父目录)
  { mode = 'contains', upward = true,
    '.git', 'package.json', 'Cargo.toml', 'pyproject.toml', 'Makefile' },
  -- 目录内包含(向下检查每一级子目录)
  { mode = 'contains', upward = false,
    '__init__.py' },
  -- 目录名匹配(向上检查每一级父目录)
  { mode = 'dirname', upward = true,
    'src', 'etc' },
}

-- 检测gotmpl文件类型
-- TS需要安装gotmpl和html
vim.cmd.packadd 'gotmpl'

-- 其他小工具
vim.cmd 'packadd utils'
require 'utils'.setup()
-- }}}

-- {{{ 命令行
local cmd_alias = require 'libs'.cmd_alias

-- 以root权限写入
cmd_alias('ww', 'w !sudo tee % >/dev/null')

-- 创建不存在的父目录
cmd_alias('mp', '!mkdir -p %:h')

-- 设置缩进
for _, n in pairs { 2, 4, 8 } do
  local c = tostring(n)
  local input = 'i' .. c
  local replace = string.format('setl sw=%s ts=%s et', c, c)
  cmd_alias(input, replace)
  input = 'i' .. c .. 't'
  replace = string.format('setl sw=%s ts=%s noet', c, c)
  cmd_alias(input, replace)
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

-- ripgrep
if vim.fn.executable 'rg' > 0 then
  vim.o.grepprg = 'rg --vimgrep --smart-case'
  vim.o.grepformat = '%f:%l:%c:%m'
end
vim.cmd 'autocmd QuickFixCmdPost *grep* cwindow'
vim.api.nvim_create_user_command('G', 'silent! grep! <args>',
  { nargs = '+', complete = 'file' })
vim.api.nvim_create_user_command('Gadd', 'silent! grepadd! <args>',
  { nargs = '+', complete = 'file' })
vim.api.nvim_create_user_command('Gfix',
  'G FIXME | Gadd TODO', {})
vim.api.nvim_create_user_command('Gfixall',
  'G FIXME | Gadd TODO | Gadd XXX | Gadd HACK', {})
-- }}}

-- vim: foldmethod=marker:foldlevel=0
