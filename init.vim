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
set wildmode=list:longest,full	" 命令行补全时以列表显示
set listchars=tab:\|·,space:␣,trail:☲,extends:►,precedes:◄	" list模式时的可见字符
set wildignore+=*~,*.swp,*.bak,*.o,*.py[co],__pycache__		" 文件过滤规则


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
" >>>-----------------------------------


" 键位 <<<------------------------------
noremap  ;  :
noremap  H  ^
noremap  L  $
nnoremap <silent>  <Esc><Esc>  :nohlsearch<CR>
nnoremap <silent>  K           :call <SID>show_documentation()<CR>
nmap     <silent>  [g          <Plug>(coc-diagnostic-prev)
nmap     <silent>  ]g          <Plug>(coc-diagnostic-next)
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

nnoremap           <Leader>tl  :set list! list?<CR>
nnoremap           <Leader>tw  :set wrap! wrap?<CR>
nnoremap <silent>  <Leader>ts  :call <SID>signColumn_toggle()<CR>
nnoremap <silent>  <Leader>ti  :IndentLinesToggle<CR>

imap               <C-j>       <Plug>(coc-snippets-expand-jump)

cnoremap           <C-a>       <Home>
cnoremap           <C-e>       <End>
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
" >>>-----------------------------------


" 插件管理器 vim-plug
let s:plugdir = stdpath('data').'/plugged'	" 插件目录
let g:plug_window = 'new'			" 控制台位置

call plug#begin(s:plugdir)
Plug 'kaicataldo/material.vim', {'as': 'theme-material'}		" 配色主题
Plug 'itchyny/lightline.vim', {'as': 'lightline'}			" 状态栏
	" <<<-----------------------------------
	let g:lightline = {
	\ 'colorscheme': 'material',
	\ 'active': {
	\ 	'left': [ [ 'mode', 'paste' ],
	\ 	[ 'gitbranch', 'winnr', 'readonly', 'absolutepath', 'modified' ] ]
	\ },
	\ 'component': {
	\   'lineinfo': '%2l:%-2v',
	\ },
	\ 'component_function': {
	\	'readonly': 'Lightline_readonly',
	\ 	'gitbranch': 'Lightline_gitbranch'
	\ },
	\ 'mode_map': {'n':'N', 'i':'I', 'R':'R', 'v':'V', 'V':'V', "\<C-v>":'V',
	\              'c':'C', 's':'S', 'S':'SL', "\<C-s>":'S', 't':'T'},
	\ }
	function! Lightline_readonly() abort
		return &readonly ? '' : ''
	endfunction
	function! Lightline_gitbranch() abort
		if !exists('*FugitiveHead')
			return ''
		endif
		let branch = FugitiveHead()
		if branch ==# ''
			return ''
		endif
		let branch_abbr = branch ==# 'master' ? 'M' : branch
		return '⎇  '.branch_abbr
	endfunction
	" >>>-----------------------------------
Plug 'Yggdroot/indentLine', {'as': 'indent-line'}			" 缩进线
	" <<<-----------------------------------
	" 更精细的缩进线
	let g:indentLine_char = '┊'
	" 修复indentLine导致JSON文件的引号无法显示的问题
	autocmd Filetype json let g:indentLine_enabled = 0
	" >>>-----------------------------------

Plug 'tpope/vim-repeat', {'as': 'repeat'}				" 重复支持
Plug 'lilydjwg/fcitx.vim' , {'as': 'fcitx'}				" fcitx
Plug 'jiangmiao/auto-pairs'						" 成对符号
Plug 'terryma/vim-multiple-cursors', {'as': 'multiple-cursors'}		" 多重光标

Plug 'sheerun/vim-polyglot'						" 语言包
Plug 'neoclide/coc.nvim', {'branch': 'release'}				" 补全和LSP
	" <<<-----------------------------------
	" 强制选项
	set hidden nobackup nowritebackup
	" 推荐选项
	" set cmdheight=2
	set updatetime=300
	" 高亮光标下的符号
	autocmd CursorHold * silent call CocActionAsync('highlight')
	function! s:show_documentation() abort
		if (index(['vim','help'], &filetype) >= 0)
			execute 'h '.expand('<cword>')
		else
			call CocAction('doHover')
		endif
	endfunction
	" >>>-----------------------------------
Plug 'scrooloose/nerdcommenter'						" 快速注释
	" <<<-----------------------------------
	" 取消所有预设键位映射
	let g:NERDCreateDefaultMappings = 0
	" 注释符号后面添加空格
	let g:NERDSpaceDelims = 1
	let g:NERDCustomDelimiters = {'python': {'left': '#', 'right': ''}}
	" 注释符号左对齐
	let g:NERDDefaultAlign='left'
	" >>>-----------------------------------
Plug 'airblade/vim-gitgutter', {'as': 'gitgutter'}			" git侧边栏
Plug 'tpope/vim-fugitive', {'as': 'fugitive'}				" git命令封装

Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }	" 浏览器支持嵌入neovim
	" <<<-----------------------------------
	let g:firenvim_config = {
	\ 	'globalSettings': {
	\ 		'alt': 'all',
	\ 	},
	\ 	'localSettings': {
	\ 		'.*': {
	\ 		'cmdline': 'neovim',
	\ 		'priority': 0,
	\ 		'selector': 'textarea',
	\ 		'takeover': 'never',
	\ 		},
	\ 	}
	\ }
	if exists('g:started_by_firenvim')
		set background=light
		au BufEnter github.com_*.txt set filetype=markdown
	endif
	" >>>-----------------------------------
call plug#end()

" 样式
silent! colorscheme material
if $TERM != 'linux'
	set termguicolors
endif
exec "highlight IncSearch ctermfg=11 ctermbg=0
	\ guifg="g:material_colorscheme_map.comments"
	\ guibg="g:material_colorscheme_map.white


" vim: foldmethod=marker:foldmarker=<<<---,>>>---
