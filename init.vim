" <<< 环境
let s:confdir = stdpath('config')
let s:datadir = stdpath('data')

" 是否在小型环境中(非开发)
let s:env_mini = $VIM_MINI
" 是否作为pager处理文本
let s:paging = get(g:, 'paging', v:false)
" 是否处于Linux console
let s:env_console = $TERM == 'linux'

" 是否启用该类型的插件
let s:plugin_ui = v:true	" 自身界面
let s:plugin_view = v:true	" 查看文本
let s:plugin_op = v:true	" 操作文本
let s:plugin_cmd = !s:paging	" 命令集成
let s:plugin_dev = !s:env_mini && !s:paging	" 本地开发
" >>>-----------------------------------

" <<< 插件

" filetype.lua取代filetype.vim
let g:do_filetype_lua = 1
let g:did_load_filetypes = 0

" 我自己的插件
packadd rooter		" 自动设置工作目录
packadd counter		" 统计中文字符数量
packadd typography	" 修复中英文间空格
packadd ansi		" 处理ANSI转义序列

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
Plug 'lilydjwg/fcitx.vim'		" 切换输入法
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
function! s:floaterm_repl(opts)
	exec "FloatermNew --wintype=split --position=top ".a:opts.cmd
	stopinsert | wincmd p
endfunction
function! s:floaterm_bottom(opts)
	exec "FloatermNew --wintype=split --position=bottom ".a:opts.cmd
endfunction
let g:asyncrun_runner = get(g:, 'asyncrun_runner', {})
let g:asyncrun_runner.floaterm_repl = function('s:floaterm_repl')
let g:asyncrun_runner.floaterm_bottom = function('s:floaterm_bottom')
" quickfix窗口的默认高度
let g:asyncrun_open = 6
endif " >>>-----------------------------------
if utils#is_loaded('asynctasks.vim') " <<<
let g:asynctasks_extra_config = [s:confdir.'/tasks.ini']
endif " >>>-----------------------------------
if utils#is_loaded('axring.vim') " <<<
let g:axring_rings = [
	\ ['&&', '||'],
	\ ['&', '|', '^'],
	\ ['&=', '|=', '^='],
	\ ['>>', '<<'],
	\ ['>>=', '<<='],
	\ ['==', '!='],
	\ ['===', '!=='],
	\ ['>', '<', '>=', '<='],
	\ ['++', '--'],
	\ ['true', 'false'],
	\ ['verbose', 'debug', 'info', 'warn', 'error', 'fatal'],
\ ]
let g:axring_rings_go = [
	\ [':=', '='],
	\ ['byte', 'rune'],
	\ ['complex64', 'complex128'],
	\ ['int', 'int8', 'int16', 'int32', 'int64'],
	\ ['uint', 'uint8', 'uint16', 'uint32', 'uint64'],
	\ ['float32', 'float64'],
	\ ['interface', 'struct'],
	\ ['debug', 'info', 'warn', 'error', 'panic', 'fatal'],
\ ]
endif " >>>-----------------------------------
if utils#is_loaded('coc.nvim') " <<<
" format函数
set formatexpr=CocAction('formatSelected')

" 修改coc数据目录, 默认值是XDG config目录
let g:coc_data_home = s:datadir.'/coc'

function! s:show_documentation() abort
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	elseif (coc#rpc#ready())
		call CocActionAsync('doHover')
	endif
endfunction

augroup myconfig_coc
	autocmd!
	" 补全跳转后显示函数签名
	autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

	" readonly文件不显示diagnostic
	autocmd BufRead * if &readonly == 1 | let b:coc_diagnostic_disable = 1 | endif
augroup END
endif " >>>-----------------------------------
if utils#is_loaded('Comment.nvim') " <<<
lua require('Comment').setup()
endif " >>>-----------------------------------
if utils#is_loaded('everforest') " <<<
let g:everforest_better_performance = 1
" 使用终端自身的配色
let g:everforest_disable_terminal_colors = 1
if &background == 'dark'
	let g:everforest_background = 'hard'
else
	let g:everforest_background = 'soft'
endif
let g:everforest_sign_column_background = 'none'
let g:everforest_disable_italic_comment = 1

function! s:colorscheme_everforest_custom() abort
	let l:palette = everforest#get_palette(g:everforest_background)

	call everforest#highlight('Folded',
		\ l:palette.aqua, l:palette.bg1)

	let g:better_whitespace_guicolor = l:palette.none[0]
	call everforest#highlight('ExtraWhitespace',
		\ l:palette.none, l:palette.none, 'undercurl', l:palette.red)

	call everforest#highlight('IndentBlanklineContextChar',
		\ l:palette.grey2, l:palette.none)

	" rust
	call everforest#highlight('CocRustTypeHint',
		\ l:palette.grey0, l:palette.none)
	call everforest#highlight('CocRustChainingHint',
		\ l:palette.grey2, l:palette.none)

	if s:nvim_as_pager
		call everforest#highlight('MsgArea',
			\ l:palette.none, l:palette.bg2)
	endif
