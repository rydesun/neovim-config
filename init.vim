" <<< 环境
let s:confdir = stdpath('config')	" ${XDG_CONFIG_HOME}/nvim
let s:datadir = stdpath('data')		" ${XDG_DATA_HOME}/nvim
let s:plugdir = s:datadir.'/plugged'	" ${XDG_DATA_HOME}/nvim/plugged

" 是否处于Linux console
let s:env_console = $TERM == 'linux'
" 是否作为pager处理文本
let s:paging = get(g:, 'paging', v:false)

" 是否启用该类型的插件
let s:plugin_ui = v:true	" 自身界面
let s:plugin_view = v:true	" 查看文本
let s:plugin_op = v:true	" 操作文本
let s:plugin_ft = !s:paging	" 文件类型
let s:plugin_proj = !s:paging	" 项目管理
let s:plugin_dev = !s:paging	" 本地开发
let s:plugin_cmd = !s:paging	" 外部命令
let s:plugin_gui = !s:paging	" 桌面环境
let s:plugin_misc = !s:paging	" 其他
" >>>-----------------------------------

" <<< 插件
" 我自己的插件
packadd rooter		" 自动设置工作目录
packadd counter		" 统计中文字符数量
packadd typography	" 修复中英文间空格

" 通过vim-plug安装的插件
call plug#begin(s:plugdir)
Plug 'nvim-lua/plenary.nvim'		" 补充lua API

if s:plugin_ui
Plug 'sainnhe/everforest'		" 配色主题
Plug 'itchyny/lightline.vim'		" 状态栏
Plug 'kyazdani42/nvim-web-devicons'	" 图标字体
Plug 'kevinhwang91/nvim-hlslens'	" 搜索提示
Plug 'gelguy/wilder.nvim',
	\ {'do': ':UpdateRemotePlugins'}	" 改进wildmenu
endif

if s:plugin_view
Plug 'lukas-reineke/indent-blankline.nvim'	" 缩进线
Plug 'ntpeters/vim-better-whitespace'	" 空白符
Plug 'rrethy/vim-hexokinase',
	\ {'do': 'make hexokinase'}	" 显示颜色
Plug 'AndrewRadev/linediff.vim'		" 选区diff
Plug 'psliwka/vim-smoothie',
	\ { 'commit': '10fd0aa' }	" 平滑滚动
Plug 'fidian/hexmode'			" 查看16进制
Plug 'stevearc/aerial.nvim'
endif

if s:plugin_ft
Plug 'nvim-treesitter/nvim-treesitter',
	\ {'do': ':TSUpdate'} |
	\ Plug 'nvim-treesitter/playground' |
	\ Plug 'romgrk/nvim-treesitter-context' |
	\ Plug 'nvim-treesitter/nvim-treesitter-textobjects'
" vim-polyglot 自带缩进检测插件autoindent
" 禁止使用自带的插件sensible
let g:polyglot_disabled = ['sensible']
Plug 'sheerun/vim-polyglot'
endif

if s:plugin_op
Plug 'wellle/targets.vim'		" 文本对象
Plug 'tpope/vim-unimpaired'		" 快速跳转
Plug 'jeetsukumaran/vim-indentwise'	" 缩进跳转
Plug 'justinmk/vim-sneak'		" 光标定位
Plug 'kshenoy/vim-signature'		" 快速标记
Plug 'mg979/vim-visual-multi'		" 多重光标
Plug 'machakann/vim-sandwich'		" 成对符号
Plug 'AndrewRadev/splitjoin.vim'	" 拆分合并
Plug 'scrooloose/nerdcommenter'		" 快速注释
Plug 'tenfyzhong/axring.vim'		" 切换单词
Plug 'tpope/vim-repeat'			" 重复执行
Plug 'mattn/emmet-vim'			" 展开缩写
endif

if s:plugin_proj
Plug 'neoclide/coc.nvim',
	\ {'branch': 'release'}		" coc
