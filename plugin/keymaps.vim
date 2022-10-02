" <<< 按键 (非默认行为)
noremap  H  ^
noremap  L  $
noremap  Q  @q
noremap  ;  :
map      f  <Plug>(leap-forward)
map      F  <Plug>(leap-backward)
xnoremap <  <gv
xnoremap >  >gv
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
nnoremap <silent>  K  <Cmd>Lspsaga hover_doc<CR>
if g:paging | nnoremap q <Cmd>exit<CR> | endif

" s组：搜索列表(telescope.nvim)
" vim-sandwich处理成对符号
nnoremap           s           <NOP>
nnoremap           S           <Cmd>Telescope<CR>
nnoremap <silent>  ss          <Cmd>Telescope live_grep<CR>
nnoremap <silent>  sb          <Cmd>Telescope buffers<CR>
nnoremap <silent>  sf          <Cmd>Telescope find_files<CR>
nnoremap <silent>  sg          <Cmd>Telescope git_status<CR>

" g组：语法跳转
" splitjoin.vim执行拆分合并
nnoremap <silent>  gd          <Cmd>Telescope lsp_definitions<CR>
nnoremap <silent>  gy          <Cmd>Telescope lsp_type_definitions<CR>
nnoremap <silent>  gi          <Cmd>Telescope lsp_implementations<CR>
nnoremap <silent>  gr          <Cmd>Telescope lsp_references<CR>
" >>>-----------------------------------

" <<< 按键 (新增行为)
" <Esc>组：关闭
nnoremap <silent>  <Esc><Esc>  <Cmd>nohlsearch<CR>
nnoremap <silent>  <Esc>q      <Cmd>cclose<CR>
nnoremap <silent>  <Esc>l      <Cmd>lclose<CR>
nnoremap <silent>  <Esc>f      <Cmd>bd<CR>
nnoremap <silent>  <Esc>t      <Cmd>tabclose<CR>
nnoremap <silent>  <Esc>w      <C-w>c

" []组：前后跳转
" 插件提供更多映射
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
nnoremap <silent>  <A-j>       <Cmd>m .+1<CR>
nnoremap <silent>  <A-k>       <Cmd>m .-2<CR>
vnoremap <silent>  <A-j>       :m '>+1<CR>==gv
vnoremap <silent>  <A-k>       :m '<-2<CR>==gv
" >>>-----------------------------------

" <<< 按键 (Leader单键)
let g:mapleader=' ' | noremap <Space> <Nop>

" 数字组：运行
nnoremap <silent>  <Leader>1   <Cmd>AsyncTask repl<CR>
nnoremap <silent>  <Leader>3   <Cmd>AsyncTask file-run<CR>
nnoremap <silent>  <Leader>5   <Cmd>AsyncTask project-run<CR>
nnoremap <silent>  <Leader>7   <Cmd>AsyncTask project-build<CR>
nnoremap <silent>  <Leader>9   <Cmd>AsyncTask file-build<CR>
nnoremap <silent>  <Leader>-   <Cmd>AsyncTask test<CR>

vnoremap <silent>  <leader>y   "+y
nnoremap <silent>  <leader>p   "+p
nnoremap <silent>  <leader>P   "+P
nnoremap <silent>  <leader>e   <Cmd>NvimTreeFindFileToggle<CR>
nnoremap <silent>  <leader>o   <Cmd>AerialToggle left<CR>
nnoremap <silent>  <leader>k   <Cmd>TranslateW --engines=haici<CR>
vnoremap <silent>  <leader>k   "ty:call translator#start('echo',0,0,0,0,@t)<CR>
nnoremap <silent>  <leader>K   <Cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent>  <leader>D   <Cmd>lua require'utils/devdocs':open_cursor()<CR>
nnoremap <silent>  <leader>c   <Cmd>PickColorInsert<CR>

" LSP
nnoremap <silent>  <leader>a  <Cmd>Lspsaga code_action<CR>
nnoremap <silent>  <leader>r  <Cmd>Lspsaga rename<CR>
nnoremap <silent>  <leader>f  <Cmd>lua vim.lsp.buf.format{async=true}<CR>
xnoremap <silent>  <leader>f  <Cmd>lua vim.lsp.buf.format{async=true}<CR>
" >>>-----------------------------------

" <<< 按键 (Leader多键)
" h组g组：Git Hunk
nnoremap <silent>  <leader>gd  <Cmd>lua require'utils/term-git'.run('diff', true)<CR>
nnoremap <silent>  <leader>ga  <Cmd>lua require'utils/term-git'.run('diff', false)<CR>
nnoremap <silent>  <leader>gs  <Cmd>lua require'utils/term-git'.run('show', false)<CR>
nnoremap <silent>  <leader>gt  <Cmd>lua require'utils/term-git'.run('diff --staged', false)<CR>
nnoremap <silent>  <leader>gc  <Cmd>Gina commit<CR>
nnoremap <silent>  <leader>hs  <Cmd>Gitsigns stage_hunk<CR>
nnoremap <silent>  <leader>hu  <Cmd>Gitsigns reset_hunk<CR>
nnoremap <silent>  <leader>hU  <Cmd>Gitsigns undo_stage_hunk<CR>
nnoremap <silent>  <leader>hi  <Cmd>Gitsigns preview_hunk<CR>

" t组：操作终端
nnoremap <silent>  <Leader>tt  <Cmd>FloatermToggle<CR>
nnoremap <silent>  <Leader>ts  <Cmd>FloatermSend<CR>
vnoremap <silent>  <Leader>ts  :FloatermSend<CR>

" w组：特定语言
" rust
autocmd filetype rust nnoremap <buffer><silent> <leader>wt
	\ <Cmd>lua require'rust-tools'.open_cargo_toml.open_cargo_toml()<CR>
autocmd filetype rust nnoremap <buffer><silent> <leader>wp
	\ <Cmd>lua require'rust-tools'.parent_module.parent_module()<CR>
autocmd filetype rust nnoremap <buffer><silent> <leader>wm
	\ <Cmd>lua require'rust-tools'.expand_macro.expand_macro()<CR>
" markdown
autocmd filetype markdown nmap <buffer><silent> <leader>wp
	\ <Plug>MarkdownPreviewToggle
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
inoremap           <M-b>       <C-Left>
inoremap           <M-f>       <C-Right>

cnoremap           <C-a>       <Home>
cnoremap           <C-b>       <Left>
cnoremap           <C-f>       <Right>
cnoremap           <M-b>       <C-Left>
cnoremap           <M-f>       <C-Right>
cnoremap           <C-p>       <Up>
cnoremap           <C-n>       <Down>
" >>>-----------------------------------

" <<< 按键 (命令行、终端)
cnoremap <expr>    %%          expand('%:p:h').'/'
tnoremap           <M-space>   <c-\><c-n>
" >>>-----------------------------------

" vim: foldmethod=marker:foldmarker=<<<,>>>:foldlevel=0
