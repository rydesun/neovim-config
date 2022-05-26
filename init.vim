" <<< 环境
lua << EOF
lib = require('lib')
-- 是否作为pager处理文本
vim.g.paging = lib.bool(vim.g.paging)
-- 是否需要处理ANSI转义序列
-- 警告：这将会在在内置终端中输出而不是在当前buffer
vim.g.ansi = lib.bool(vim.g.ansi)
if vim.g.ansi then
  vim.api.nvim_create_autocmd({"VimEnter"}, {
    pattern = {"*"},
    callback = function() require'utils/term_cat'.run(true, true) end
  })
end

-- 是否在小型环境中(非开发)
vim.g.env_mini = lib.bool(vim.env.VIM_MINI)
-- 是否处于Linux console
vim.g.env_console = vim.env.TERM == 'linux'
-- 是否在firenvim中
vim.g.env_firenvim = lib.bool(vim.g.started_by_firenvim)

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
EOF
" >>>-----------------------------------

" <<< 选项 (自身界面)
if !g:env_console | set termguicolors | endif

set shortmess+=I	" 去除启动页面的介绍
set title		" 设置虚拟终端的标题
set laststatus=3	" 只显示一个窗口的状态栏
set scrolloff=5		" 滚动页面时光标距离上下边缘的预留行数

set relativenumber	" 开启侧边栏的相对行号
set signcolumn=number	" 其他的侧边栏符号覆盖在行号上面
set numberwidth=3	" 行号的最低宽度
" 终端不需要侧边栏
augroup myconfig_term_signcolumn | autocmd!
	autocmd TermOpen * setlocal norelativenumber
augroup END
" 分页时不需要行号 状态栏
if g:paging | set norelativenumber laststatus=0 | endif
" >>>-----------------------------------

" <<< 选项 (文本内容)
" 常见文件编码(中文用户)
set fileencodings=ucs-bom,utf-8,sjis,euc-jp,big5,gb18030,latin1
" 默认使用unix换行符(并且识别mac)
set fileformats=unix,dos,mac
" list模式的可见字符
set listchars=tab:\|·,space:␣,trail:☲,extends:►,precedes:◄
" 所有模式支持鼠标
set mouse=a
" 合并中文行时不加空格
set formatoptions+=B
" pattern搜索无视大小写，含大写字符时则必须匹配大小写
set ignorecase smartcase
" 补全路径时的过滤规则
set wildignore+=*~,*.swp,*.o,*.py[co],__pycache__
" >>>-----------------------------------

" <<< 插件
lua << EOF
pcall(function() require'impatient' end)

-- 通过packer.nvim安装的插件
status, err = pcall(function() require'plugins' end)
if not status then
  if err:find([[module 'packer' not found]]) then
    vim.api.nvim_create_autocmd({"VimEnter"}, {
      pattern = {"*"},
      callback = function() require'utils/msg'.err('缺少packer.nvim') end
    })
  else error(err) end
end

-- 用filetype.lua取代filetype.vim
vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0
EOF

" 本地插件
packadd foldtext	" 折叠行显示的文本
packadd rooter		" 自动设置工作目录
lua require'rooter'.setup{'.git', '.hg', '.svn', 'Makefile', 'package.json'}
" >>>-----------------------------------

" <<< 命令行
lua << EOF
-- 统计中文字符数量
vim.api.nvim_create_user_command(
  'CountZhChars',
  function(opts) require'utils/zh':count() end,
  {}
)

-- 修复中英文间空格
vim.api.nvim_create_user_command(
  'TypoSpace',
  function(opts) require'utils/zh':typo_space() end,
  {}
)

local cabbrev = require'utils/cabbrev'

-- 以root权限写入
cabbrev.alias('ww', 'w !sudo tee % >/dev/null')

-- 设置缩进
for _, c in pairs{2, 4, 8} do
  c = tostring(c)
  input = 'i'..c
  replace = string.format('setl sw=%s ts=%s et', c, c)
  cabbrev.alias(input, replace)
  input = 'i'..c..'t'
  replace = string.format('setl sw=%s ts=%s noet', c, c)
  cabbrev.alias(input, replace)
