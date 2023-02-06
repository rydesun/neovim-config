" {{{ 按键 (覆盖默认行为)
noremap  H  ^
noremap  L  $
noremap  Q  @q
noremap  ;  :
noremap  :  ;
" 修改缩进后保持选中
xnoremap <  <gv
xnoremap >  >gv
" 用LSP查看文档
nnoremap <silent>  K  <Cmd>lua vim.lsp.buf.hover()<CR>

lua << EOF
vim.keymap.set('n', '<C-l>', function()
  pcall(function()
    require 'notify'.dismiss { silent = true, pending = true }
  end)
  vim.cmd.nohlsearch()
  vim.cmd.diffupdate()
  vim.cmd.normal {
    vim.api.nvim_replace_termcodes('<C-l>', true, true, true), bang = true
  }
end)
EOF

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
xmap ga <Plug>(LiveEasyAlign)
nmap ga <Plug>(LiveEasyAlign)

" q组：关闭
" 分页时按q直接退出
if get(g:, 'paging', v:false)
	nnoremap q <Cmd>exit<CR>
else
	" 不影响用其他的键位录制宏
	nnoremap <silent>  qw  <C-w>c
	nnoremap <silent>  qf  <Cmd>Bdelete<CR>
	nnoremap <silent>  qt  <Cmd>tabclose<CR>
	nnoremap <silent>  qc  <Cmd>cclose<CR>
	nnoremap <silent>  ql  <Cmd>lclose<CR>
endif

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
nnoremap <silent>  sj  <Cmd>Telescope jumplist<CR>
nnoremap <silent>  sm  <Cmd>Telescope marks<CR>
" 文件列表(历史打开)
nnoremap <silent>  so  <Cmd>Telescope oldfiles<CR>
nnoremap <silent>  sO  <Cmd>Telescope oldfiles only_cwd=true<CR>
" 文件列表(当前工作区)
nnoremap <silent>  sf  <Cmd>Telescope find_files<CR>
nnoremap <silent>  sF  <Cmd>Telescope find_files hidden=true no_ignore=true<CR>
nnoremap <silent>  sg  <Cmd>Telescope git_status<CR>
" Vim
nnoremap <silent>  svv <Cmd>Telescope help_tags<CR>
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
" }}}

" {{{ 按键 (新增行为)
" leap.nvim跳转
lua << EOF
vim.keymap.set('n', '-', function()
  require 'leap'.leap {
    target_windows = vim.tbl_filter(
      function(win) return vim.api.nvim_win_get_config(win).focusable end,
      vim.api.nvim_tabpage_list_wins(0)
    )
  }
end)
EOF

" []组：前后跳转
" 另外有插件提供更多映射
nnoremap <silent>  [g          <Cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent>  ]g          <Cmd>lua vim.diagnostic.goto_next()<CR>
nnoremap <silent>  [G          <Cmd>lua vim.diagnostic.goto_prev{
				\ severity=vim.diagnostic.severity.ERROR}<CR>
nnoremap <silent>  ]G          <Cmd>lua vim.diagnostic.goto_next{
				\ severity=vim.diagnostic.severity.ERROR}<CR>
