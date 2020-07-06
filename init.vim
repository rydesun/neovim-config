set fileencodings=ucs-bom,utf-8,gbk,gb18030,latin1	" 常见文件编码(中文用户)
set ignorecase smartcase	" 大小写模糊搜索
set wildignorecase	" 命令行补全文件名时无视大小写
set title		" 设置虚拟终端的标题
set hidden		" 可以切换未保存修改的buffer
set splitbelow		" 水平分割的新窗口在下面打开
set splitright		" 垂直分割的新窗口在右边打开
set mouse=a		" 所有模式下支持鼠标
set signcolumn=yes	" 始终开启侧边栏
set scrolloff=5		" 滚动时光标到上下边缘的预留行数
set shortmess+=cI	" c关闭补全提示, I关闭空白页信息
set diffopt+=vertical	" diff模式默认以垂直方式分割
set wildmode=list:longest,full	" 命令行补全时以列表显示
set listchars=tab:\|·,space:␣,trail:☲,extends:►,precedes:◄	" list模式时的可见字符
set wildignore+=*~,*.swp,*.bak,*.o,*.py[co],__pycache__		" 文件过滤规则

" 与当前主机相关的配置
let s:confdir = expand('<sfile>:p:h')
let s:hostrc = s:confdir.'/hostrc.vim'
if filereadable(s:hostrc)
	exec 'source' s:hostrc
endif

" 函数 <<<------------------------------
" 切换侧边栏
function s:signColumn_toggle() abort
	if &signcolumn ==# 'yes'
		setlocal signcolumn=no
		echom 'SignColumn disabled'
	else
		setlocal signcolumn=yes
		echom 'SignColumn enabled'
	endif
endfunction

" 切换工作模式: 默认git
function s:work_mode_toggle() abort
	if !exists('b:work_mode') || b:work_mode == '' || b:work_mode == 'git'
		let b:work_mode = 'diagnostic'
		nmap <buffer><silent>  <C-k>  <Plug>(coc-diagnostic-prev)
		nmap <buffer><silent>  <C-j>  <Plug>(coc-diagnostic-next)
	else
		let b:work_mode = ''
		nunmap <buffer> <C-k>
		nunmap <buffer> <C-j>
	endif
endfunction

" 封装Gina
function s:gina_wrapper(cmd) abort
	let l:cmd = get({
	\ 'd': 'diff',
	\ 'ds': 'diff --staged',
	\ 'show': 'show',
	\ 'c': 'commit',
	\ }, a:cmd, '')
	if l:cmd == ''
		return
	else
		execute 'Gina'.' '.l:cmd
	endif
endfunction
" >>>-----------------------------------


" 键位 <<<------------------------------
noremap  ;  :
noremap  H  ^
noremap  L  $
nnoremap <silent>  <Esc><Esc>  :nohlsearch<CR>
nnoremap <silent>  K           :call <SID>show_documentation()<CR>
nmap     <silent>  [g          <Plug>(coc-diagnostic-prev)
nmap     <silent>  ]g          <Plug>(coc-diagnostic-next)
nmap     <silent>  [c          <Plug>(coc-git-prevchunk)
nmap     <silent>  ]c          <Plug>(coc-git-nextchunk)
nmap     <silent>  <C-k>       <Plug>(coc-git-prevchunk)
nmap     <silent>  <C-j>       <Plug>(coc-git-nextchunk)
nmap     <silent>  gd          <Plug>(coc-definition)
nmap     <silent>  gy          <Plug>(coc-type-definition)
nmap     <silent>  gi          <Plug>(coc-implementation)
nmap     <silent>  gr          <Plug>(coc-references)

let g:mapleader=' ' | noremap <Space> <Nop>
vnoremap <silent>  <Leader>y   "+y
nnoremap <silent>  <Leader>p   "+p
nnoremap <silent>  <Leader>P   "+P
nnoremap <silent>  <Leader>;   :CocList cmdhistory<CR>
map                <Leader>c   <Plug>NERDCommenterToggle
xmap               <leader>f   <Plug>(coc-format-selected)
nmap               <leader>f   <Plug>(coc-format-selected)
nnoremap <silent>  <Leader>e   :CocCommand explorer<CR>