end
EOF
" >>>-----------------------------------

" <<< 按键 (非默认行为)
noremap  H  ^
noremap  L  $
noremap  Q  @q
noremap  ;  :
map      :  <Plug>Sneak_;
map      f  <Plug>Sneak_s
map      F  <Plug>Sneak_S
xnoremap <  <gv
xnoremap >  >gv
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
if g:paging | nnoremap q :exit<CR> | endif

" s组：搜索列表(telescope.nvim)
" vim-sandwich处理成对符号
nnoremap           s           <NOP>
nnoremap           S           :Telescope<CR>
nnoremap <silent>  ss          :Telescope live_grep theme=dropdown<CR>
nnoremap <silent>  sb          :Telescope buffers theme=dropdown previewer=false<CR>
nnoremap <silent>  sf          :Telescope find_files theme=dropdown previewer=false<CR>
nnoremap <silent>  sg          :Telescope git_status theme=dropdown previewer=false<CR>

" g组：语法跳转
" splitjoin.vim执行拆分合并
nmap     <silent>  gd          <Plug>(coc-definition)
nmap     <silent>  gy          <Plug>(coc-type-definition)
nmap     <silent>  gi          <Plug>(coc-implementation)
nmap     <silent>  gr          <Plug>(coc-references)
" >>>-----------------------------------

" <<< 按键 (新增行为)
" <Esc>组：关闭
nnoremap <silent>  <Esc><Esc>  :nohlsearch<CR>
nnoremap <silent>  <Esc>q      :cclose<CR>
nnoremap <silent>  <Esc>l      :lclose<CR>
nnoremap <silent>  <Esc>f      :bd<CR>
nnoremap <silent>  <Esc>t      :tabclose<CR>
nnoremap <silent>  <Esc>w      <C-w>c