nnoremap <silent>  ]w          <Cmd>NextTrailingWhitespace<CR>
nnoremap <silent>  [w          <Cmd>PrevTrailingWhitespace<CR>
nnoremap <silent>  [of         <Cmd>set laststatus=2<CR>
nnoremap <silent>  ]of         <Cmd>set laststatus=3<CR>
nnoremap <silent>  [om         <Cmd>set colorcolumn=79<CR>
nnoremap <silent>  ]om         <Cmd>set colorcolumn=<CR>

" CtrlAlt组
imap     <silent>  <C-j>       <Cmd>lua require'luasnip'.jump(1)<CR>
imap     <silent>  <C-k>       <Cmd>lua require'luasnip'.jump(-1)<CR>
nnoremap <silent>  <C-k>       <Cmd>Gitsigns prev_hunk<CR>
nnoremap <silent>  <C-j>       <Cmd>Gitsigns next_hunk<CR>
" 交换节点
nnoremap <silent>  <A-s>       <Cmd>ISwapNodeWith<CR>
" 移动光标、调整窗口
nnoremap           <A-j>       <Cmd>wincmd j<CR>
nnoremap           <A-k>       <Cmd>wincmd k<CR>
nnoremap           <A-h>       <Cmd>wincmd h<CR>
nnoremap           <A-l>       <Cmd>wincmd l<CR>
nnoremap           <A-S-j>     <C-w>+
nnoremap           <A-S-k>     <C-w>-
nnoremap           <A-S-h>     <C-w><
nnoremap           <A-S-l>     <C-w>>
tnoremap           <A-j>       <Cmd>wincmd j<CR>
tnoremap           <A-k>       <Cmd>wincmd k<CR>
tnoremap           <A-h>       <Cmd>wincmd h<CR>
tnoremap           <A-l>       <Cmd>wincmd l<CR>
tnoremap           <A-q>       <C-\><C-n>

" <Esc>组：关闭
nnoremap <silent>  <Esc><Esc>  <Cmd>nohlsearch<CR>
nnoremap <silent>  <Esc>q      <Cmd>cclose<CR>
nnoremap <silent>  <Esc>l      <Cmd>lclose<CR>
nnoremap <silent>  <Esc>f      <Cmd>Bdelete<CR>
nnoremap <silent>  <Esc>t      <Cmd>tabclose<CR>
nnoremap <silent>  <Esc>w      <C-w>c

" 命令行
cnoremap <expr>    %%          expand('%:p:h').'/'
" }}}

" {{{ 按键 (Emacs编辑)
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
" }}}

" {{{ 按键 (Leader单键)
" 另外有插件treesj.nvim占用 s j m
let g:mapleader=' ' | noremap <Space> <Nop>
let g:maplocalleader=' w'

" 数字组：编译运行
nnoremap <silent>  <leader>1   <Cmd>AsyncTask run<CR>
nnoremap <silent>  <leader>2   <Cmd>AsyncTask build<CR>
nnoremap <silent>  <leader>3   <Cmd>AsyncTask build-release<CR>
nnoremap <silent>  <leader>4   <Cmd>AsyncTask coverage<CR>
nnoremap <silent>  <leader>7   <Cmd>AsyncTask file-run<CR>
nnoremap <silent>  <leader>8   <Cmd>AsyncTask file-build<CR>
nnoremap <silent>  <leader>0t  <Cmd>AsyncTask repl<CR>
nmap     <silent>  <leader>00  <Plug>SnipRun
vmap     <silent>  <leader>00  <Plug>SnipRun

xnoremap <silent>  <leader>y   "+y
nnoremap <silent>  <leader>p   "+p
nnoremap <silent>  <leader>P   "+P
nnoremap <silent>  <leader>e   <Cmd>exec 'NvimTreeFindFileToggle '.getcwd()<CR>
nnoremap <silent>  <leader>u   <Cmd>UndotreeToggle<CR>
nnoremap <silent>  <leader>o   <Cmd>AerialToggle<CR>
nnoremap <silent>  <leader>k   <Cmd>TranslateW --engines=haici<CR>
xnoremap <silent>  <leader>k   "ty:call translator#start('echo',0,0,0,0,@t)<CR>
nnoremap <silent>  <leader>K   <Cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent>  <leader>D   <Cmd>lua require'utils/devdocs':open_cursor()<CR>

" LSP
nnoremap <silent>  <leader>a  <Cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent>  <leader>r  <Cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent>  <leader>f  <Cmd>lua vim.lsp.buf.format{async=true}<CR>
xnoremap <silent>  <leader>f  <Cmd>lua vim.lsp.buf.format{async=true}<CR>
" }}}

" {{{ 按键 (Leader多键)
" h组g组：Git Hunk
nnoremap <silent>  <leader>hs  <Cmd>Gitsigns stage_hunk<CR>
xnoremap <silent>  <leader>hs  :Gitsigns stage_hunk<CR>
nnoremap <silent>  <leader>hS  <Cmd>Gitsigns stage_buffer<CR>
nnoremap <silent>  <leader>hu  <Cmd>Gitsigns reset_hunk<CR>
xnoremap <silent>  <leader>hu  :Gitsigns reset_hunk<CR>
nnoremap <silent>  <leader>hU  <Cmd>Gitsigns undo_stage_hunk<CR>
nnoremap <silent>  <leader>hR  <Cmd>Gitsigns reset_buffer<CR>
nnoremap <silent>  <leader>hi  <Cmd>Gitsigns preview_hunk<CR>
nnoremap <silent>  <leader>hb  <Cmd>lua require'gitsigns'.blame_line{full=true}<CR>
nnoremap <silent>  <leader>hd  <Cmd>Gitsigns toggle_deleted<CR>

nnoremap <silent>  <leader>go  <Cmd>DiffviewOpen<CR>
nnoremap <silent>  <leader>gh  <Cmd>DiffviewFileHistory %<CR>
xnoremap <silent>  <leader>gh  :DiffviewFileHistory<CR>
nnoremap <silent>  <leader>gH  <Cmd>DiffviewFileHistory<CR>
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

" n组：笔记
nnoremap <silent>  <leader>ns  <Cmd>ObsidianSearch<CR>
nnoremap <silent>  <leader>nf  <Cmd>ObsidianQuickSwitch<CR>
nnoremap <silent>  <leader>ne  <Cmd>NvimTreeFindFileToggle
			\ ~/Data/Documents/Obsidian Vault<CR>

" LocalLeader组：特定文件类型
" Rust
function! RustKeymap() abort
	nnoremap <buffer><silent> <LocalLeader>a <Cmd>RustHoverActions<CR>
	nnoremap <buffer><silent> <LocalLeader>r <Cmd>RustRunnables<CR>
	nnoremap <buffer><silent> <LocalLeader>e <Cmd>RustExpandMacro<CR>
	nnoremap <buffer><silent> <LocalLeader>u <Cmd>RustParentModule<CR>
	nnoremap <buffer><silent> <LocalLeader>c <Cmd>RustOpenCargo<CR>
endfunction
autocmd filetype rust call RustKeymap()

" Markdown
function! MarkdownKeymap() abort
	nmap <buffer><silent> <LocalLeader>p <Plug>MarkdownPreviewToggle
endfunction
autocmd filetype markdown call MarkdownKeymap()
" }}}

" {{{ 按键 (文本对象)
" 另外有插件nvim-treesitter的配置

xmap     ih        :Gitsigns select_hunk<CR>
omap     ih        :Gitsigns select_hunk<CR>

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
" }}}

" vim: foldmethod=marker:foldlevel=0