nnoremap <silent>  <Leader>lm  :CocList mru -A<CR>
nnoremap <silent>  <Leader>lf  :CocList files<CR>
nnoremap <silent>  <Leader>ls  :CocList grep<CR>
nnoremap <silent>  <Leader>ll  :CocList lines<CR>
nnoremap <silent>  <Leader>lw  :CocList --number-select windows<CR>
nnoremap <silent>  <Leader>lb  :CocList --number-select buffers<CR>
nnoremap <silent>  <Leader>ly  :CocList --number-select yank<CR>
nnoremap <silent>  <Leader>lt  :CocList --number-select tasks<CR>
nnoremap <silent>  <Leader>lg  :CocList --number-select gstatus<CR>
nnoremap <silent>  <Leader>lp  :CocListResume<CR>

nnoremap <silent>  <Leader>tc  :call <SID>work_mode_toggle()<CR>
nnoremap           <Leader>tl  :set list! list?<CR>
nnoremap           <Leader>tw  :set wrap! wrap?<CR>
nnoremap <silent>  <Leader>ts  :call <SID>signColumn_toggle()<CR>
nnoremap <silent>  <Leader>ti  :IndentLinesToggle<CR>
nnoremap           <Leader>hs  :CocCommand git.chunkStage<CR>
nnoremap           <Leader>hu  :CocCommand git.chunkUndo<CR>
nmap               <Leader>gi  <Plug>(coc-git-chunkinfo)
nmap               <Leader>gc  <Plug>(coc-git-commit)
nmap               <leader>rn  <Plug>(coc-rename)

imap               <C-j>       <Plug>(coc-snippets-expand-jump)

cnoremap           <C-a>       <Home>
cnoremap           <C-b>       <Left>
cnoremap           <C-f>       <Right>
cnoremap           <M-b>       <C-Left>
cnoremap           <M-f>       <C-Right>
cnoremap           <C-p>       <Up>
cnoremap           <C-n>       <Down>
cnoremap <expr>    %%          expand('%:p:h').'/'
cabbrev  <silent>  ww          w !sudo tee % >/dev/null
for s:i in [2,4,8]
	" s=2时等同于cabbrev  <silent>  i2   setlocal shiftwidth=2 tabstop=2 expandtab
	execute 'ca <silent> i'.s:i.'  setl sw='.s:i.' ts='.s:i.' et'
	" s=2时等同于cabbrev  <silent>  i2t  setlocal shiftwidth=2 tabstop=2 noexpandtab
	execute 'ca <silent> i'.s:i.'t setl sw='.s:i.' ts='.s:i.' noet'
endfor
command -nargs=1  G  call s:gina_wrapper(<f-args>)
cabbrev <silent> g G
" >>>-----------------------------------


" 插件管理器 vim-plug
let s:plugdir = stdpath('data').'/plugged'	" 插件目录
let g:plug_window = 'new'			" 控制台位置

