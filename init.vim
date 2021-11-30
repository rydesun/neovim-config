" <<< 环境
let s:confdir = stdpath('config')	" ${XDG_CONFIG_HOME}/nvim
let s:datadir = stdpath('data')		" ${XDG_DATA_HOME}/nvim
let s:plugdir = s:datadir.'/plugged'	" ${XDG_DATA_HOME}/nvim/plugged

let s:enable_plugin = !getenv('NVIM_NO_PLUG')
let s:plugin_ui = !getenv('NVIM_NO_UI')
let s:plugin_view = !getenv('NVIM_NO_VIEW')
let s:plugin_ft = !getenv('NVIM_NO_FT')
let s:plugin_op = !getenv('NVIM_NO_OP')
let s:plugin_proj = !getenv('NVIM_NO_PROJ')
let s:plugin_dev = !getenv('NVIM_NO_DEV')
let s:plugin_cmd = !getenv('NVIM_NO_CMD')
let s:plugin_x = !getenv('NVIM_NO_X')
let s:plugin_misc = !getenv('NVIM_NO_MISC')

let s:nvim_as_pager = getenv('NVIM_AS_PAGER') || getenv('NVIM_AS_COLORFUL_PAGER')
let s:handle_ansi = getenv('HANDLE_ANSI') || getenv('NVIM_AS_COLORFUL_PAGER')

if s:nvim_as_pager
	let s:plugin_ft = 0
	let s:plugin_proj = 0
	let s:plugin_dev = 0
	let s:plugin_cmd = 0
	let s:plugin_x = 0
	let s:plugin_misc = 0
endif
" >>>-----------------------------------


" <<< 选项
set fileencodings=ucs-bom,utf-8,gbk,big5,gb18030,latin1	" 常见文件编码(中文用户)
set ignorecase smartcase	" 大小写模糊搜索
set wildignorecase	" 命令行补全文件名时无视大小写
set title		" 设置虚拟终端的标题
set hidden		" 可以切换未保存修改的buffer
set splitbelow		" 水平分割的新窗口在下面打开
set splitright		" 垂直分割的新窗口在右边打开
set mouse=a		" 所有模式下支持鼠标
set relativenumber	" 开启相对行号
set numberwidth=1	" 行号最低宽度
" set signcolumn=number	" 在行号上显示侧边栏
" 等待coc-git修复#187
autocmd User CocNvimInit sleep 50m | set signcolumn=number
set scrolloff=5		" 滚动时光标到上下边缘的预留行数
set shortmess+=cI	" c关闭补全提示, I关闭空白页信息
set diffopt+=vertical	" diff模式默认以垂直方式分割
set wildmode=list:longest,full	" 命令行补全时以列表显示
set listchars=tab:\|·,space:␣,trail:☲,extends:►,precedes:◄	" list模式时的可见字符
set wildignore+=*~,*.swp,*.bak,*.o,*.py[co],__pycache__		" 文件过滤规则
set inccommand=nosplit	" 替换过程可视化
set formatoptions+=B	" 合并中文行不加空格
set confirm		" 退出报错改为对话
if $TERM != 'linux'
	set termguicolors
endif
" 修改折叠文本
if &foldtext == 'foldtext()'
	set foldtext=Foldtext()
endif
let g:vim_indent_cont = shiftwidth()	" vimscript缩进宽度

if s:nvim_as_pager
	set noswapfile
	set laststatus=0
	set norelativenumber
	set signcolumn=no
endif
" >>>-----------------------------------


" <<< 键位
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


" s组：搜索列表(vim-clap)
" vim-sandwich处理成对符号
nnoremap           s           <NOP>
nnoremap           S           :Clap<CR>
nnoremap <silent>  sc          :Clap bcommits<CR>
nnoremap <silent>  sf          :Clap files<CR>
nnoremap <silent>  sg          :Clap grep2<CR>
nnoremap <silent>  sl          :Clap blines<CR>
nnoremap <silent>  s;          :Clap command_history<CR>


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
nnoremap <silent>  <leader>b   :CocCommand explorer --preset buffer<CR>
nmap               <leader>k   <Plug>(coc-translator-p)
vmap               <leader>k   <Plug>(coc-translator-pv)
nnoremap           <leader>K   :call utils#doc_dash(&ft, expand('<cword>'))<CR>


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
if s:nvim_as_pager
	nnoremap q :exit<CR>
endif
" >>>-----------------------------------


" <<< 命令
command  GetHighlight
	\ echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')

command  CountZhCharacters  lua require('counter'):cmd_count_zh()

command! -nargs=0  Typography  call typography#format()
command! -nargs=0  TypographyHugo  call typography#format_hugo()

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


" <<< 插件
if s:enable_plugin
call plug#begin(s:plugdir)

Plug 'Olical/aniseed',
	\ {'tag': '*'}			" 编译fennel
" 自动编译
let g:aniseed#env = v:true

