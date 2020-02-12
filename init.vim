scriptencoding utf-8

" 基本配置
let s:plugdir = stdpath('data').'/plugged'	" plugdir 插件路径
set fileencodings=ucs-bom,utf-8,gbk,gb18030,latin1	" 常见文件编码(中文用户)
set ignorecase smartcase	" 大小写智能搜索
set shortmess+=cI	" c关闭补全提示, I关闭空白页信息
set scrolloff=5	" 滚动时光标到上下边缘的预留行数
set hidden	" 保存修改到内存
set title	" 设置虚拟终端的标题
set listchars=tab:\|·,space:␣,trail:☲,extends:►,precedes:◄	" list模式的可见字符
set wildmode=list:longest,full	" 命令行补全方式为列表
set wildignorecase	" 命令行补全文件名时无视大小写
set wildignore+=*~,*.swp,*.bak,*.o,*.py[co],__pycache__	" vim内置通配符的过滤
set splitbelow	" 水平分割的新窗口在下面
set splitright	" 垂直分割的新窗口在右边
set mouse=a	" 所有模式开启鼠标支持

" 键位
noremap  ;  :
noremap  H  ^
noremap  L  $
nnoremap <silent>  <Esc><Esc>  :nohlsearch<CR>
map                /           <Plug>(incsearch-forward)
map                ?           <Plug>(incsearch-backward)
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
map                <Leader>c   <Plug>NERDCommenterToggle
for s:i in [1,2,3,4,5,6,7,8,9]
	" s=1时等同于map  <Leader>1  <Plug>AirlineSelectTab1
	execute 'map <Leader>'.s:i.' <Plug>AirlineSelectTab'.s:i
endfor
nnoremap           <Leader>tl  :set list! list?<CR>
nnoremap           <Leader>tw  :set wrap! wrap?<CR>
nnoremap <silent>  <Leader>ts  :call <SID>signColumn_toggle()<CR>
nnoremap <silent>  <Leader>ti  :IndentLinesToggle<CR>

" 命令行
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

" 插件管理器 vim-plug
let g:plug_window = 'new'	" 控制台打开方式

call plug#begin(s:plugdir)
Plug 'hzchirs/vim-material', {'as': 'theme-material'}					" 配色主题
	" <<<-----------------------------------
	let g:airline_theme='material'
	" >>>-----------------------------------
Plug 'vim-airline/vim-airline', {'as': 'airline'}					" 状态栏
	" <<<-----------------------------------
	" 开启标签栏
	let g:airline#extensions#tabline#enabled = 1
	" 标签栏类型的提示字符
	let g:airline#extensions#tabline#buffers_label = 'Buf'
	let g:airline#extensions#tabline#tabs_label = 'Tab'
	" 标签压缩名字算法
	let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
	" 不显示utf-8[unix]
	let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
	" 模式的提示字符
	let g:airline_mode_map = {'n': 'N', 'i': 'I', 'R': 'R', 'c': 'C', 'v': 'V', 's': 'S'}
	" 修改符号
	if !exists('g:airline_symbols')
		let g:airline_symbols = {}
	endif
	let g:airline_symbols.branch = '⎇ '
	" 状态栏布局调整
	let g:airline#extensions#default#layout = [
		\ ['a', 'c'],
		\ ['x', 'y', 'b', 'z', 'error', 'warning']
	\ ]
	" 内容调整
	let g:airline_section_z = '%p%% %l/%L:%2v'
	" >>>-----------------------------------
Plug 'Yggdroot/indentLine', {'as': 'indent-line'}					" 可视化缩进
	" <<<-----------------------------------
	" 更精细的缩进线
	let g:indentLine_char = '┊'
	" 修复indentLine导致JSON文件的引号无法显示的问题
	autocmd Filetype json let g:indentLine_enabled = 0
	" >>>-----------------------------------
Plug 'tpope/vim-repeat', {'as': 'repeat'}						" 重复支持
Plug 'lilydjwg/fcitx.vim' , {'as': 'fcitx'}						" fcitx切换
Plug 'jiangmiao/auto-pairs'								" 成对符号
Plug 'terryma/vim-multiple-cursors', {'as': 'multiple-cursors'}				" 多重光标
Plug 'haya14busa/incsearch.vim', {'as': 'incsearch'}					" 增量搜索
	" <<<-----------------------------------
	" 不显示光标
	highlight link IncSearchCursor IncSearch
	" >>>-----------------------------------
Plug 'sheerun/vim-polyglot'								" 语言补充
Plug 'neoclide/coc.nvim', {'branch': 'release'}						" LSP客户端
	" <<<-----------------------------------
	" 强制选项
	set hidden nobackup nowritebackup
	" 推荐选项
	" set cmdheight=2
	set signcolumn=yes
	set updatetime=300
	" 高亮光标下的符号
	autocmd CursorHold * silent call CocActionAsync('highlight')
	func! s:show_documentation()
		if (index(['vim','help'], &filetype) >= 0)
			execute 'h '.expand('<cword>')
		else
			call CocAction('doHover')
		endif
	endfunc
	" >>>-----------------------------------
Plug 'scrooloose/nerdcommenter'								" 快速注释
	" <<<-----------------------------------
	" 取消所有预设键位映射
	let g:NERDCreateDefaultMappings = 0
	" 注释符号后面添加空格
	let g:NERDSpaceDelims = 1
	let g:NERDCustomDelimiters = {'python': {'left': '#', 'right': ''}}
	" 注释符号左对齐
	let g:NERDDefaultAlign='left'
	" >>>-----------------------------------
Plug 'airblade/vim-gitgutter', {'as': 'gitgutter'}					" git侧边栏
Plug 'tpope/vim-fugitive', {'as': 'fugitive'}						" git命令封装
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }			" 浏览器内嵌neovim
	" <<<-----------------------------------
	let g:firenvim_config = {
		\ 'globalSettings': {
			\ 'alt': 'all',
		\  },
		\ 'localSettings': {
			\ '.*': {
				\ 'cmdline': 'neovim',
				\ 'priority': 0,
				\ 'selector': 'textarea',
				\ 'takeover': 'never',
			\ },
		\ }
	\ }
	if exists('g:started_by_firenvim')
		set background=light
		au BufEnter github.com_*.txt set filetype=markdown
	endif
	" >>>-----------------------------------
call plug#end()

" 样式
set termguicolors	" 使用GUI配色
silent! colorscheme vim-material	" 配色主题

" 函数 <<<------------------------------
func s:signColumn_toggle()
" 切换侧边栏
	if &signcolumn ==# 'auto'
		setlocal signcolumn=no
		echom 'SignColumn disabled'
	else
		setlocal signcolumn=auto
		echom 'SignColumn enabled'
	endif
endfunc
" >>>-----------------------------------


" vim: foldmethod=marker:foldmarker=<<<---,>>>---