Plug 'nvim-telescope/telescope.nvim'	" finder
Plug 'editorconfig/editorconfig-vim'	" EditorConfig
endif

if s:plugin_dev
Plug 'iamcco/markdown-preview.nvim',
	\ {'do': 'cd app & yarn install'}	" markdown预览
Plug 'mzlogin/vim-markdown-toc'		" markdown生成TOC
Plug 'lervag/vimtex'			" LaTex
Plug 'skywind3000/asynctasks.vim'	" 构建任务系统
Plug 'fatih/vim-go',
	\ {'do': ':GoUpdateBinaries motion'}
endif

if s:plugin_cmd
Plug 'skywind3000/asyncrun.vim'		" 异步执行
Plug 'voldikss/vim-floaterm'		" 终端窗口
Plug 'lambdalisue/gina.vim'		" 集成Git
Plug 'tpope/vim-dadbod'	|
	\ Plug 'kristijanhusak/vim-dadbod-ui'	" 数据库
endif

if s:plugin_gui
Plug 'lilydjwg/fcitx.vim'		" fcitx自动切换
Plug 'glacambre/firenvim',
	\ {'do': { _ -> firenvim#install(0) }}	" 浏览器嵌入
endif

if s:plugin_misc
Plug 'chrisbra/vim-diff-enhanced'	" 增强diff算法
Plug 'dstein64/vim-startuptime'		" 检查启动时间
endif

call plug#end()
" >>>-----------------------------------

" 检查vim-plug加载插件的情况
function! s:is_loaded(plug) abort
	return has_key(g:plugs, a:plug) && isdirectory(g:plugs[a:plug].dir)
endfunction

if s:is_loaded('everforest') " <<<
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
	autocmd ColorScheme everforest let g:lightline.colorscheme = 'everforest'
	autocmd ColorScheme everforest call s:colorscheme_everforest_custom()
augroup END
endif " >>>-----------------------------------
if s:is_loaded('lightline.vim') " <<<
let g:lightline = {
	\ 'tabline_separator': {'left': '', 'right': ''},
	\ 'tabline_subseparator': {'left': '', 'right': ''},
	\ 'separator': {'left': '', 'right': ''},
	\ 'subseparator': {'left': '', 'right': ''},
	\ 'active': {
		\ 'left': [['filetype'],
			\ ['modified', 'buffer_git_status', 'readonly', 'absolutepath'],
			\ ],
		\ 'right': [['postion'],
			\ ['diagnostic', 'git_status'],
			\ ['fileformat', 'fileencoding']],
	\ },
	\ 'component': {
		\ 'absolutepath': '%<%F',
		\ 'postion': '%2l/%L',
		\ 'percent': '%2p%%',
		\ 'fileformat': '%{&ff!=#"unix"?&ff:""}',
		\ 'fileencoding': '%{&fenc!=#"utf-8"?&fenc:""}',
		\ },
	\ 'component_function': {
		\ 'git_status': 'Lightline_git_status',
		\ 'buffer_git_status': 'Lightline_buffer_git_status',
		\ 'modified': 'Lightline_modified',
		\ 'readonly': 'Lightline_readonly',
		\ 'diagnostic': 'Lightline_diagnostic',
		\ 'filetype': 'Lightline_filetype',
	\ }
\ }

function! Lightline_readonly() abort
	return &readonly ? '' : ''
endfunction
function! Lightline_modified() abort
	return &modified ? '' : ''
endfunction
function! Lightline_git_status() abort
	let s:status = get(g:, 'coc_git_status', '')
	return len(s:status) >= 40 ? s:status[:4].s:status[40:]: s:status
endfunction
function! Lightline_buffer_git_status() abort
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
lua GetIcon = function()
	\ local filename = vim.fn.expand('%:t')
	\ local extension = vim.fn.expand('%:e')
	\ return require'nvim-web-devicons'.get_icon(filename, extension) end
function! Lightline_filetype()
	let icon = luaeval('GetIcon')()
	return strlen(&filetype) ? icon.' '.&filetype : ''
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
endif " >>>-----------------------------------
if s:is_loaded('nvim-web-devicons') " <<<
lua require'nvim-web-devicons'.setup { default = true }
endif " >>>-----------------------------------
if s:is_loaded('nvim-hlslens') " <<<
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
    autocmd User visual_multi_start lua require('vmlens').start()
    autocmd User visual_multi_exit lua require('vmlens').exit()
augroup END

lua << EOF
require('hlslens').setup({
	nearest_only = true,
})
EOF
endif " >>>-----------------------------------
if s:is_loaded('wilder.nvim') " <<<
call wilder#enable_cmdline_enter()
set wildcharm=<Tab>

call wilder#set_option('modes', ['/', '?', ':'])
call wilder#set_option('pipeline', [
	\ wilder#branch(
		\ wilder#cmdline_pipeline({'language': 'python'}),
		\ wilder#python_search_pipeline({
			\ 'pattern': wilder#python_fuzzy_pattern(),
		\ }),
	\ ),