if s:plugin_ui
Plug 'sainnhe/everforest'		" 配色主题
Plug 'itchyny/lightline.vim'		" 状态栏
Plug 'wfxr/minimap.vim'			" minimap
Plug 'ryanoasis/vim-devicons'		" 图标字体
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
Plug 'psliwka/vim-smoothie'		" 平滑滚动
Plug 'fidian/hexmode'			" 查看16进制
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
Plug 'liuchengxu/vim-clap',
	\ {'do': ':Clap install-binary!'} |
	\ Plug 'vn-ki/coc-clap'		" Finder
Plug 'editorconfig/editorconfig-vim'	" EditorConfig
endif

if s:plugin_dev
Plug 'iamcco/markdown-preview.nvim',
	\ {'do': 'cd app & yarn install'}	" markdown预览
Plug 'mzlogin/vim-markdown-toc'		" markdown生成TOC
Plug 'lervag/vimtex'			" LaTex
Plug 'skywind3000/asynctasks.vim'	" 构建任务系统
Plug 'fatih/vim-go',
	\ {'do': ':GoUpdateBinaries guru motion'}
Plug 'puremourning/vimspector',
	\ {'on': []}			" 调试工具
endif

if s:plugin_cmd
Plug 'skywind3000/asyncrun.vim'		" 异步执行
Plug 'voldikss/vim-floaterm'		" 终端窗口
Plug 'lambdalisue/gina.vim'		" 集成Git
Plug 'tpope/vim-dadbod'	|
	\ Plug 'kristijanhusak/vim-dadbod-ui'	" 数据库
endif

