" <<< 按键 (覆盖默认行为)
noremap  H  ^
noremap  L  $
noremap  Q  @q
noremap  ;  :
map      f  <Plug>(leap-forward)
map      F  <Plug>(leap-backward)
" 修改缩进后保持选中
xnoremap <  <gv
xnoremap >  >gv
" 用LSP查看文档
nnoremap <silent>  K  <Cmd>Lspsaga hover_doc<CR>
" 分页时按q直接退出
if g:paging | nnoremap q <Cmd>exit<CR> | endif

nmap  <C-a>  <Plug>(dial-increment)
nmap  <C-x>  <Plug>(dial-decrement)
vmap  <C-a>  <Plug>(dial-increment)
vmap  <C-x>  <Plug>(dial-decrement)
vmap g<C-a> g<Plug>(dial-increment)
vmap g<C-x> g<Plug>(dial-decrement)

" z组：折叠
nnoremap <silent>  zj  <Cmd>lua require'ufo'.goNextClosedFold()<CR>
nnoremap <silent>  zk  <Cmd>lua require'ufo'.goPreviousClosedFold()<CR>
nnoremap <silent>  zv  <Cmd>lua require'ufo'.peekFoldedLinesUnderCursor()<CR>
" 保持foldlevel的值
nnoremap <silent>  zR  <Cmd>lua require 'ufo'.openAllFolds()<CR>
nnoremap <silent>  zM  <Cmd>lua require 'ufo'.closeAllFolds()<CR>

" g组：按词跳转
" 另外有插件debugprint.nvim占用g?
nnoremap <silent>  gd  <Cmd>Telescope lsp_definitions<CR>
nnoremap <silent>  gy  <Cmd>Telescope lsp_type_definitions<CR>
nnoremap <silent>  gi  <Cmd>Telescope lsp_implementations<CR>
nnoremap <silent>  gr  <Cmd>Telescope lsp_references<CR>
nnoremap <silent>  gs  <Cmd>Telescope grep_string<CR>
" 表格对齐
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" s组：搜索/位置/文件跳转
" 另外有插件vim-sandwich占用sa、sd、sr
nnoremap           s   <NOP>
nnoremap <silent>  S   <Cmd>Telescope<CR>
nnoremap <silent>  sl  <Cmd>Telescope resume<CR>
nnoremap <silent>  ss  <Cmd>Telescope live_grep<CR>
nnoremap <silent>  s/  <Cmd>Telescope current_buffer_fuzzy_find
			\ skip_empty_lines=true<CR>
nnoremap <silent>  s;  <Cmd>Telescope command_history<CR>
" quickfix/loclist
nnoremap <silent>  sq  <Cmd>Telescope diagnostics<CR>
nnoremap <silent>  sj  <Cmd>Telescope jumplist trim_text=true<CR>
nnoremap <silent>  sm  <Cmd>Telescope marks<CR>
" 文件列表(历史打开)
nnoremap <silent>  so  <Cmd>Telescope oldfiles<CR>
nnoremap <silent>  sO  <Cmd>Telescope frecency theme=dropdown previewer=false<CR>
" 文件列表(当前工作区)
nnoremap <silent>  sf  <Cmd>Telescope find_files<CR>
nnoremap <silent>  sF  <Cmd>Telescope find_files hidden=true no_ignore=true<CR>
nnoremap <silent>  sg  <Cmd>Telescope git_status<CR>
" Vim
nnoremap <silent>  svk <Cmd>Telescope keymaps show_plug=false<CR>
nnoremap <silent>  svo <Cmd>Telescope vim_options<CR>
nnoremap <silent>  svh <Cmd>Telescope highlights<CR>

" OMNI组：特殊种类的补全
imap     <silent>  <C-x><C-r>  <Cmd>Telescope registers<CR>
imap     <silent>  <C-x><C-p>  <Cmd>Telescope neoclip theme=cursor<CR>
imap     <silent>  <C-x><C-s>  <Cmd>Telescope symbols<CR>
imap     <silent>  <C-x><C-e>  <Cmd>lua require'telescope.builtin'.symbols {
				\ sources = {'emoji', 'kaomoji', 'gitmoji'} }<CR>
imap     <silent>  <C-x><C-n>  <Cmd>lua require'telescope.builtin'.symbols {
				\ sources = {'nerd'} }<CR>