\ ])
call wilder#set_option('renderer', wilder#wildmenu_renderer(
	\ wilder#wildmenu_lightline_theme({
		\ 'highlights': {},
		\ 'highlighter': wilder#basic_highlighter(),
\ })))

cnoremap <expr> <Tab> wilder#in_context() ? wilder#next() : "\<Tab>"
cnoremap <expr> <S-Tab> wilder#in_context() ? wilder#previous() : "\<S-Tab>"
endif " >>>-----------------------------------
if s:is_loaded('indent-blankline.nvim') " <<<
" 缩进线字符
if !s:env_console | let g:indentLine_char = '┊' | endif
" 优先使用treesitter计算缩进
let g:indent_blankline_use_treesitter = v:true
" 高亮上下文缩进线
let g:indent_blankline_show_current_context = v:true
" 排除类型
let g:indent_blankline_filetype_exclude = ['help', 'lspinfo', 'coc-explorer',
	\ 'popup']
let g:indent_blankline_buftype_exclude = ['terminal']
endif " >>>-----------------------------------
if s:is_loaded('vim-better-whitespace') " <<<
let g:better_whitespace_filetypes_blacklist =
	\ ['coc-explorer', 'dbout', 'xxd']
let g:show_spaces_that_precede_tabs = 1
endif " >>>-----------------------------------
if s:is_loaded('hexmode') " <<<
let g:hexmode_patterns = '*.bin,*.exe,*.dat,*.o'
endif " >>>-----------------------------------
if s:is_loaded('aerial.nvim') " <<<
lua require('aerial').setup({})
endif " >>>-----------------------------------
if s:is_loaded('nvim-treesitter') " <<<
lua require('treesitter')
endif " >>>-----------------------------------
if s:is_loaded('vim-sneak') " <<<
" 类似于EasyMotion的标签模式
let g:sneak#label = 1
" 智能大小写
let g:sneak#use_ic_scs = 1
endif " >>>-----------------------------------
if s:is_loaded('vim-visual-multi') " <<<
let g:VM_Extend_hl = 'CursorRange'
endif " >>>-----------------------------------
if s:is_loaded('vim-sandwich') " <<<
let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)
let g:sandwich#recipes += [
	\ {'buns': ["( ", " )"], 'nesting': 1, 'match_syntax': 1, 'input': [')'] },
	\ {'buns': ["[ ", " ]"], 'nesting': 1, 'match_syntax': 1, 'input': [']'] },
	\ {'buns': ["{ ", " }"], 'nesting': 1, 'match_syntax': 1, 'input': ['}'] },