endfunction

augroup colorscheme_everforest
	autocmd!
	autocmd ColorScheme everforest call s:colorscheme_everforest_custom()
augroup END
endif " >>>-----------------------------------
if utils#is_loaded('firenvim') " <<<
let g:firenvim_config = {
	\ 'globalSettings': {
		\ 'alt': 'all',
	\ },
	\ 'localSettings': {
		\ '.*': {
			\ 'cmdline': 'firenvim',
			\ 'priority': 0,
			\ 'selector': 'textarea',
			\ 'takeover': 'never',
			\ },
	\ }
\ }

augroup myconfig_firenvim_init
	autocmd!
	autocmd UIEnter * call OnUIEnter(deepcopy(v:event))
augroup END

function! OnUIEnter(event) abort
	if !s:IsFirenvimActive(a:event)
		return
	endif
	set laststatus=0
	if &lines < 10
		set lines=10
	endif
	augroup myconfig_firenvim
		autocmd!
		autocmd BufEnter github.com_*.txt set filetype=markdown
		autocmd BufEnter *ipynb_*DIV-*.txt set filetype=python
	augroup END
endfunction

function! s:IsFirenvimActive(event) abort
	if !exists('*nvim_get_chan_info')
		return 0
	endif
	let l:ui = nvim_get_chan_info(a:event.chan)
	return has_key(l:ui, 'client') && has_key(l:ui.client, 'name') &&
		\ l:ui.client.name =~? 'Firenvim'
endfunction
endif " >>>-----------------------------------
if utils#is_loaded('gitsigns.nvim') " <<<
lua require('config/gitsigns')
endif " >>>-----------------------------------
if utils#is_loaded('guess-indent.nvim') " <<<
lua require('guess-indent').setup({})
endif " >>>-----------------------------------
if utils#is_loaded('hexmode') " <<<
let g:hexmode_patterns = '*.bin,*.exe,*.dat,*.o'
endif " >>>-----------------------------------
if utils#is_loaded('indent-blankline.nvim') " <<<
" 缩进线字符
if !s:env_console | let g:indentLine_char = '┊' | endif
" 不显示第一层
let g:indent_blankline_show_first_indent_level = v:false
" 不在末尾行上显示
let g:indent_blankline_show_trailing_blankline_indent = v:false
" 优先使用treesitter计算缩进
let g:indent_blankline_use_treesitter = v:true
let g:indent_blankline_use_treesitter_scope = v:true
" 高亮上下文
let g:indent_blankline_show_current_context = v:true
endif " >>>-----------------------------------
if utils#is_loaded('lualine.nvim') " <<<
lua require('config/lualine')
endif " >>>-----------------------------------
if utils#is_loaded('nvim-hlslens') " <<<
noremap <silent> n <Cmd>execute('normal! ' . v:count1 . 'n')<CR>
	\<Cmd>lua require('hlslens').start()<CR>
noremap <silent> N <Cmd>execute('normal! ' . v:count1 . 'N')<CR>
	\<Cmd>lua require('hlslens').start()<CR>
noremap  *   *<Cmd>lua require('hlslens').start()<CR>
noremap  #   #<Cmd>lua require('hlslens').start()<CR>
noremap  g*  g*<Cmd>lua require('hlslens').start()<CR>
noremap  g#  g#<Cmd>lua require('hlslens').start()<CR>

