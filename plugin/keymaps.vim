" <<< 按键 (非默认行为)
noremap  H  ^
noremap  L  $
noremap  Q  @q
noremap  ;  :
map      :  <Plug>Sneak_;
map      f  <Plug>Sneak_s
map      F  <Plug>Sneak_S
xnoremap <  <gv
xnoremap >  >gv
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
if g:paging | nnoremap q :exit<CR> | endif

" s组：搜索列表(telescope.nvim)
" vim-sandwich处理成对符号
nnoremap           s           <NOP>
nnoremap           S           :Telescope<CR>
nnoremap <silent>  ss          :Telescope live_grep theme=dropdown<CR>
nnoremap <silent>  sb          :Telescope buffers theme=dropdown previewer=false<CR>
nnoremap <silent>  sf          :Telescope find_files theme=dropdown previewer=false<CR>
nnoremap <silent>  sg          :Telescope git_status theme=dropdown previewer=false<CR>

" g组：语法跳转
" splitjoin.vim执行拆分合并
nmap     <silent>  gd          <Plug>(coc-definition)
nmap     <silent>  gy          <Plug>(coc-type-definition)
nmap     <silent>  gi          <Plug>(coc-implementation)
nmap     <silent>  gr          <Plug>(coc-references)
" >>>-----------------------------------

" <<< 按键 (新增行为)
" <Esc>组：关闭
nnoremap <silent>  <Esc><Esc>  :nohlsearch<CR>
nnoremap <silent>  <Esc>q      :cclose<CR>
nnoremap <silent>  <Esc>l      :lclose<CR>
nnoremap <silent>  <Esc>f      :bd<CR>
nnoremap <silent>  <Esc>t      :tabclose<CR>
nnoremap <silent>  <Esc>w      <C-w>c

" []组：前后跳转
" 插件提供更多映射
nmap     <silent>  [g          <Plug>(coc-diagnostic-prev)
nmap     <silent>  ]g          <Plug>(coc-diagnostic-next)
nmap     <silent>  [G          <Plug>(coc-diagnostic-prev-error)
nmap     <silent>  ]G          <Plug>(coc-diagnostic-next-error)
nnoremap <silent>  ]w          :NextTrailingWhitespace<CR>
nnoremap <silent>  [w          :PrevTrailingWhitespace<CR>
nnoremap <silent>  [of         :set laststatus=2<CR>
nnoremap <silent>  ]of         :set laststatus=3<CR>
nnoremap <silent>  [om         :set colorcolumn=80<CR>
nnoremap <silent>  ]om         :set colorcolumn=<CR>

" Ctrl Alt
imap               <C-j>       <Plug>(coc-snippets-expand-jump)
nnoremap <silent>  <C-k>       :Gitsigns prev_hunk<CR>
nnoremap <silent>  <C-j>       :Gitsigns next_hunk<CR>
nnoremap <silent>  <A-j>       :m .+1<CR>
nnoremap <silent>  <A-k>       :m .-2<CR>
vnoremap <silent>  <A-j>       :m '>+1<CR>==gv
vnoremap <silent>  <A-k>       :m '<-2<CR>==gv
" >>>-----------------------------------

" <<< 按键 (Leader单键)
let g:mapleader=' ' | noremap <Space> <Nop>

" 数字组：运行
nnoremap <silent>  <Leader>1   :AsyncTask repl<CR>
nnoremap <silent>  <Leader>3   :AsyncTask file-run<CR>
nnoremap <silent>  <Leader>5   :AsyncTask project-run<CR>
nnoremap <silent>  <Leader>7   :AsyncTask project-build<CR>
nnoremap <silent>  <Leader>9   :AsyncTask file-build<CR>

vnoremap <silent>  <leader>y   "+y
nnoremap <silent>  <leader>p   "+p
nnoremap <silent>  <leader>P   "+P
nnoremap <silent>  <leader>e   :NvimTreeFindFileToggle<CR>
nnoremap <silent>  <leader>o   :AerialToggle left<CR>
nnoremap <silent>  <leader>k   :TranslateW --engines=haici<CR>
vnoremap <silent>  <leader>k   :Translate --engines=google<CR>
nnoremap <silent>  <leader>K   :lua require'utils/devdocs':open_cursor()<CR>
" >>>-----------------------------------

" <<< 按键 (Leader多键)
" h组g组：Git Hunk
nnoremap <silent>  <leader>gd  :lua require'utils/term_git'.run('diff', true)<CR>
nnoremap <silent>  <leader>ga  :lua require'utils/term_git'.run('diff', false)<CR>
nnoremap <silent>  <leader>gs  :lua require'utils/term_git'.run('show', false)<CR>
nnoremap <silent>  <leader>gt  :lua require'utils/term_git'.run('diff --staged', false)<CR>
nnoremap <silent>  <leader>gc  :Gina commit<CR>
nnoremap <silent>  <leader>hs  :Gitsigns stage_hunk<CR>
nnoremap <silent>  <leader>hu  :Gitsigns reset_hunk<CR>
nnoremap <silent>  <leader>hU  :Gitsigns undo_stage_hunk<CR>
nnoremap <silent>  <leader>hi  :Gitsigns preview_hunk<CR>

" r组：语法相关的修改
nmap               <leader>rn  <Plug>(coc-rename)
nmap               <leader>rt  <Plug>(coc-refactor)
nmap               <leader>rf  <Plug>(coc-fix-current)
nnoremap <silent>  <leader>rm  :call CocAction('format')<CR>

" t组：操作终端
nnoremap <silent>  <Leader>tt  :FloatermToggle<CR>
nnoremap <silent>  <Leader>ts  :FloatermSend<CR>
vnoremap <silent>  <Leader>ts  :FloatermSend<CR>
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

" <<< 按键 (命令行)
cnoremap           <C-a>       <Home>
cnoremap           <C-b>       <Left>
cnoremap           <C-f>       <Right>
cnoremap           <M-b>       <C-Left>
cnoremap           <M-f>       <C-Right>
cnoremap           <C-p>       <Up>
cnoremap           <C-n>       <Down>
cnoremap <expr>    %%          expand('%:p:h').'/'
" >>>-----------------------------------

" <<< 按键 (终端)
tnoremap <M-space>  <c-\><c-n>
" >>>-----------------------------------

" vim: foldmethod=marker:foldmarker=<<<,>>>:foldlevel=0