if s:plugin_x
Plug 'lilydjwg/fcitx.vim'		" fcitx自动切换
Plug 'glacambre/firenvim',
	\ {'do': { _ -> firenvim#install(0) }}	" 浏览器嵌入
endif

if s:plugin_misc
Plug 'chrisbra/vim-diff-enhanced'	" 增强diff算法
Plug 'dstein64/vim-startuptime'		" 检查启动时间
endif

call plug#end()
endif
" >>>-----------------------------------

if s:enable_plugin
if s:plugin_ui
" <<< everforest (var, au)
let g:everforest_better_performance = 1
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
" >>>-----------------------------------
" <<< lightline (var, func)
let g:lightline = {
	\ 'tabline_separator': {'left': '', 'right': ''},
	\ 'tabline_subseparator': {'left': '', 'right': ''},
	\ 'separator': {'left': '', 'right': ''},
	\ 'subseparator': {'left': '', 'right': ''},
	\ 'active': {
		\ 'left': [['mode', 'paste'],
			\ ['gitStatus'],
			\ ['modified', 'readonly', 'absolutepath']],
		\ 'right': [['postion'],
			\ ['diagnostic', 'filetype'],
			\ ['fileformat', 'fileencoding']],
	\ },
	\ 'inactive': {
		\ 'left': [['modified', 'readonly', 'absolutepath']],
		\ 'right': [['percent'],
			\ ['fileformat', 'fileencoding']],
	\ },
	\ 'component': {
		\ 'absolutepath': '%<%F',
		\ 'postion': '%2l-%2v',
		\ 'percent': '%2p%%',
		\ 'fileformat': '%{&ff!=#"unix"?&ff:""}',
		\ 'fileencoding': '%{&fenc!=#"utf-8"?&fenc:""}',
		\ },
	\ 'component_function': {
		\ 'mode': 'Lightline_mode',
		\ 'gitStatus': 'Lightline_gitStatus',
		\ 'modified': 'Lightline_modified',
		\ 'readonly': 'Lightline_readonly',
		\ 'diagnostic': 'Lightline_diagnostic',
		\ 'filetype': 'Lightline_filetype',
	\ }
\ }

function! Lightline_mode() abort
	return lightline#mode()[0]
endfunction
function! Lightline_readonly() abort
	return &readonly ? '' : ''
endfunction
function! Lightline_modified() abort
	return &modified ? '' : ''
endfunction
function! Lightline_gitStatus() abort
	let s:status = get(g:, 'coc_git_status', '')
	let s:head = len(s:status) >= 40 ? s:status[:4].s:status[40:]: s:status
	return s:head.(
		\ !empty(get(b:, 'coc_git_status', '')) ? ' ': '')
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
" <<< minimap (var)
" 自启(非pager时)
if !s:nvim_as_pager
	let g:minimap_auto_start = 1
endif
let g:minimap_auto_start_win_enter = 1
" 样式
let g:minimap_width = 4
let g:minimap_highlight_range = 1
let g:minimap_git_colors = 1
" >>>-----------------------------------
" <<< nvim-hlslens (map, au, exec)
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
" >>>-----------------------------------
" <<< wilder.nvim (exe, opt, map)
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
" >>>-----------------------------------
endif
if s:plugin_view
" <<< indent-blankline (var)
" 缩进线字符
let g:indentLine_char = '┊'
" 优先使用treesitter计算缩进
let g:indent_blankline_use_treesitter = v:true
" 高亮上下文缩进线
let g:indent_blankline_show_current_context = v:true
" 排除类型
let g:indent_blankline_filetype_exclude = ['help', 'lspinfo', 'coc-explorer',
	\ 'popup', 'clap_input', 'clap_action']
let g:indent_blankline_buftype_exclude = ['terminal']
" >>>-----------------------------------
" <<< vim-better-whitespace (var)
let g:better_whitespace_filetypes_blacklist =
	\ ['coc-explorer', 'dbout', 'xxd']
let g:show_spaces_that_precede_tabs = 1
" >>>-----------------------------------
" <<< hexmode (var)
let g:hexmode_patterns = '*.bin,*.exe,*.dat,*.o'
" >>>-----------------------------------
endif
if s:plugin_ft
" <<< nvim-treesitter (exec, opt)
lua require('treesitter')
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevel=99
" >>>-----------------------------------
endif
if s:plugin_op
" <<< vim-sneak (var)
" 类似于EasyMotion的标签模式
let g:sneak#label = 1
" 智能大小写
let g:sneak#use_ic_scs = 1
" >>> ---------------------------------
" <<< vim-visual-multi (var)
let g:VM_Extend_hl = 'CursorRange'
" >>> ---------------------------------
" <<< vim-sandwich (var)
let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)
let g:sandwich#recipes += [
	\ {'buns': ["( ", " )"], 'nesting': 1, 'match_syntax': 1, 'input': [')'] },
	\ {'buns': ["[ ", " ]"], 'nesting': 1, 'match_syntax': 1, 'input': [']'] },
	\ {'buns': ["{ ", " }"], 'nesting': 1, 'match_syntax': 1, 'input': ['}'] },
\ ]
" >>> ---------------------------------
" <<< nerdcommenter (var)
" 取消所有预设键位映射
let g:NERDCreateDefaultMappings = 0
" 注释符号后面添加空格
let g:NERDSpaceDelims = 1
let g:NERDCustomDelimiters = {'python': {'left': '#', 'right': ''}}
" 注释符号左对齐
let g:NERDDefaultAlign='left'
" >>>-----------------------------------
" <<< axring (var)
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
endif
if s:plugin_proj
" <<< coc (opt, var, au, exec)
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
	autocmd User CocExplorerOpenPost setlocal statusline=%#NonText#

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
" >>>-----------------------------------
" <<< vim-clap (var)
" 只使用cwd
let g:clap_disable_run_rooter = v:true
" 样式
let g:clap_prompt_format = ' %provider_id% %forerunner_status% '
let g:clap_layout = {'relative': 'editor'}
let g:clap_preview_direction = 'UD'
" 无normal模式(Esc立即退出)
let g:clap_insert_mode_only = v:true
" >>>-----------------------------------
endif
if s:plugin_dev
" <<< asynctasks (var)
let g:asynctasks_extra_config = [s:confdir.'/tasks.ini']
" >>>-----------------------------------
" <<< vim-go (var)
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
" <<< vimspector (var)
let g:vimspector_enable_mappings = 'HUMAN'
" >>>-----------------------------------
endif
if s:plugin_cmd
" <<< asyncrun (var)
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
" >>>-----------------------------------
" <<< vim-dadbod-ui (var, au)
let g:db_ui_save_location = s:datadir.'/db_ui'
let g:db_ui_use_nerd_fonts = 1
augroup myconfig_dbui
	autocmd!
	autocmd Filetype dbui setlocal shiftwidth=2 tabstop=2 expandtab
augroup END
" >>>-----------------------------------
endif
if s:plugin_x
" <<< firenvim (var, func, au)
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
" >>>-----------------------------------
endif
if s:plugin_misc
" <<< vim-diff-enhanced (opt)
if &diff
	let &diffexpr = 'EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'
endif
" >>>-----------------------------------
end
end


" vim-plug窗口位置
let g:plug_window = 'new'

augroup myconfig
	autocmd!
	" 自动设置工作目录
	let g:rootpath_patterns = [
		\ '.git', '.hg', '.svn', 'Makefile', 'package.json',
	\ ]
	autocmd VimEnter,BufReadPost,BufEnter *
		\ if &buftype == '' |
		\ exec 'lcd '.luaeval("require('rooter').get(_A)", g:rootpath_patterns) |
		\ endif
	autocmd BufWritePost * exec "lua require('rooter').clear()" |
		\ if &buftype == '' |
		\ exec 'lcd '.luaeval("require('rooter').get(_A)", g:rootpath_patterns) |
		\ endif

	" 终端不需要侧边栏
	autocmd TermOpen * setlocal norelativenumber
augroup END

if s:handle_ansi
augroup handle_ansi
	autocmd!
	autocmd VimEnter * call utils#term_paging()
augroup END
endif

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

silent! colorscheme everforest


" vim: foldmethod=marker:foldmarker=<<<,>>>:foldlevel=0
