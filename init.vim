set fileencodings=ucs-bom,utf-8,gbk,big5,gb18030,latin1	" 常见文件编码(中文用户)
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
set inccommand=nosplit	" 替换过程可视化
if $TERM != 'linux'
	set termguicolors
endif

let s:confdir = stdpath('config')	" ${XDG_CONFIG_HOME}/nvim
let s:datadir = stdpath('data')		" ${XDG_DATA_HOME}/nvim
let s:plugdir = s:datadir.'/plugged'	" ${XDG_DATA_HOME}/nvim/插件目录
" 与当前主机相关的配置
let s:hostrc = s:confdir.'/hostrc.vim'
if filereadable(s:hostrc)
	exec 'source' s:hostrc
endif

" netrwhist文件位置
let g:netrw_home=s:datadir


" 键位 <<<------------------------------
noremap  ;  :
noremap  :  ;
noremap  H  ^
noremap  L  $
noremap  '  `
noremap  `  '
nnoremap <silent>  <Esc><Esc>  :nohlsearch<CR>
map                f           <Plug>Sneak_s
map                F           <Plug>Sneak_S
nnoremap <silent>  K           :call <SID>show_documentation()<CR>
nnoremap           s           <NOP>
nnoremap <silent>  sc          :Clap bcommits<CR>
nnoremap <silent>  sf          :Clap files<CR>
nnoremap <silent>  sg          :Clap grep2<CR>
nnoremap <silent>  sl          :Clap blines<CR>
nnoremap <silent>  s;          :Clap command_history<CR>
nmap     <silent>  [g          <Plug>(coc-diagnostic-prev)
nmap     <silent>  ]g          <Plug>(coc-diagnostic-next)
nmap     <silent>  [G          <Plug>(coc-diagnostic-prev-error)
nmap     <silent>  ]G          <Plug>(coc-diagnostic-next-error)
nmap     <silent>  [c          <Plug>(coc-git-prevchunk)
nmap     <silent>  ]c          <Plug>(coc-git-nextchunk)
nnoremap <silent>  ]w          :NextTrailingWhitespace<CR>
nnoremap <silent>  [w          :PrevTrailingWhitespace<CR>
nmap     <silent>  <C-k>       <Plug>(coc-git-prevchunk)
nmap     <silent>  <C-j>       <Plug>(coc-git-nextchunk)
nmap     <silent>  gd          <Plug>(coc-definition)
nmap     <silent>  gy          <Plug>(coc-type-definition)
nmap     <silent>  gi          <Plug>(coc-implementation)
nmap     <silent>  gr          <Plug>(coc-references)

xmap     if        <Plug>(coc-funcobj-i)
omap     if        <Plug>(coc-funcobj-i)
xmap     af        <Plug>(coc-funcobj-a)
omap     af        <Plug>(coc-funcobj-a)

vnoremap //        y/\V<C-R>=escape(@",'/\')<CR><CR>

let g:mapleader=' ' | noremap <Space> <Nop>
vnoremap <silent>  <leader>y   "+y
nnoremap <silent>  <leader>p   "+p
nnoremap <silent>  <leader>P   "+P
map                <leader>c   <Plug>NERDCommenterToggle
xmap               <leader>f   <Plug>(coc-format-selected)
nmap               <leader>f   <Plug>(coc-format-selected)
nnoremap <silent>  <leader>e   :exec 'CocCommand explorer' getcwd()<CR>
nnoremap <silent>  <leader>b   :CocCommand explorer --preset buffer<CR>
nnoremap           <leader>k   :call utils#doc_dash(&ft, expand('<cword>'))<CR>

nnoremap           <leader>hs  :CocCommand git.chunkStage<CR>
nnoremap           <leader>hu  :CocCommand git.chunkUndo<CR>
nmap               <leader>hi  <Plug>(coc-git-chunkinfo)
nmap               <leader>hc  <Plug>(coc-git-commit)

nnoremap <silent>  <leader>gd  :call utils#term_git('d', v:true)<CR>
nnoremap <silent>  <leader>ga  :call utils#term_git('d', v:false)<CR>
nnoremap <silent>  <leader>gs  :call utils#term_git('s', v:false)<CR>
nnoremap <silent>  <leader>gt  :call utils#term_git('ds', v:false)<CR>

nmap               <leader>rn  <Plug>(coc-rename)
nmap               <leader>rf  <Plug>(coc-refactor)

nnoremap <silent>  <leader>lo  :CocList outline<CR>
nnoremap <silent>  <leader>lr  :CocList --number-select tasks<CR>
nnoremap <silent>  <leader>lp  :CocListResume<CR>

nnoremap <silent>  <Leader>tt  :FloatermNew --autoclose=1<CR>
nnoremap <silent>  <leader>tc  :call utils#toggle_workmode()<CR>
nnoremap           <leader>tl  :set list! list?<CR>
nnoremap           <leader>tw  :set wrap! wrap?<CR>
nnoremap <silent>  <leader>ts  :call utils#toggle_signcolumn()<CR>
nnoremap <silent>  <leader>ti  :IndentLinesToggle<CR>

" 注意：ftplugin/{filetype}_keymap.vim文件占用了 <leader>w 开头的映射
nnoremap <silent>  <leader>wf  :call CocAction('format')<CR>

imap               <C-j>       <Plug>(coc-snippets-expand-jump)

cnoremap           <C-a>       <Home>
cnoremap           <C-b>       <Left>
cnoremap           <C-f>       <Right>
cnoremap           <M-b>       <C-Left>
cnoremap           <M-f>       <C-Right>
cnoremap           <C-p>       <Up>
cnoremap           <C-n>       <Down>
cnoremap <expr>    %%          expand('%:p:h').'/'
cabbrev  <expr>    ww          (getcmdtype() == ':' && getcmdline() =~ '^ww$')?
				\ 'w !sudo tee % >/dev/null' : 'ww'

command  -nargs=*  G           call utils#git_wrapper(<f-args>)
cnoreabb <expr>    g           (getcmdtype() == ':' && getcmdline() =~ '^g$')? 'G' : 'g'
command  GetHighlight          echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
command  CountZhCharacters     lua require('count'):cmd_count_zh()
command! -nargs=1 -complete=custom,s:lightline_colorschemes LightlineColorscheme
	\ call s:set_lightline_colorscheme(<q-args>)

tnoremap <M-space>  <c-\><c-n>

lua require('keymap').add_indent_cmds()
" >>>-----------------------------------


" 插件管理器 vim-plug
let g:plug_window = 'new'		" 控制台位置

call plug#begin(s:plugdir)
Plug 'sainnhe/everforest'		" 配色主题
Plug 'itchyny/lightline.vim'		" 状态栏
	" <<< lightline------------------------
	let g:lightline = {
	\ 'subseparator': {'left': '', 'right': ''},
	\ 'separator': {'left': '', 'right': ''},
	\ 'active': {
	\	'left': [
	\	['mode', 'paste'],
	\	['gitBranch', 'gitStatus'],
	\	['modified', 'readonly', 'absolutepath']],
	\	'right': [
	\	['postion'],
	\	['diagnostic'],
	\	['fileformat', 'fileencoding', 'filetype']],
	\ },
	\ 'inactive': {
	\	'left': [['modified', 'readonly', 'absolutepath']],
	\	'right': [
	\	['postion'],
	\	['fileformat', 'fileencoding', 'filetype']],
	\ },
	\ 'component': {
	\	'absolutepath': '%<%F',
	\	'postion': '%2l:%-2v %2p%%',
	\	'fileformat': '%{&ff!=#"unix"?&ff:""}',
	\	'fileencoding': '%{&fenc!=#"utf-8"?&fenc:""}',
	\ },
	\ 'component_function': {
	\	'mode': 'Lightline_mode',
	\	'gitBranch': 'Lightline_gitBranch',
	\	'gitStatus': 'Lightline_gitStatus',
	\	'gitBlame': 'Lightline_gitBlame',
	\	'modified': 'Lightline_modified',
	\	'readonly': 'Lightline_readonly',
	\	'diagnostic': 'Lightline_diagnostic',
	\	'filetype': 'Lightline_filetype',
	\ }}
	function! Lightline_mode() abort
		return lightline#mode()[0]
	endfunction
	function! Lightline_readonly() abort
		return &readonly ? '' : ''
	endfunction
	function! Lightline_modified() abort
		return &modified ? '' : ''
	endfunction
	function! Lightline_gitBranch() abort
		return get(g:, 'coc_git_status', '')
	endfunction
	function! Lightline_gitStatus() abort
		return !empty(get(b:, 'coc_git_status', '')) ? '': ''
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

	function! s:set_lightline_colorscheme(name) abort
		let g:lightline.colorscheme = a:name
		call lightline#init()
		call lightline#colorscheme()
		call lightline#update()
	endfunction
	function! s:lightline_colorschemes(...) abort
		return join(map(
		\ globpath(&rtp, "autoload/lightline/colorscheme/*.vim", 1, 1),
		\ "fnamemodify(v:val, ':t:r')"),
		\ "\n")
		endfunction
	" >>>-----------------------------------

Plug 'lukas-reineke/indent-blankline.nvim'	" 缩进线
	" <<< indent-blankline.nvim ------------
	" 缩进线字符
	let g:indentLine_char = '┊'
	" 不显示空白符
        let g:indent_blankline_space_char = ' '
	" 排除类型
	let g:indent_blankline_filetype_exclude = ['help', 'lspinfo', 'coc-explorer',
		\ 'popup', 'clap_input', 'clap_action']
	let g:indent_blankline_buftype_exclude = ['terminal']
	" >>>-----------------------------------
Plug 'ntpeters/vim-better-whitespace'	" 处理空白符
	" <<< vim-better-whitespace ------------
	let g:better_whitespace_filetypes_blacklist =
		\ ['git', 'diff', 'help', 'qf', 'dbout', 'coc-explorer', 'xxd']
	let g:show_spaces_that_precede_tabs = 1
	" >>>-----------------------------------
Plug 'psliwka/vim-smoothie'		" 平滑滚动
Plug 'ryanoasis/vim-devicons'		" 集成devicons字体
Plug 'editorconfig/editorconfig-vim'
Plug 'chrisbra/vim-diff-enhanced'	" 增强diff算法
	" <<< vim-diff-enhanced ----------------
	if &diff
		let &diffexpr = 'EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'
	endif
	" >>>-----------------------------------
Plug 'fidian/hexmode'			" 编辑16进制文件
	" <<< hexmode --------------------------
	let g:hexmode_patterns = '*.bin,*.exe,*.dat,*.o'
	" >>>-----------------------------------

Plug 'neoclide/coc.nvim',
	\ {'branch': 'release'}		" coc框架
	" <<< coc -----------------------------
	" 修改coc数据目录, 默认值是XDG config目录
	let g:coc_data_home = stdpath('data').'/coc'
	" 强制选项
	set hidden nobackup nowritebackup
	" 推荐选项
	" set cmdheight=2
	set updatetime=300
	function! s:show_documentation() abort
		if (index(['vim','help'], &filetype) >= 0)
			execute 'h '.expand('<cword>')
		elseif (coc#rpc#ready())
			call CocActionAsync('doHover')
		endif
	endfunction
	let s:coc_sources = ["coc-lists", "coc-yank", "coc-tasks"]
	let s:coc_integration = ["coc-git", "coc-explorer", "coc-translator",
				\ "coc-db"]
	let s:coc_snippets = ["coc-snippets",	"coc-emmet"]
	let s:coc_lsp = [
	\	"coc-go", "coc-pyright", "coc-rust-analyzer", "coc-clangd",
	\	"coc-sh", "coc-vimlsp", "coc-lua", "coc-diagnostic",
	\	"coc-tsserver", "coc-eslint",
	\	"coc-css", "coc-stylelint",
	\	"coc-html", "coc-json", "coc-yaml", "coc-toml", "coc-markdownlint",
	\	"coc-xml", "coc-svg", "coc-docker", "coc-texlab",
	\ ]
	let g:coc_global_extensions = [
	\	"coc-highlight",
	\	"coc-pairs",
	\ ] + s:coc_sources + s:coc_integration + s:coc_snippets + s:coc_lsp

	" coc-explorer
	let g:coc_explorer_global_presets = {
		\ 'buffer': {
			\ 'sources': [{'name': 'buffer', 'expand': v:true}],
			\ 'position': 'floating',
			\ 'floating-position': 'center-top',
		\ },
	\ }
	" >>>-----------------------------------
Plug 'liuchengxu/vim-clap',
	\ { 'do': ':Clap install-binary!' }
	" <<< vim-clap -------------------------
	" 只使用cwd
	let g:clap_disable_run_rooter = v:true
	" 样式
	let g:clap_prompt_format = ' %provider_id% %forerunner_status% '
	let g:clap_layout = {'relative': 'editor'}
	let g:clap_preview_direction = 'UD'
	" 无normal模式(Esc立即退出)
	let g:clap_insert_mode_only = v:true
	" >>>-----------------------------------
Plug 'vn-ki/coc-clap'

Plug 'justinmk/vim-sneak'		" 光标定位
	" <<< vim-sneak -----------------------
	" 类似于EasyMotion的标签模式
	let g:sneak#label = 1
	" 智能大小写
	let g:sneak#use_ic_scs = 1
	" >>> ---------------------------------
Plug 'mg979/vim-visual-multi'		" 多重光标
	" <<< vim-visual-multi ----------------
	let g:VM_Extend_hl = 'CursorRange'
	" >>> ---------------------------------
Plug 'mattn/emmet-vim'			" emmet展开缩写
Plug 'tpope/vim-surround'		" 修改成对符号
Plug 'wellle/targets.vim'		" 文本对象
Plug 'tpope/vim-unimpaired'		" 快速跳转
Plug 'jeetsukumaran/vim-indentwise'	" 缩进跳转
Plug 'tpope/vim-repeat'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'scrooloose/nerdcommenter'		" 快速注释
	" <<< nerdcommenter --------------------
	" 取消所有预设键位映射
	let g:NERDCreateDefaultMappings = 0
	" 注释符号后面添加空格
	let g:NERDSpaceDelims = 1
	let g:NERDCustomDelimiters = {'python': {'left': '#', 'right': ''}}
	" 注释符号左对齐
	let g:NERDDefaultAlign='left'
	" >>>-----------------------------------
Plug 'tenfyzhong/axring.vim'		" 切换单词
	" <<< axring ---------------------------
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
	" >>>-----------------------------------

Plug 'voldikss/vim-floaterm'
Plug 'skywind3000/asyncrun.vim'		" 异步执行外部命令
	" <<< asyncrun -------------------------
	" quickfix窗口的默认高度
	let g:asyncrun_open = 6
	" 在firefox中搜索当前单词
	cabbrev <silent> Search AsyncRun -silent firefox -search <cword>
	" >>>-----------------------------------
Plug 'lambdalisue/gina.vim'		" git命令
Plug 'nvim-treesitter/nvim-treesitter',
	\ {'do': ':TSUpdate'}		" treesitter支持
Plug 'nvim-treesitter/playground'	" 调试CST
Plug 'romgrk/nvim-treesitter-context'	" 预览上下文
Plug 'nvim-treesitter/nvim-treesitter-textobjects'	" 文本对象
Plug 'sheerun/vim-polyglot'		" 补充语言包
	" <<< vim-polyglot ---------------------
	" sensible: 禁止使用自带的插件vim-sensible
	let g:polyglot_disabled = ['markdown', 'sensible']
	" >>>-----------------------------------
if !exists('g:HOST_NO_DEV')
Plug 'mzlogin/vim-markdown-toc'		" 为md自动生成TOC
Plug 'iamcco/markdown-preview.nvim',
	\ {'do': 'cd app & yarn install'}	" markdown预览
Plug 'lervag/vimtex'			" latex
Plug 'skywind3000/asynctasks.vim'	" 构建任务系统
	" <<< asynctasks -----------------------
	let g:asynctasks_extra_config = [s:confdir.'/tasks.ini']
	" >>>-----------------------------------
Plug 'fatih/vim-go',
	\ {'do': ':GoUpdateBinaries guru motion'}
	" <<< vim-go ---------------------------
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
	" >>>-----------------------------------

Plug 'puremourning/vimspector'		" 调试工具
	" <<< vimspector -----------------------
	let g:vimspector_enable_mappings = 'HUMAN'
	" >>>-----------------------------------
endif

Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'
	" <<< vim-dadbod-ui --------------------
	let g:db_ui_save_location = s:datadir.'/db_ui'
	let g:db_ui_use_nerd_fonts = 1
	augroup myconfig_dbui
		autocmd!
		autocmd Filetype dbui setlocal shiftwidth=2 tabstop=2 expandtab
	augroup END
	" >>>-----------------------------------

if !exists('g:HOST_NO_X')
Plug 'lilydjwg/fcitx.vim'		" fcitx自动切换语言
Plug 'glacambre/firenvim',
	\ { 'do': { _ -> firenvim#install(0) } }	" 浏览器嵌入neovim
	" <<< firenvim -------------------------
	let g:firenvim_config = {
	\	'globalSettings': {
	\		'alt': 'all',
	\	},
	\	'localSettings': {
	\		'.*': {
	\		'cmdline': 'firenvim',
	\		'priority': 0,
	\		'selector': 'textarea',
	\		'takeover': 'never',
	\		},
	\	}
	\ }

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
	autocmd UIEnter * call OnUIEnter(deepcopy(v:event))

	function! s:IsFirenvimActive(event) abort
		if !exists('*nvim_get_chan_info')
			return 0
		endif
		let l:ui = nvim_get_chan_info(a:event.chan)
		return has_key(l:ui, 'client') && has_key(l:ui.client, 'name') &&
		\ l:ui.client.name =~? 'Firenvim'
	endfunction
	" >>>-----------------------------------
endif
call plug#end()


" 插件加载后
try
	lua require('treesitter')
catch
	echomsg "nvim-treesitter is not loaded"
endtry
" coc-explorer
silent! call coc#config("explorer.file.root.template",
	\ " [git & 1][hidden & 1][root]")
silent! call coc#config("explorer.file.child.template",
	\ "[git | 2][selection | clip | 1] ".
	\ "[indent][icon | 1] [filename omitCenter 1] ".
	\ "[modified][readonly][linkIcon growRight 1 omitCenter 5][size]")
silent! call coc#config("explorer.buffer.root.template",
	\ " [title] [hidden & 1]")
silent! call coc#config("explorer.buffer.child.template",
	\ "[git | 2][selection | 1] [name] [modified][readonly growRight 1][bufname]")


" 自动命令
let g:rootpath_patterns = [
\ '.git', '.hg', '.svn', 'Makefile', 'package.json',
\ ]

augroup myconfig
	" 修复尺寸
	" https://github.com/neovim/neovim/issues/11330#issuecomment-723667383
	autocmd VimEnter * :silent exec "!kill -s SIGWINCH $PPID"
	" 自动设置工作目录
	autocmd VimEnter,BufReadPost,BufEnter *
		\ exec 'lcd '.utils#rootpath(g:rootpath_patterns)
	autocmd BufWritePost * call utils#rootpath_clear() |
		\ exec 'lcd '.utils#rootpath(g:rootpath_patterns)
augroup END

augroup myconfig_term	" 终端模式
	autocmd!
	" 不需要侧边栏
	autocmd TermOpen * setlocal signcolumn=no
augroup END

augroup myconfig_coc	" 插件coc配置
	autocmd!
	" coc的配置文件使用jsonc格式
	autocmd BufRead,BufNewFile coc-settings.json syntax match Comment +\/\/.\+$+

	" coc-explorer界面
	autocmd filetype coc-explorer setlocal fcs=eob:\ 
	autocmd User CocExplorerOpenPost setlocal statusline=%#NonText#

	" 用coc-explorer替换netrw
	autocmd StdinReadPre * let s:std_in=1
	autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in")
		\ | exe 'cd '.argv()[0]
		\ | exe 'CocCommand explorer --position floating' argv()[0]
		\ | wincmd p | bd | endif

	" readonly文件不显示diagnostic
	autocmd BufRead * if &readonly == 1 | let b:coc_diagnostic_disable = 1 | endif
augroup END


" 样式
let g:everforest_background = 'hard'
let g:everforest_sign_column_background = 'none'
let g:everforest_disable_italic_comment = 1

function! s:colorscheme_everforest_custom() abort
	let l:palette = everforest#get_palette(g:everforest_background)

	let g:better_whitespace_guicolor = l:palette.none[0]
	call everforest#highlight('ExtraWhitespace',
		\ l:palette.none, l:palette.none, 'undercurl', l:palette.red)
endfunction

augroup colorscheme
	autocmd!
	autocmd ColorScheme everforest let g:lightline.colorscheme = 'everforest'
	autocmd ColorScheme everforest call s:colorscheme_everforest_custom()
augroup END

silent! colorscheme everforest


" vim: foldmethod=marker:foldmarker=<<<,>>>