\ ]
endif " >>>----------------------------------
if s:is_loaded('nerdcommenter') " <<<
" 取消所有预设键位映射
let g:NERDCreateDefaultMappings = 0
" 注释符号后面添加空格
let g:NERDSpaceDelims = 1
let g:NERDCustomDelimiters = {'python': {'left': '#', 'right': ''}}
" 注释符号左对齐
let g:NERDDefaultAlign='left'
endif " >>>-----------------------------------
if s:is_loaded('axring.vim') " <<<
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
if s:is_loaded('coc.nvim') " <<<
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

let s:coc_sources = ["coc-lists", "coc-yank", "coc-tasks"]
let s:coc_integration = ["coc-git", "coc-explorer", "coc-translator",
	\ "coc-db"]
let s:coc_snippets = ["coc-snippets",	"coc-emmet"]
let s:coc_lsp = [
	\ "coc-go", "coc-pyright", "coc-rust-analyzer", "coc-clangd",
	\ "coc-sh", "coc-vimlsp", "coc-lua", "coc-diagnostic",
	\ "coc-tsserver", "coc-eslint",
	\ "coc-css", "coc-stylelint",
	\ "coc-html", "coc-json", "coc-yaml", "coc-toml", "coc-markdownlint",
	\ "coc-xml", "coc-svg", "coc-docker", "coc-texlab",
\ ]
let g:coc_global_extensions = [
	\ "coc-pairs",
\ ] + s:coc_sources + s:coc_integration + s:coc_snippets + s:coc_lsp

" coc-explorer
let g:coc_explorer_global_presets = {
	\ 'buffer': {
		\ 'sources': [{'name': 'buffer', 'expand': v:true}],
		\ 'position': 'floating',
		\ 'floating-position': 'center-top',
	\ },
\ }

augroup myconfig_coc
	autocmd!
	" 补全跳转后显示函数签名
	autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

	" coc-explorer界面
	autocmd filetype coc-explorer setlocal fcs=eob:\ 

	" 用coc-explorer替换netrw
	autocmd StdinReadPre * let s:std_in=1
	autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in")
		\ | exe 'cd '.argv()[0]
		\ | exe 'CocCommand explorer --position floating' argv()[0]
		\ | wincmd p | bd | endif

	" readonly文件不显示diagnostic
	autocmd BufRead * if &readonly == 1 | let b:coc_diagnostic_disable = 1 | endif

	" 使用coc-html自动闭合tag, 禁用coc-pairs
	autocmd FileType html let b:coc_pairs_disabled = ['<']
augroup END

call coc#config("explorer.file.root.template",
	\ " [git & 1][hidden & 1][root]")
call coc#config("explorer.file.child.template",
	\ "[git | 2][selection | clip | 1] ".
	\ "[indent][icon | 1] [filename omitCenter 1] ".
	\ "[modified][readonly][linkIcon growRight 1 omitCenter 5][size]")
call coc#config("explorer.buffer.root.template",
	\ " [title] [hidden & 1]")
call coc#config("explorer.buffer.child.template",
	\ "[git | 2][selection | 1] [name] [modified][readonly growRight 1][bufname]")
endif " >>>-----------------------------------
if s:is_loaded('asynctasks.vim') " <<<
let g:asynctasks_extra_config = [s:confdir.'/tasks.ini']
endif " >>>-----------------------------------
if s:is_loaded('vim-go') " <<<
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
if s:is_loaded('asyncrun.vim') " <<<
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
if s:is_loaded('vim-dadbod-ui') " <<<
let g:db_ui_save_location = s:datadir.'/db_ui'
let g:db_ui_use_nerd_fonts = 1
augroup myconfig_dbui
	autocmd!
	autocmd Filetype dbui setlocal shiftwidth=2 tabstop=2 expandtab
augroup END
endif " >>>-----------------------------------
if s:is_loaded('firenvim') " <<<
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
if s:is_loaded('vim-diff-enhanced') " <<<
if &diff
	let &diffexpr = 'EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'
