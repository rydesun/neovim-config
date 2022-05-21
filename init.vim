" <<< 环境
let g:confdir = stdpath('config')
let g:datadir = stdpath('data')

" 是否作为pager处理文本
let g:paging = get(g:, 'paging', v:false)
" 是否需要处理ANSI转义序列
" 警告：在内置终端中输出而不是打开buffer
let g:ansi = get(g:, 'ansi', v:false)

" 是否在小型环境中(非开发)
let g:env_mini = $VIM_MINI
" 是否处于Linux console
let g:env_console = $TERM == 'linux'

" 是否启用该类型的插件
let s:plugin_ui = v:true	" 自身界面
let s:plugin_view = v:true	" 查看文本
let s:plugin_op = v:true	" 操作文本
let s:plugin_cmd = !g:paging	" 命令集成
let s:plugin_dev = !g:env_mini && !g:paging	" 本地开发
" >>>-----------------------------------

" <<< 插件
" filetype.lua取代filetype.vim
let g:do_filetype_lua = 1
let g:did_load_filetypes = 0

" 我自己的插件
packadd rooter		" 自动设置工作目录
packadd counter		" 统计中文字符数量
packadd typography	" 修复中英文间空格
packadd foldtext	" 折叠行显示的文本
" 警告：无故不要开启
if g:ansi
	packadd ansi	" 在终端中处理ANSI
endif

" 通过vim-plug安装的插件
try | call plug#begin()
Plug 'nvim-lua/plenary.nvim'		" 补充lua API
Plug 'dstein64/vim-startuptime'		" 检查启动时间
Plug 'lewis6991/impatient.nvim'		" 缓存lua

if s:plugin_ui
Plug 'sainnhe/everforest'		" 配色主题
Plug 'nvim-lualine/lualine.nvim'	" 状态栏
Plug 'kyazdani42/nvim-web-devicons'	" 图标字体
Plug 'kevinhwang91/nvim-hlslens'	" 搜索提示
Plug 'kyazdani42/nvim-tree.lua'		" 文件浏览器
Plug 'nvim-telescope/telescope.nvim'	" 查找
function! UpdateRemotePlugins(...)
	let &rtp=&rtp
	UpdateRemotePlugins
endfunction
Plug 'gelguy/wilder.nvim', {'do': function('UpdateRemotePlugins')}
					" 改进wildmenu
endif

if s:plugin_view
Plug 'psliwka/vim-smoothie', {'commit': '10fd0aa'}
					" 平滑滚动
Plug 'lukas-reineke/indent-blankline.nvim'
					" 缩进线
Plug 'nmac427/guess-indent.nvim'	" 检测缩进
Plug 'ntpeters/vim-better-whitespace'	" 空白符
Plug 'AndrewRadev/linediff.vim'		" 选区diff
Plug 'fidian/hexmode'			" 查看hex
Plug 'voldikss/vim-translator'		" 翻译
endif

if s:plugin_op
Plug 'andymass/vim-matchup'		" 增强%
Plug 'tpope/vim-unimpaired'		" 增强[
Plug 'justinmk/vim-sneak'		" 移动光标
Plug 'mg979/vim-visual-multi'		" 多重光标
Plug 'machakann/vim-sandwich'		" 成对符号
Plug 'urxvtcd/vim-indent-object'	" 缩进对象
Plug 'AndrewRadev/splitjoin.vim'	" 拆分合并
Plug 'numToStr/Comment.nvim'		" 快速注释
Plug 'tenfyzhong/axring.vim'		" 切换单词
Plug 'tpope/vim-repeat'			" 重复执行
endif

if s:plugin_cmd
Plug 'skywind3000/asyncrun.vim'		" 异步执行
Plug 'voldikss/vim-floaterm'		" 终端窗口
Plug 'lewis6991/gitsigns.nvim'		" 集成Git
Plug 'lambdalisue/gina.vim'		" 集成Git
Plug 'lilydjwg/fcitx.vim' | let g:fcitx5_remote = 'fcitx5-remote'
					" 切换输入法(不用python)