call plug#begin(s:plugdir)
Plug 'kaicataldo/material.vim', {'as': 'theme-material'}		" 配色主题
Plug 'itchyny/lightline.vim', {'as': 'lightline'}			" 状态栏
	" <<< lightline------------------------
	let g:lightline = {
	\ 'colorscheme': 'material',
	\ 'subseparator': {'left': '', 'right': ''},
	\ 'active': {
	\ 	'left': [
	\	['mode', 'paste', 'work_mode'],
	\ 	['gitBranch', 'gitStatus'],
	\	['readonly', 'absolutepath', 'modified']],
	\	'right': [
	\	['winnr', 'postion'],
	\	['diagnostic', 'gitBlame'],
	\	['fileformat', 'filetype'],
	\	['currentFunc']],
	\ },
	\ 'inactive': {
	\ 	'left': [['readonly', 'absolutepath', 'modified']],
	\	'right': [
	\	['winnr', 'postion'],
	\	['fileformat', 'filetype']],
	\ },
	\ 'component': {
	\	'work_mode': '%{get(b:, "work_mode", "")}',
	\	'postion': '%2l:%-2v %2p%%',
	\	'winnr': '%{winnr()}',
	\ 	'fileformat': '%{&ff!=#"unix"?&ff:""}',
	\ },
	\ 'component_function': {
	\ 	'gitBranch': 'Lightline_gitBranch',
	\ 	'gitStatus': 'Lightline_gitStatus',
	\ 	'gitBlame': 'Lightline_gitBlame',
	\	'readonly': 'Lightline_readonly',
	\	'currentFunc': 'Lightline_currentFunc',
	\	'diagnostic': 'Lightline_diagnostic',
	\	'filetype': 'Lightline_filetype',
	\ },
	\ 'mode_map': {'n':'N', 'i':'I', 'R':'R', 'v':'V', 'V':'V', "\<C-v>":'V',
	\              'c':'C', 's':'S', 'S':'S', "\<C-s>":'S', 't':'T'},
	\ }
	function! Lightline_readonly() abort
		return &readonly ? '' : ''
	endfunction
	function! Lightline_gitBranch() abort
		return get(g:, 'coc_git_status', '')
	endfunction
	function! Lightline_gitStatus() abort
		return get(b:, 'coc_git_status', '')
	endfunction
	function! Lightline_gitBlame() abort
		return get(b:, 'coc_git_blame', '')
	endfunction
	function! Lightline_currentFunc() abort
		return get(b:, 'coc_current_function', '')
	endfunction
	function! Lightline_diagnostic() abort
		let info = get(b:, 'coc_diagnostic_info', {})
		if empty(info) | return '' | endif
		let msgs = []
		if get(info, 'error', 0)
			call add(msgs, 'E' . info['error'])
		endif
		if get(info, 'warning', 0)
			call add(msgs, 'W' . info['warning'])
		endif
		if get(info, 'information', 0)
			call add(msgs, 'I' . info['information'])
		endif
		if get(info, 'hint', 0)
			call add(msgs, 'H' . info['hint'])
		endif
		return join(msgs, ' ')
	endfunction
	function! Lightline_filetype()
		return strlen(&filetype) ? WebDevIconsGetFileTypeSymbol().' '.&filetype : ''
	endfunction
	" >>>-----------------------------------
Plug 'Yggdroot/indentLine', {'as': 'indentLine'}			" 缩进线
	" <<< indentLine -----------------------
	" 更精细的缩进线
	let g:indentLine_char = '┊'
	augroup myconfig_indentLine
		autocmd!
		" FIXME: 在markdown中与vim-polyglot不兼容; 以及其他bug
		autocmd Filetype markdown let g:indentLine_enabled = 0
	augroup END
	" >>>-----------------------------------
Plug 'psliwka/vim-smoothie', {'as': 'smoothie'}				" 平滑滚动
Plug 'ryanoasis/vim-devicons', {'as': 'devicons'}			" 集成devicons字体

Plug 'neoclide/coc.nvim', {'as': 'coc', 'branch': 'release'}		" coc框架
	" <<< coc -----------------------------
	" 强制选项
	set hidden nobackup nowritebackup
	" 推荐选项
	" set cmdheight=2
	set updatetime=300
	function! s:show_documentation() abort
		if (index(['vim','help'], &filetype) >= 0)
			execute 'h '.expand('<cword>')
		else
			call CocAction('doHover')
		endif
	endfunction
	let s:coc_sources = ["coc-lists", "coc-yank", "coc-tasks"]
	let s:coc_integration = ["coc-git", "coc-explorer", "coc-translator"]
	let s:coc_snippets = ["coc-snippets",	"coc-template",	"coc-emmet"]
	let s:coc_lsp = [
	\	"coc-go", "coc-python", "coc-sh", "coc-vimlsp", "coc-diagnostic",
	\	"coc-tsserver", "coc-eslint",
	\	"coc-css", "coc-stylelint",
	\	"coc-html", "coc-json", "coc-yaml", "coc-markdownlint",
	\ ]
	let g:coc_global_extensions = [
	\	"coc-highlight",
	\	"coc-pairs",
	\ ] + s:coc_sources + s:coc_integration + s:coc_snippets + s:coc_lsp
	" >>>-----------------------------------