endif
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
nmap     <silent>  [c          <Plug>(coc-git-prevchunk)
nmap     <silent>  ]c          <Plug>(coc-git-nextchunk)
nnoremap <silent>  ]w          :NextTrailingWhitespace<CR>
nnoremap <silent>  [w          :PrevTrailingWhitespace<CR>


" g组：语法跳转
" splitjoin.vim执行拆分合并
nmap     <silent>  gd          <Plug>(coc-definition)
nmap     <silent>  gy          <Plug>(coc-type-definition)
nmap     <silent>  gi          <Plug>(coc-implementation)
nmap     <silent>  gr          <Plug>(coc-references)


" 其他
nmap     <silent>  <C-k>       <Plug>(coc-git-prevchunk)
nmap     <silent>  <C-j>       <Plug>(coc-git-nextchunk)
vnoremap           //          y/\V<C-R>=escape(@",'/\')<CR><CR>


" 文本对象
xmap     if        <Plug>(coc-funcobj-i)
omap     if        <Plug>(coc-funcobj-i)
xmap     af        <Plug>(coc-funcobj-a)
omap     af        <Plug>(coc-funcobj-a)


" Leader
let g:mapleader=' ' | noremap <Space> <Nop>
vnoremap <silent>  <leader>y   "+y
nnoremap <silent>  <leader>p   "+p
nnoremap <silent>  <leader>P   "+P
map                <leader>c   <Plug>NERDCommenterToggle
nnoremap <silent>  <leader>e   :exec 'CocCommand explorer' getcwd()<CR>
nnoremap <silent>  <leader>o   :AerialToggle left<CR>
nnoremap <silent>  <leader>b   :CocCommand explorer --preset buffer<CR>
nmap               <leader>k   <Plug>(coc-translator-p)
vmap               <leader>k   <Plug>(coc-translator-pv)


" h组g组：Git Hunk
nnoremap           <leader>hs  :CocCommand git.chunkStage<CR>
nnoremap           <leader>hu  :CocCommand git.chunkUndo<CR>
nnoremap           <leader>ho  :CocCommand git.copyUrl<CR>
nmap               <leader>hi  <Plug>(coc-git-chunkinfo)
nmap               <leader>hb  <Plug>(coc-git-commit)
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

" <<< 命令
command  GetHighlight
	\ echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')

command! -nargs=1 -complete=custom,s:lightline_colorschemes
	\ LightlineColorscheme  call s:set_lightline_colorscheme(<q-args>)

cabbrev  <silent> Search  AsyncRun -silent firefox -search <cword>
cabbrev  <expr>   ww      (getcmdtype() == ':' && getcmdline() =~ '^ww$')?
	\ 'w !sudo tee % >/dev/null' : 'ww'

lua require('keymap').setup()


" 编辑snippets
command EditSnippet  exec 'tabnew '.fnamemodify(stdpath('config'),
	\ ':p:h:h').'/coc/ultisnips/'.&filetype.'.snippets'

" 重新加载配置
command! -nargs=1 -complete=custom,s:get_vim_files
	\ LoadConfig  exec 'source '.s:confdir.'/<args>'

" 编辑配置
command! -nargs=1 -complete=custom,s:get_vim_files
	\ EditConfig  exec 'tabnew '.s:confdir.'/<args>'

" 手动加载插件
command! -nargs=1 -complete=custom,s:get_plugins
	\ LoadPlug  call plug#load('<args>')

function! s:get_vim_files(...) abort
	let l:idx = len(s:confdir) + 1
	return join(map(
		\ globpath(s:confdir, '**/*.vim', 0, 1),
		\ 'v:val[l:idx:]'),
		\ "\n")
endfunction

function! s:get_plugins(...) abort
	return join(keys(g:plugs), "\n")
endfunction
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

if get(g:, 'ansi', v:false)
	autocmd VimEnter * call ansi#term_cat()
endif

" vim: foldmethod=marker:foldmarker=<<<,>>>:foldlevel=0