" >>>-----------------------------------

" <<< 按键 (新增行为)
" <Esc>组：关闭
nnoremap <silent>  <Esc><Esc>  <Cmd>nohlsearch<CR>
nnoremap <silent>  <Esc>q      <Cmd>cclose<CR>
nnoremap <silent>  <Esc>l      <Cmd>lclose<CR>
nnoremap <silent>  <Esc>f      <Cmd>Bdelete<CR>
nnoremap <silent>  <Esc>t      <Cmd>tabclose<CR>
nnoremap <silent>  <Esc>w      <C-w>c

" []组：前后跳转
" 另外有插件提供更多映射
nnoremap <silent>  [g          <Cmd>Lspsaga diagnostic_jump_prev<CR>
nnoremap <silent>  ]g          <Cmd>Lspsaga diagnostic_jump_next<CR>
nnoremap <silent>  [G          <Cmd>lua require'lspsaga.diagnostic'.goto_prev{
				\ severity=vim.diagnostic.severity.ERROR}<CR>
nnoremap <silent>  ]G          <Cmd>lua require'lspsaga.diagnostic'.goto_next{
				\ severity=vim.diagnostic.severity.ERROR}<CR>
nnoremap <silent>  ]w          <Cmd>NextTrailingWhitespace<CR>
nnoremap <silent>  [w          <Cmd>PrevTrailingWhitespace<CR>
nnoremap <silent>  [of         <Cmd>set laststatus=2<CR>
nnoremap <silent>  ]of         <Cmd>set laststatus=3<CR>
nnoremap <silent>  [om         <Cmd>set colorcolumn=80<CR>
nnoremap <silent>  ]om         <Cmd>set colorcolumn=<CR>

" Ctrl Alt
imap     <silent>  <C-j>       <Cmd>lua require'luasnip'.jump(1)<CR>
imap     <silent>  <C-k>       <Cmd>lua require'luasnip'.jump(-1)<CR>
nnoremap <silent>  <C-k>       <Cmd>Gitsigns prev_hunk<CR>
nnoremap <silent>  <C-j>       <Cmd>Gitsigns next_hunk<CR>
" 交换节点
nnoremap <silent>  <A-s>       <Cmd>ISwapNode<CR>
nnoremap <silent>  <A-h>       <Cmd>ISwapWithLeft<CR>
nnoremap <silent>  <A-l>       <Cmd>ISwapWithRight<CR>
" 交换行
nnoremap <silent>  <A-j>       <Cmd>m .+1<CR>
nnoremap <silent>  <A-k>       <Cmd>m .-2<CR>
xnoremap <silent>  <A-j>       :m '>+1<CR>==gv
xnoremap <silent>  <A-k>       :m '<-2<CR>==gv
" >>>-----------------------------------

" <<< 按键 (Leader单键)
let g:mapleader=' ' | noremap <Space> <Nop>

" 数字组：编译运行
nnoremap <silent>  <leader>1   <Cmd>AsyncTask run<CR>
nnoremap <silent>  <leader>2   <Cmd>AsyncTask build<CR>
nnoremap <silent>  <leader>3   <Cmd>AsyncTask build-release<CR>
nnoremap <silent>  <leader>4   <Cmd>AsyncTask coverage<CR>
nnoremap <silent>  <leader>7   <Cmd>AsyncTask file-run<CR>
nnoremap <silent>  <leader>8   <Cmd>AsyncTask file-build<CR>
nnoremap <silent>  <leader>0   <Cmd>AsyncTask repl<CR>

xnoremap <silent>  <leader>y   "+y
nnoremap <silent>  <leader>p   "+p
nnoremap <silent>  <leader>P   "+P
nnoremap <silent>  <leader>e   <Cmd>NvimTreeFindFileToggle<CR>
nnoremap <silent>  <leader>u   <Cmd>UndotreeToggle<CR>
nnoremap <silent>  <leader>o   <Cmd>AerialToggle<CR>
nnoremap <silent>  <leader>k   <Cmd>TranslateW --engines=haici<CR>
xnoremap <silent>  <leader>k   "ty:call translator#start('echo',0,0,0,0,@t)<CR>
nnoremap <silent>  <leader>K   <Cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent>  <leader>D   <Cmd>lua require'utils/devdocs':open_cursor()<CR>

" LSP
nnoremap <silent>  <leader>a  <Cmd>Lspsaga code_action<CR>
nnoremap <silent>  <leader>r  <Cmd>Lspsaga rename<CR>
nnoremap <silent>  <leader>f  <Cmd>lua vim.lsp.buf.format{async=true}<CR>
xnoremap <silent>  <leader>f  <Cmd>lua vim.lsp.buf.format{async=true}<CR>
" >>>-----------------------------------

" <<< 按键 (Leader多键)
" h组g组：Git Hunk
nnoremap <silent>  <leader>hs  <Cmd>Gitsigns stage_hunk<CR>
nnoremap <silent>  <leader>hu  <Cmd>Gitsigns reset_hunk<CR>
nnoremap <silent>  <leader>hU  <Cmd>Gitsigns undo_stage_hunk<CR>
nnoremap <silent>  <leader>hi  <Cmd>Gitsigns preview_hunk<CR>
nnoremap <silent>  <leader>go  <Cmd>DiffviewOpen<CR>
nnoremap <silent>  <leader>gh  <Cmd>DiffviewFileHistory<CR>
xnoremap <silent>  <leader>gh  :DiffviewFileHistory<CR>
nnoremap <silent>  <leader>gd  <Cmd>lua require'utils/term-git'.
				\ run('diff', true)<CR>
nnoremap <silent>  <leader>ga  <Cmd>lua require'utils/term-git'.
				\ run('diff', false)<CR>
nnoremap <silent>  <leader>gs  <Cmd>lua require'utils/term-git'.
				\ run('show', false)<CR>
nnoremap <silent>  <leader>gt  <Cmd>lua require'utils/term-git'.
				\ run('diff --staged', false)<CR>

" t组：操作终端、测试
nnoremap <silent>  <leader>tt  <Cmd>ToggleTerm direction=float<CR>
nnoremap <silent>  <leader>tb  <Cmd>ToggleTerm direction=horizontal<CR>
nnoremap <silent>  <leader>ts  <Cmd>ToggleTermSendCurrentLine<CR>
xnoremap <silent>  <leader>ts  :ToggleTermSendVisualSelection<CR>
nnoremap <silent>  <leader>tn  :TestNearest<CR>
nnoremap <silent>  <leader>tf  :TestFile<CR>
nnoremap <silent>  <leader>tl  :TestLast<CR>
nnoremap <silent>  <leader>tv  :TestVisit<CR>

" w组：特定语言
" rust
function! RustKeymap() abort
	nnoremap <buffer><silent> <leader>wa <Cmd>RustHoverActions<CR>
	nnoremap <buffer><silent> <leader>wr <Cmd>RustRunnables<CR>
	nnoremap <buffer><silent> <leader>we <Cmd>RustExpandMacro<CR>
	nnoremap <buffer><silent> <leader>wu <Cmd>RustParentModule<CR>
	nnoremap <buffer><silent> <leader>wc <Cmd>RustOpenCargo<CR>
endfunction
autocmd filetype rust call RustKeymap()
" markdown
function! MarkdownKeymap() abort
	nmap <buffer><silent> <leader>wp <Plug>MarkdownPreviewToggle
endfunction
autocmd filetype markdown call MarkdownKeymap()
" >>>-----------------------------------

" <<< 按键 (文本对象)
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
" >>>-----------------------------------

" <<< 按键 (Emacs风格)
inoremap           <C-a>       <Home>
inoremap           <C-e>       <End>
inoremap           <C-b>       <Left>
inoremap           <C-f>       <Right>
inoremap           <A-b>       <C-Left>
inoremap           <A-f>       <C-Right>

cnoremap           <C-a>       <Home>
cnoremap           <C-b>       <Left>
cnoremap           <C-f>       <Right>
cnoremap           <A-b>       <C-Left>
cnoremap           <A-f>       <C-Right>
cnoremap           <C-p>       <Up>
cnoremap           <C-n>       <Down>
" >>>-----------------------------------

" <<< 按键 (命令行、终端)
cnoremap <expr>    %%          expand('%:p:h').'/'
tnoremap           <M-space>   <c-\><c-n>
" >>>-----------------------------------

" vim: foldmethod=marker:foldmarker=<<<,>>>:foldlevel=0