Plug 'glacambre/firenvim', {'do': {-> firenvim#install(0)}}
					" 嵌入浏览器
endif

if s:plugin_dev
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'romgrk/nvim-treesitter-context'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'skywind3000/asynctasks.vim'	" 任务系统
Plug 'stevearc/aerial.nvim'		" 代码大纲
Plug 'rrethy/vim-hexokinase', {'do': 'make hexokinase'}
					" 显示颜色
Plug 'mattn/emmet-vim'			" 展开缩写
Plug 'editorconfig/editorconfig-vim'	" editorconfig
Plug 'iamcco/markdown-preview.nvim', {'do': {-> mkdp#util#install()}}
					" 预览markdown
Plug 'mzlogin/vim-markdown-toc'		" 为markdown生成toc
Plug 'lervag/vimtex'			" latex
Plug 'fatih/vim-go'			" golang
endif

call plug#end()
catch /E117.*plug#begin/ | autocmd VimEnter * redraw
			\| echohl ErrorMsg
			\| echo "缺少vim-plug"
			\| echohl NONE
endtry
" >>>-----------------------------------

" 插件设置(按名称排序，优先impatient)
if utils#is_loaded('impatient.nvim') " <<<
lua require('impatient')
endif " >>>-----------------------------------
if utils#is_loaded('aerial.nvim') " <<<
lua require('aerial').setup({})
endif " >>>-----------------------------------
if utils#is_loaded('asyncrun.vim') " <<<
lua require('config/asyncrun')
endif " >>>-----------------------------------
if utils#is_loaded('axring.vim') " <<<
lua require('config/axring')
endif " >>>-----------------------------------
if utils#is_loaded('coc.nvim') " <<<
lua require('config/coc')
endif " >>>-----------------------------------
if utils#is_loaded('Comment.nvim') " <<<
lua require('Comment').setup()
endif " >>>-----------------------------------
if utils#is_loaded('everforest') " <<<
lua require('config/everforest')
endif " >>>-----------------------------------
if utils#is_loaded('firenvim') " <<<
if exists('g:started_by_firenvim')
	lua require('config/firenvim')
endif
endif " >>>-----------------------------------
if utils#is_loaded('gitsigns.nvim') " <<<
lua require('config/gitsigns')
endif " >>>-----------------------------------
if utils#is_loaded('guess-indent.nvim') " <<<
lua require('guess-indent').setup({})
endif " >>>-----------------------------------
if utils#is_loaded('indent-blankline.nvim') " <<<
lua require('config/indent-blankline')
endif " >>>-----------------------------------
if utils#is_loaded('lualine.nvim') " <<<
lua require('config/lualine')
endif " >>>-----------------------------------
if utils#is_loaded('nvim-hlslens') " <<<
lua require('config/nvim-hlslens')
endif " >>>-----------------------------------
if utils#is_loaded('nvim-tree.lua') " <<<
lua require('config/nvim-tree')
endif " >>>-----------------------------------
if utils#is_loaded('nvim-treesitter') " <<<
lua require('config/nvim-treesitter')
endif " >>>-----------------------------------
if utils#is_loaded('nvim-web-devicons') " <<<
lua require'nvim-web-devicons'.setup { default = true }
endif " >>>-----------------------------------
if utils#is_loaded('vim-better-whitespace') " <<<
lua require('config/vim-better-whitespace')
endif " >>>-----------------------------------
if utils#is_loaded('vim-go') " <<<
lua require('config/vim-go')
endif " >>>-----------------------------------
if utils#is_loaded('vim-sneak') " <<<
lua require('config/vim-sneak')
endif " >>>-----------------------------------
if utils#is_loaded('wilder.nvim') " <<<
lua require('config/wilder')
endif " >>>-----------------------------------

" <<< 按键
" 单键
noremap  H  ^
noremap  L  $
noremap  Q  @q
noremap  ;  :
map      :  <Plug>Sneak_;
map      f  <Plug>Sneak_s
map      F  <Plug>Sneak_S
xnoremap <  <gv
xnoremap >  >gv

function! s:show_documentation() abort
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	elseif (coc#rpc#ready())
		call CocActionAsync('doHover')
	endif
endfunction
nnoremap <silent>  K  :call <SID>show_documentation()<CR>


" <Esc>组：关闭
nnoremap <silent>  <Esc><Esc>  :nohlsearch<CR>
nnoremap <silent>  <Esc>q      :cclose<CR>
nnoremap <silent>  <Esc>l      :lclose<CR>
nnoremap <silent>  <Esc>f      :bd<CR>
nnoremap <silent>  <Esc>t      :tabclose<CR>
nnoremap <silent>  <Esc>w      <C-w>c


" s组：搜索列表(telescope.nvim)
" vim-sandwich处理成对符号
nnoremap           s           <NOP>
nnoremap           S           :Telescope<CR>
nnoremap <silent>  ss          :Telescope live_grep theme=dropdown<CR>
nnoremap <silent>  sf          :Telescope find_files theme=dropdown<CR>
nnoremap <silent>  sg          :Telescope git_status theme=dropdown<CR>


" []组：前后跳转
" 插件提供更多映射
nmap     <silent>  [g          <Plug>(coc-diagnostic-prev)
nmap     <silent>  ]g          <Plug>(coc-diagnostic-next)
nmap     <silent>  [G          <Plug>(coc-diagnostic-prev-error)
nmap     <silent>  ]G          <Plug>(coc-diagnostic-next-error)
nnoremap <silent>  ]w          :NextTrailingWhitespace<CR>
nnoremap <silent>  [w          :PrevTrailingWhitespace<CR>


" g组：语法跳转
" splitjoin.vim执行拆分合并
nmap     <silent>  gd          <Plug>(coc-definition)
nmap     <silent>  gy          <Plug>(coc-type-definition)
nmap     <silent>  gi          <Plug>(coc-implementation)
nmap     <silent>  gr          <Plug>(coc-references)


" 其他
nnoremap <silent>  <C-k>       :Gitsigns prev_hunk<CR>
nnoremap <silent>  <C-j>       :Gitsigns next_hunk<CR>
vnoremap           //          y/\V<C-R>=escape(@",'/\')<CR><CR>


" 文本对象
xmap     if        <Plug>(coc-funcobj-i)
omap     if        <Plug>(coc-funcobj-i)
xmap     af        <Plug>(coc-funcobj-a)
omap     af        <Plug>(coc-funcobj-a)
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


" Leader
let g:mapleader=' ' | noremap <Space> <Nop>
vnoremap <silent>  <leader>y   "+y
nnoremap <silent>  <leader>p   "+p
nnoremap <silent>  <leader>P   "+P
nnoremap <silent>  <leader>e   :NvimTreeFindFileToggle<CR>
nnoremap <silent>  <leader>o   :AerialToggle left<CR>
nnoremap <silent>  <leader>k   :TranslateW --engines=haici<CR>
vnoremap <silent>  <leader>k   :Translate --engines=google<CR>


" h组g组：Git Hunk
nnoremap <silent>  <leader>hs  :Gitsigns stage_hunk<CR>
nnoremap <silent>  <leader>hu  :Gitsigns reset_hunk<CR>
nnoremap <silent>  <leader>hU  :Gitsigns undo_stage_hunk<CR>
nnoremap <silent>  <leader>hi  :Gitsigns preview_hunk<CR>
nnoremap <silent>  <leader>gd  :call utils#term_git('d', v:true)<CR>
nnoremap <silent>  <leader>ga  :call utils#term_git('d', v:false)<CR>
nnoremap <silent>  <leader>gs  :call utils#term_git('s', v:false)<CR>
nnoremap <silent>  <leader>gt  :call utils#term_git('ds', v:false)<CR>
nnoremap <silent>  <leader>gc  :Gina commit<CR>


" r组：语法相关的修改
nmap               <leader>rn  <Plug>(coc-rename)
nmap               <leader>rt  <Plug>(coc-refactor)
nmap               <leader>rf  <Plug>(coc-fix-current)
nnoremap <silent>  <leader>rm  :call CocAction('format')<CR>


" t组：操作终端
nnoremap <silent>  <Leader>tt  :FloatermToggle<CR>
nnoremap <silent>  <Leader>ts  :FloatermSend<CR>
vnoremap <silent>  <Leader>ts  :FloatermSend<CR>


" 运行任务
nnoremap <silent>  <Leader>1   :AsyncTask repl<CR>
nnoremap <silent>  <Leader>3   :AsyncTask file-run<CR>
nnoremap <silent>  <Leader>5   :AsyncTask project-run<CR>
nnoremap <silent>  <Leader>7   :AsyncTask project-build<CR>
nnoremap <silent>  <Leader>9   :AsyncTask file-build<CR>


" 其他
nnoremap <silent>  <A-j>       :m .+1<CR>
nnoremap <silent>  <A-k>       :m .-2<CR>
vnoremap <silent>  <A-j>       :m '>+1<CR>==gv
vnoremap <silent>  <A-k>       :m '<-2<CR>==gv
imap               <C-j>       <Plug>(coc-snippets-expand-jump)


" 命令行
cnoremap           <C-a>       <Home>
cnoremap           <C-b>       <Left>
cnoremap           <C-f>       <Right>
cnoremap           <M-b>       <C-Left>
cnoremap           <M-f>       <C-Right>
cnoremap           <C-p>       <Up>
cnoremap           <C-n>       <Down>
cnoremap <expr>    %%          expand('%:p:h').'/'


" 终端
tnoremap <M-space>  <c-\><c-n>


" 特殊情况
if g:paging
	nnoremap q :exit<CR>
endif
" >>>-----------------------------------

" <<< 命令行
lua << EOF
local cabbrev = require'cabbrev'

-- 以root权限写入
cabbrev.expr('ww', 'w !sudo tee % >/dev/null')

-- 设置缩进
for _, c in pairs{2, 4, 8} do
	c = tostring(c)
	input = 'i'..c
	replace = string.format('setl sw=%s ts=%s et', c, c)
	cabbrev.expr(input, replace)
	input = 'i'..c..'t'
	replace = string.format('setl sw=%s ts=%s noet', c, c)
	cabbrev.expr(input, replace)
end
EOF
" >>>-----------------------------------

" <<< 选项
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
" 分页时不需要swapfile 行号 状态栏
if g:paging | set noswapfile norelativenumber laststatus=0 | endif

" 常见文件编码(中文用户)
set fileencodings=ucs-bom,utf-8,sjis,euc-jp,big5,gb18030,latin1
" 默认使用unix换行符(并且识别mac)
set fileformats=unix,dos,mac
" list模式的可见字符
set listchars=tab:\|·,space:␣,trail:☲,extends:►,precedes:◄

set ignorecase		" pattern搜索无视大小写
set smartcase		" pattern搜索含大写字符时则必须匹配大小写
set formatoptions+=B	" 合并中文行时不加空格
set mouse=a		" 所有模式支持鼠标
" 补全路径时的过滤规则
set wildignore+=*~,*.swp,*.o,*.py[co],__pycache__
" >>>-----------------------------------

" vim: foldmethod=marker:foldmarker=<<<,>>>:foldlevel=0
