scriptencoding utf-8
" 配置初始化
let s:plugdir = stdpath('data').'/plugged'	" plugdir 插件路径

" 函数 <<<------------------------------
func SignColumnToggle()
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

" 基本配置
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
map      <silent>  K           :call <SID>show_documentation()<CR>
map                [g          <Plug>(coc-diagnostic-prev)
map                ]g          <Plug>(coc-diagnostic-next)
map                gd          <Plug>(coc-definition)
map                gy          <Plug>(coc-type-definition)
map                gi          <Plug>(coc-implementation)
map                gr          <Plug>(coc-references)

nnoremap <silent>  <F2>        :set list! list?<CR>
nnoremap <silent>  <F3>        :set wrap! wrap?<CR>
nnoremap <silent>  <F5>        :call SignColumnToggle()<CR>
nnoremap <silent>  <F6>        :IndentLinesToggle<CR>

let g:mapleader=' ' | noremap <Space> <Nop>
vnoremap <silent>  <Leader>y   "+y
nnoremap <silent>  <Leader>p   "+p
nnoremap <silent>  <Leader>P   "+P
nnoremap <silent>  <Leader>j   :call LanguageClient_textDocument_definition()<CR>
map                <Leader>c   <Plug>NERDCommenterToggle
for s:i in [1,2,3,4,5,6,7,8,9]
	execute 'map <Leader>'.s:i. ' ' .'<Plug>AirlineSelectTab'.s:i
endfor

" 命令行
cnoremap           <C-a>       <Home>
cnoremap           <C-e>       <End>
cnoremap           <C-p>       <Up>
cnoremap           <C-n>       <Down>
cnoremap <expr>    %%          expand('%:p:h').'/'
cabbrev  <silent>  ww          w !sudo tee % >/dev/null
cabbrev  <silent>  i2          setlocal shiftwidth=2 tabstop=2 expandtab
cabbrev  <silent>  i4          setlocal shiftwidth=4 tabstop=4 expandtab
cabbrev  <silent>  i8          setlocal shiftwidth=8 tabstop=8 noexpandtab

" 插件管理器 vim-plug
let g:plug_window = 'new'	" 控制台打开方式

call plug#begin(s:plugdir)
Plug 'morhetz/gruvbox', {'as': 'theme-gruvbox'}						" 配色主题
	" <<<-----------------------------------
	let g:gruvbox_invert_selection = 0	" V模式不反色
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
	let g:airline_symbols.branch = '⎇'
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
Plug 'neoclide/coc.nvim', {'branch': 'release'}						" LSP客户端
	" <<<-----------------------------------
	" 强制选项
	set hidden nobackup nowritebackup
	" 推荐选项
	" set cmdheight=2
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
call plug#end()

" 样式
set background=dark	" 暗色背景
set termguicolors	" 使用GUI配色
silent! colorscheme gruvbox	" 配色主题
highlight Normal guibg=#161616
highlight SignColumn guibg=#1a2020
highlight Folded guibg=#1a2020
highlight! link ALEError GruvboxRedSign
highlight! link ALEWarning GruvboxYellowSign
highlight! link ALEInfo GruvboxBlueSign


" vim: foldmethod=marker:foldmarker=<<<---,>>>---