" []组：前后跳转
" 插件提供更多映射
nmap     <silent>  [g          <Plug>(coc-diagnostic-prev)
nmap     <silent>  ]g          <Plug>(coc-diagnostic-next)
nmap     <silent>  [G          <Plug>(coc-diagnostic-prev-error)
nmap     <silent>  ]G          <Plug>(coc-diagnostic-next-error)
nnoremap <silent>  ]w          :NextTrailingWhitespace<CR>
nnoremap <silent>  [w          :PrevTrailingWhitespace<CR>
nnoremap <silent>  [of         :set laststatus=2<CR>
nnoremap <silent>  ]of         :set laststatus=3<CR>
nnoremap <silent>  [om         :set colorcolumn=80<CR>
nnoremap <silent>  ]om         :set colorcolumn=<CR>

" Ctrl Alt
imap               <C-j>       <Plug>(coc-snippets-expand-jump)
nnoremap <silent>  <C-k>       :Gitsigns prev_hunk<CR>
nnoremap <silent>  <C-j>       :Gitsigns next_hunk<CR>
nnoremap <silent>  <A-j>       :m .+1<CR>
nnoremap <silent>  <A-k>       :m .-2<CR>
vnoremap <silent>  <A-j>       :m '>+1<CR>==gv
vnoremap <silent>  <A-k>       :m '<-2<CR>==gv
" >>>-----------------------------------

" <<< 按键 (Leader)
let g:mapleader=' ' | noremap <Space> <Nop>
" 单键
vnoremap <silent>  <leader>y   "+y
nnoremap <silent>  <leader>p   "+p
nnoremap <silent>  <leader>P   "+P
nnoremap <silent>  <leader>e   :NvimTreeFindFileToggle<CR>
nnoremap <silent>  <leader>o   :AerialToggle left<CR>
nnoremap <silent>  <leader>k   :TranslateW --engines=haici<CR>
vnoremap <silent>  <leader>k   :Translate --engines=google<CR>
nnoremap <silent>  <leader>K   :lua require'utils/devdocs':open_cursor()<CR>

" 数字组：运行
nnoremap <silent>  <Leader>1   :AsyncTask repl<CR>
nnoremap <silent>  <Leader>3   :AsyncTask file-run<CR>
nnoremap <silent>  <Leader>5   :AsyncTask project-run<CR>
nnoremap <silent>  <Leader>7   :AsyncTask project-build<CR>
nnoremap <silent>  <Leader>9   :AsyncTask file-build<CR>

" h组g组：Git Hunk
nnoremap <silent>  <leader>gd  :lua require'utils/term_git'.run('diff', true)<CR>
nnoremap <silent>  <leader>ga  :lua require'utils/term_git'.run('diff', false)<CR>
nnoremap <silent>  <leader>gs  :lua require'utils/term_git'.run('show', false)<CR>
nnoremap <silent>  <leader>gt  :lua require'utils/term_git'.run('diff --staged', false)<CR>
nnoremap <silent>  <leader>gc  :Gina commit<CR>
nnoremap <silent>  <leader>hs  :Gitsigns stage_hunk<CR>
nnoremap <silent>  <leader>hu  :Gitsigns reset_hunk<CR>
nnoremap <silent>  <leader>hU  :Gitsigns undo_stage_hunk<CR>
nnoremap <silent>  <leader>hi  :Gitsigns preview_hunk<CR>

" r组：语法相关的修改
nmap               <leader>rn  <Plug>(coc-rename)
nmap               <leader>rt  <Plug>(coc-refactor)
nmap               <leader>rf  <Plug>(coc-fix-current)
nnoremap <silent>  <leader>rm  :call CocAction('format')<CR>

" t组：操作终端
nnoremap <silent>  <Leader>tt  :FloatermToggle<CR>
nnoremap <silent>  <Leader>ts  :FloatermSend<CR>
vnoremap <silent>  <Leader>ts  :FloatermSend<CR>
" >>>-----------------------------------

" <<< 按键 (文本对象)
" 缩进
xmap     ii        <Plug>(indent-object_linewise-none)
omap     ii        <Plug>(indent-object_blockwise-none)
xmap     ai        <Plug>(indent-object_linewise-start)
omap     ai        <Plug>(indent-object_linewise-start)
xmap     iI        <Plug>(indent-object_linewise-end)
omap     iI        <Plug>(indent-object_linewise-end)
xmap     aI        <Plug>(indent-object_linewise-both)
omap     aI        <Plug>(indent-object_linewise-both)
omap     ij        <Plug>(indent-object_linewise-none-keep-start)
xmap     ij        <Plug>(indent-object_linewise-none-keep-start)
omap     ik        <Plug>(indent-object_linewise-none-keep-end)
xmap     ik        <Plug>(indent-object_linewise-none-keep-end)
omap     iJ        <Plug>(indent-object_linewise-end-keep-start)
xmap     iJ        <Plug>(indent-object_linewise-end-keep-start)
omap     iK        <Plug>(indent-object_linewise-start-keep-end)
xmap     iK        <Plug>(indent-object_linewise-start-keep-end)
omap     ibj       <Plug>(indent-object_blockwise-none-keep-start)
xmap     ibj       <Plug>(indent-object_blockwise-none-keep-start)
omap     ibJ       <Plug>(indent-object_blockwise-end-keep-start)
xmap     ibJ       <Plug>(indent-object_blockwise-end-keep-start)
omap     ibk       <Plug>(indent-object_blockwise-none-keep-end)
xmap     ibk       <Plug>(indent-object_blockwise-none-keep-end)
omap     ibK       <Plug>(indent-object_blockwise-start-keep-end)
xmap     ibK       <Plug>(indent-object_blockwise-start-keep-end)
" >>>-----------------------------------

" <<< 按键 (命令行)
cnoremap           <C-a>       <Home>
cnoremap           <C-b>       <Left>
cnoremap           <C-f>       <Right>
cnoremap           <M-b>       <C-Left>
cnoremap           <M-f>       <C-Right>
cnoremap           <C-p>       <Up>
cnoremap           <C-n>       <Down>
cnoremap <expr>    %%          expand('%:p:h').'/'
" >>>-----------------------------------

" <<< 按键 (终端)
tnoremap <M-space>  <c-\><c-n>
" >>>-----------------------------------

" vim: foldmethod=marker:foldmarker=<<<,>>>:foldlevel=0