augroup myconfig_vmlens
    autocmd!
    autocmd User visual_multi_start lua require('config/vmlens').start()
    autocmd User visual_multi_exit lua require('config/vmlens').exit()
augroup END

lua << EOF
require('hlslens').setup({
	nearest_only = true,
})
EOF
endif " >>>-----------------------------------
if utils#is_loaded('nvim-tree.lua') " <<<
augroup myconfig_explorer
	autocmd!
	" 如果是最后一个窗口则直接退出
	autocmd BufEnter * ++nested
		\ if winnr('$') == 1 && bufname() == 'NvimTree_'.tabpagenr()
		\ | quit | endif
augroup END

lua require('config/nvim-tree')
endif " >>>-----------------------------------
if utils#is_loaded('nvim-treesitter') " <<<
lua require('config/nvim-treesitter')
endif " >>>-----------------------------------
if utils#is_loaded('nvim-web-devicons') " <<<
lua require'nvim-web-devicons'.setup { default = true }
endif " >>>-----------------------------------
if utils#is_loaded('vim-better-whitespace') " <<<
let g:better_whitespace_filetypes_blacklist =
	\ ['dbout', 'xxd']
let g:show_spaces_that_precede_tabs = 1
endif " >>>-----------------------------------
if utils#is_loaded('vim-go') " <<<
" 只安装特定工具，优先使用coc-go提供的功能
" 关闭gopls
let g:go_gopls_enabled = 0
" 禁用omnifunc补全
let g:go_code_completion_enabled = 0
" 关闭vim-go的按键映射
let g:go_doc_keywordprg_enabled = 0 " 查看文档
let g:go_def_mapping_enabled = 0 " 跳转定义
" 禁止在保存时自动执行GoFmt
let g:go_fmt_autosave = 0
endif " >>>-----------------------------------
if utils#is_loaded('vim-sandwich') " <<<
let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)
let g:sandwich#recipes += [
	\ {'buns': ["( ", " )"], 'nesting': 1, 'match_syntax': 1, 'input': [')'] },
	\ {'buns': ["[ ", " ]"], 'nesting': 1, 'match_syntax': 1, 'input': [']'] },
	\ {'buns': ["{ ", " }"], 'nesting': 1, 'match_syntax': 1, 'input': ['}'] },
\ ]
endif " >>>----------------------------------
if utils#is_loaded('vim-sneak') " <<<
" 类似于EasyMotion的标签模式
let g:sneak#label = 1
" 智能大小写
let g:sneak#use_ic_scs = 1
endif " >>>-----------------------------------
if utils#is_loaded('vim-visual-multi') " <<<
let g:VM_Extend_hl = 'CursorRange'
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
nnoremap <silent>  ss          :Telescope live_grep<CR>
nnoremap <silent>  sf          :Telescope find_files<CR>


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
if s:paging
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
" 主题
silent! colorscheme everforest
if !s:env_console | set termguicolors | endif

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
if s:paging | set noswapfile norelativenumber laststatus=0 | endif

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

" 折叠行显示的文本
if &foldtext == 'foldtext()'
	function! Foldtext() abort
		let l:start = getline(v:foldstart)
		let l:cnt = v:foldend - v:foldstart - 1
		if &foldmethod == 'marker'
			let l:comment = substitute(&commentstring, '%s', '', '')
			let l:marker = &foldmarker[:stridx(&foldmarker, ',')-1]
			let l:text = substitute(l:start, l:marker, '', '')
			let l:text = substitute(l:text, l:comment, '', '')
			let l:text = trim(l:text)
			return '＋❰'.printf('%3d', l:cnt).'❱ '.l:text
		else
			let l:end = trim(getline(v:foldend))
			" TODO: 应该根据闭合状态判断
			if l:end =~ '^\s*[_a-zA-Z0-9]'
				let l:cnt += 1
				return l:start.' ❰'.l:cnt.'❱'
			endif
			if l:cnt == 0
				return l:start.' '.l:end
			else
				return l:start.' ❰'.l:cnt.'❱ '.l:end
			end
		endif
	endfunction
	set foldtext=Foldtext()
endif
" >>>-----------------------------------

" vim: foldmethod=marker:foldmarker=<<<,>>>:foldlevel=0