Plug 'mattn/emmet-vim'							" emmet展开缩写
Plug 'tpope/vim-surround', {'as': 'surround'}				" 修改成对符号
Plug 'tpope/vim-repeat', {'as': 'repeat'}				" 配合surround插件支持dot重复
Plug 'tpope/vim-sleuth', {'as': 'autoIndent'}                           " 自动设置缩进
Plug 'scrooloose/nerdcommenter'						" 快速注释
	" <<< nerdcommenter --------------------
	" 取消所有预设键位映射
	let g:NERDCreateDefaultMappings = 0
	" 注释符号后面添加空格
	let g:NERDSpaceDelims = 1
	let g:NERDCustomDelimiters = {'python': {'left': '#', 'right': ''}}
	" 注释符号左对齐
	let g:NERDDefaultAlign='left'
	" >>>-----------------------------------
Plug 'terryma/vim-multiple-cursors', {'as': 'multiple-cursors'}		" 多重光标

Plug 'skywind3000/asyncrun.vim'						" 异步执行外部命令
	" <<< asyncrun -------------------------
	" quickfix窗口的默认高度
	let g:asyncrun_open = 6
	" 在firefox中搜索当前单词
	cabbrev <silent> Search AsyncRun -silent firefox -search <cword>
	" >>>-----------------------------------
Plug 'lambdalisue/gina.vim', {'as': 'gina'}				" git命令
Plug 'sheerun/vim-polyglot', {'as': 'polyglot'}				" 补充语言包
if !exists('g:HOST_NO_DEV')
Plug 'iamcco/markdown-preview.nvim', {'as': 'markdown-preview',
			\ 'do': 'cd app & yarn install'}		" markdown预览
Plug 'skywind3000/asynctasks.vim'					" 构建任务系统
	" <<< asynctasks -----------------------
	let g:asynctasks_extra_config = [s:confdir.'/tasks.ini']
	" >>>-----------------------------------

Plug 'puremourning/vimspector', {'do': './install_gadget.py
			\ --enable-go --enable-python --enable-bash'}	" 调试工具
	" <<< vimspector -----------------------
	let g:vimspector_enable_mappings = 'HUMAN'
	" >>>-----------------------------------
endif

if !exists('g:HOST_NO_X')
Plug 'lilydjwg/fcitx.vim' , {'as': 'fcitx'}				" fcitx自动切换语言
endif
call plug#end()


" 自动命令
augroup myconfig_coc	" 插件coc配置
	autocmd!
	" coc的配置文件使用jsonc格式
	autocmd BufRead,BufNewFile coc-settings.json syntax match Comment +\/\/.\+$+
augroup END


" 样式
if $TERM != 'linux'
	set termguicolors
endif
silent! colorscheme material
let s:color_accent="#009688"
let s:color_contrast="#13272c"

if exists('g:material_theme_style') && g:material_theme_style == "default"
	" 垂直分割条
	highlight VertSplit guifg=black
	" 色柱
	exec "highlight ColorColumn guibg="s:color_contrast
endif

if exists('g:material_colorscheme_map')
	" 高亮搜索光标处
	exec "highlight IncSearch ctermfg=11 ctermbg=0
		\ guifg="g:material_colorscheme_map.comments.gui"
		\ guibg="g:material_colorscheme_map.white.gui
	" coc error
	exec "highlight CocErrorSign
		\ guifg="g:material_colorscheme_map.pink.gui
	exec "highlight CocErrorHighlight
		\ guifg="g:material_colorscheme_map.pink.gui"
		\ guibg="s:color_contrast
	" coc warning
	exec "highlight CocWarningSign
		\ guifg="g:material_colorscheme_map.brown.gui
	exec "highlight CocWarningHighlight
		\ guifg="g:material_colorscheme_map.brown.gui"
		\ guibg="s:color_contrast
	" coc info
	exec "highlight CocInfoSign
		\ guifg="g:material_colorscheme_map.purple.gui
	exec "highlight CocInfoHighlight
		\ guifg="g:material_colorscheme_map.purple.gui"
		\ guibg="s:color_contrast
	" coc hint
	exec "highlight CocHintSign
		\ guifg="s:color_accent
	exec "highlight CocHintHighlight
		\ guifg="s:color_accent"
		\ guibg="s:color_contrast
endif

" vim: foldmethod=marker:foldmarker=<<<,>>>
