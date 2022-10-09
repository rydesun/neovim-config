-- <<< 环境
local bool = require('lib').bool
-- 是否作为pager处理文本
vim.g.paging = bool(vim.g.paging)
-- 是否需要处理ANSI转义序列
-- 警告：这将会在在内置终端中输出而不是在当前buffer
vim.g.ansi = bool(vim.g.ansi)
if vim.g.ansi then
  vim.api.nvim_create_autocmd({"VimEnter"}, {
    pattern = {"*"},
    callback = function() require'utils/term-cat'.run(true, true) end
  })
end

-- 是否在小型环境中(非开发)
vim.g.env_mini = bool(vim.env.VIM_MINI)
-- 是否处于Linux console
vim.g.env_console = vim.env.TERM == 'linux'
-- 是否在firenvim中
vim.g.env_firenvim = bool(vim.g.started_by_firenvim)

-- 是否启用该类型的插件
-- 自身界面
vim.g.plug_ui = true
-- 查看文本
vim.g.plug_view = true
-- 操作文本
vim.g.plug_op = true
-- 命令集成
vim.g.plug_cmd = not vim.g.paging
-- 本地开发
vim.g.plug_dev = not vim.g.env_mini and not vim.g.paging
-- >>>-----------------------------------

-- <<< 选项 (自身界面)
if not vim.g.env_console then
  vim.o.termguicolors = true
end
-- 去除启动页面的介绍
vim.opt.shortmess:append('I')
-- 设置虚拟终端的标题
vim.o.title = true
-- 只显示一个窗口的状态栏
vim.o.laststatus = 3
-- 滚动页面时光标距离上下边缘的预留行数
vim.o.scrolloff = 5

-- 开启侧边栏的相对行号
vim.o.relativenumber = true
-- 其他的侧边栏符号覆盖在行号上面
vim.o.signcolumn = 'number'
-- 行号的最低宽度
vim.o.numberwidth = 3
-- 终端不需要侧边栏
vim.api.nvim_create_autocmd({"TermOpen"}, {
  pattern = {"*"},
  callback = function() vim.opt_local.relativenumber = false end
})

if vim.g.paging then
  -- 分页时不需要行号和命令行
  vim.o.relativenumber = false
  vim.o.cmdheight = 0
  -- 分页时不需要状态栏(排除man文件类型)
  -- laststatus会被lualine覆盖，所以需要autocmd
  vim.api.nvim_create_autocmd('UIEnter', {
    pattern = { '*' },
    callback = function()
      if vim.bo.filetype ~= 'man' then vim.o.laststatus = 0 end
    end
  })
end

-- LSP
vim.diagnostic.config{
  -- 不在侧边栏显示符号
  signs = false,
  virtual_text = {
    severity = { min = vim.diagnostic.severity.WARN },
    prefix = '🞬',
  }
}
-- >>>-----------------------------------

-- <<< 选项 (文本内容)
-- 常见文件编码(中文用户)
vim.o.fileencodings = 'ucs-bom,utf-8,sjis,euc-jp,big5,gb18030,latin1'
-- 默认使用unix换行符(并且识别mac)
vim.o.fileformats = 'unix,dos,mac'
-- list模式的可见字符
vim.o.listchars = 'tab:|·,space:␣,trail:☲,extends:►,precedes:◄'
-- 去掉鼠标右键的菜单
vim.o.mousemodel = 'extend'
-- 合并中文行时不加空格
vim.opt.formatoptions:append('B')
-- pattern搜索无视大小写，含大写字符时则必须匹配大小写
vim.o.ignorecase = true
vim.o.smartcase = true
-- 补全路径时的过滤规则
vim.o.wildignore = '*~,*.swp,*.o,*.py[co],__pycache__'
-- >>>-----------------------------------

-- <<< 插件
pcall(function() require'impatient' end)

-- 通过packer.nvim安装的插件
local ok, err = pcall(function() require'plugins' end)
if not ok then
  if err:find([[module 'packer' not found]]) then
    vim.schedule(function ()
      vim.api.nvim_err_writeln('缺少packer.nvim')
    end)
  else error(err) end
end

-- 本地插件
-- tabline
vim.api.nvim_command('packadd tabline')
require 'tabline'.setup()

-- 自动设置工作目录
vim.api.nvim_command('packadd rooter')
require'rooter'.setup{'.git', '.hg', '.svn', 'Makefile', 'package.json'}
-- >>>-----------------------------------

-- <<< 命令行
-- 统计中文字符数量
vim.api.nvim_create_user_command(
  'CountZhChars',
  function(_) require'utils/zh':count() end,
  {}
)

-- 修复中英文间空格
vim.api.nvim_create_user_command(
  'TypoSpace',
  function(_) require'utils/zh':typo_space() end,
  {}
)

local cabbrev = require'utils/cabbrev'

-- 以root权限写入
cabbrev.alias('ww', 'w !sudo tee % >/dev/null')

-- 设置缩进
for _, c in pairs{2, 4, 8} do
  c = tostring(c)
  local input = 'i'..c
  local replace = string.format('setl sw=%s ts=%s et', c, c)
  cabbrev.alias(input, replace)
  input = 'i'..c..'t'
  replace = string.format('setl sw=%s ts=%s noet', c, c)
  cabbrev.alias(input, replace)
end
-- >>>-----------------------------------

-- vim: foldmethod=marker:foldmarker=<<<,>>>:foldlevel=0
