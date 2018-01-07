" 配置初始化
let s:confdir = expand('<sfile>:p:h')	" confdir 配置文件路径
let s:plugdir = s:confdir.'/site'	" plugdir 插件路径

" 函数 <<<------------------------------
func SignColumnToggle()
" 切换侧边栏
	if &signcolumn == "auto"
		setlocal signcolumn=no
		echom "SignColumn disabled"
	else
		setlocal signcolumn=auto
		echom "SignColumn enabled"
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
set wildignore+=*~,*.swp,*.bak,*.py[co],__pycache__	" vim内置通配符的过滤

" 键位
noremap  ;  :
noremap  H  ^
noremap  L  $
nnoremap <silent>  <Esc><Esc>  :nohlsearch<CR>
map                /           <Plug>(incsearch-forward)
map                ?           <Plug>(incsearch-backward)
nnoremap <silent>  K           :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent>  gq          :call LanguageClient_textDocument_formatting()<CR>

nnoremap <silent>  <F2>        :set list! list?<CR>
nnoremap <silent>  <F3>        :set wrap! wrap?<CR>
nnoremap <silent>  <F5>        :call SignColumnToggle()<CR>
nnoremap <silent>  <F6>        :IndentLinesToggle<CR>

let mapleader=' ' | noremap <Space> <Nop>
vnoremap <silent>  <Leader>y   "+y
nnoremap <silent>  <Leader>j   :call LanguageClient_textDocument_definition()<CR>
map                <Leader>c   <Plug>NERDCommenterToggle
for i in [1,2,3,4,5,6,7,8,9]
	execute "map <Leader>".i. " " ."<Plug>AirlineSelectTab".i
endfor

" 命令行
cnoremap           <C-a>       <Home>
cnoremap           <C-e>       <End>
cnoremap           <C-p>       <Up>
cnoremap           <C-n>       <Down>
cnoremap <expr>    %%          expand('%:p:h').'/'
cabbrev  <silent>  ww          w !sudo tee % >/dev/null
cabbrev  <silent>  i4          setlocal shiftwidth=4 tabstop=4 expandtab
cabbrev  <silent>  i8          setlocal shiftwidth=8 tabstop=8 noexpandtab
cabbrev  <silent>  rename      call LanguageClient_textDocument_rename()

" 插件管理器 vim-plug
let g:plug_window = 'new'

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
	let g:airline_section_z = "%p%% %l/%L:%v"
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
Plug 'Shougo/denite.nvim', {'as': 'denite', 'do': ':UpdateRemotePlugins'}		" 搜索
Plug 'autozimu/LanguageClient-neovim', {'as': 'language-client',
	\ 'branch': 'next', 'do': 'install.sh'}						" LSP
	" <<<-----------------------------------
	" [c/c++]: `pacman -S clang-tools-extra`
	" [python]: `pip install --user python-language-server jedi rope pyflakes mccabe pycodestyle pydocstyle yapf`
	" [go]: `go get -u github.com/sourcegraph/go-langserver github.com/nsf/gocode`
	" [javascript]: `npm install javascript-typescript-langserver`
	" [html]: `npm install vscode-html-languageserver-bin`
	" [css]: `npm install vscode-css-languageserver-bin`
	" [vue]: `npm install vue-language-server`
	" [dockerfile]: `npm install dockerfile-language-server-nodejs`
	" [json]: `npm install vscode-json-languageserver-bin`
	let g:LanguageClient_serverCommands = {
		\ 'c': ['clangd'],
		\ 'cpp': ['clangd'],
		\ 'python': ['pyls'],
		\ 'go': ['go-langserver', '-gocodecompletion'],
		\ 'javascript': ['javascript-typescript-stdio'],
		\ 'html': ['html-languageserver', '--stdio'],
		\ 'css': ['css-languageserver', '--stdio'],
		\ 'vue': ['vls'],
		\ 'dockerfile': ['docker-langserver', '--stdio'],
		\ 'json': ['json-languageserver', '--stdio'],
	\ }
	set formatexpr=LanguageClient_textDocument_rangeFormatting()
	" >>>-----------------------------------
Plug 'roxma/nvim-completion-manager', {'as': 'ncm'}					" 补全管理器
	" <<<-----------------------------------
	" 取消默认源，启用LSP补全
	let g:cm_sources_override = {
		\ 'cm-jedi': {'enable': 0},
		\ 'cm-gocode': {'enable': 0},
		\ 'cm-css': {'enable': 0},
	\ }
	" 使用模糊匹配
	let g:cm_matcher = {"module": "cm_matchers.fuzzy_matcher"}
	" 按优先级设置激活长度
	let g:cm_refresh_length = [[1,3],[9,2]]
	" 多线程数
	let g:cm_multi_threading = 4
	" >>>-----------------------------------
Plug 'SirVer/ultisnips'									" 代码片段补全
Plug 'scrooloose/nerdcommenter'								" 快速注释
	" <<<-----------------------------------
	" 取消所有预设键位映射
	let g:NERDCreateDefaultMappings = 0
	" 注释符号后面添加空格
	let g:NERDSpaceDelims = 1
	let g:NERDCustomDelimiters = {'python': {'left': '#', 'right': ''}}
	" 注释符号左对齐
	let g:NERDDefaultAlign="left"
	" >>>-----------------------------------
Plug 'airblade/vim-gitgutter', {'as': 'gitgutter'}					" git侧边栏
Plug 'tpope/vim-fugitive', {'as': 'fugitive'}						" git命令封装
call plug#end()

" 样式
set background=dark	" 暗色背景
set termguicolors	" 使用GUI配色
silent! colorscheme gruvbox	" 配色主题
highlight SignColumn guibg=#1a2422
highlight Folded guibg=#1a2422


" vim: foldmethod=marker:foldmarker=<<<---,>>>---
