" {{{ 按键 (覆盖默认行为)
noremap  H  ^
noremap  L  $
nnoremap Q  @q
noremap  ;  :
noremap  :  ;
" 修改缩进后保持选中
xnoremap <  <gv
xnoremap >  >gv
" 用LSP查看文档
nnoremap <silent>  K  <Cmd>lua vim.lsp.buf.hover()<CR>

nnoremap <silent>  M  m
" leap.nvim跳转
lua << EOF
vim.keymap.set('n', 'm', function()
  require 'leap'.leap {
    target_windows = vim.tbl_filter(
      function(win) return vim.api.nvim_win_get_config(win).focusable end,
      vim.api.nvim_tabpage_list_wins(0)
    )
  }
end)
EOF

" z组：折叠
nnoremap <silent>  zj  <Cmd>lua require'ufo'.goNextClosedFold()<CR>
nnoremap <silent>  zk  <Cmd>lua require'ufo'.goPreviousClosedFold()<CR>
nnoremap <silent>  zv  <Cmd>lua require'ufo'.peekFoldedLinesUnderCursor()<CR>
" 保持foldlevel的值
nnoremap <silent>  zR  <Cmd>lua require 'ufo'.openAllFolds()<CR>
nnoremap <silent>  zr  <Cmd>lua require 'ufo'.openFoldsExceptKinds()<CR>
nnoremap <silent>  zM  <Cmd>lua require 'ufo'.closeAllFolds()<CR>

" g组：按词跳转
" 另外有插件debugprint.nvim占用g?
nnoremap <silent>  gd  <Cmd>Telescope lsp_definitions<CR>
nnoremap <silent>  gD  <Cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent>  gy  <Cmd>Telescope lsp_type_definitions<CR>
nnoremap <silent>  gi  <Cmd>Telescope lsp_implementations<CR>
nnoremap <silent>  gr  <Cmd>Telescope lsp_references<CR>
nnoremap <silent>  gs  <Cmd>Telescope grep_string<CR>
" 表格对齐
map ga <Plug>(LiveEasyAlign)

" 分页时按q直接退出
if get(g:, 'paging', v:false) | nnoremap q <Cmd>exit<CR> | endif

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
nnoremap <silent>  svk <Cmd>lua require'telescope.builtin'.live_grep { search_dirs={
                                \ vim.fn.stdpath'config'..'/plugin/keymaps.vim'}}<CR>
nnoremap <silent>  svK <Cmd>Telescope keymaps show_plug=false<CR>
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
" }}}

" {{{ 按键 (新增行为)
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
" 移动光标、调整窗口、关闭
nnoremap           <A-w>       <C-w>c
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
nnoremap           <A-q>       <Cmd>cclose<CR>
nnoremap           <A-f>       <Cmd>Bdelete<CR>
nnoremap           <A-t>       <Cmd>tabclose<CR>

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
let g:mapleader=' ' | nnoremap <Space> <Nop>
let g:maplocalleader=' w'

" 数字组：编译运行
nnoremap <silent>  <leader>1   <Cmd>AsyncTask run<CR>
nnoremap <silent>  <leader>2   <Cmd>AsyncTask build<CR>
nnoremap <silent>  <leader>3   <Cmd>AsyncTask build-release<CR>
nnoremap <silent>  <leader>4   <Cmd>AsyncTask coverage<CR>
nnoremap <silent>  <leader>7   <Cmd>AsyncTask file-run<CR>
nnoremap <silent>  <leader>8   <Cmd>AsyncTask file-build<CR>
nnoremap <silent>  <leader>0t  <Cmd>AsyncTask repl<CR>
noremap  <silent>  <leader>00  :SnipRun<CR>

xnoremap <silent>  <leader>y   "+y
nnoremap <silent>  <leader>p   "+p
nnoremap <silent>  <leader>P   "+P
nnoremap <silent>  <leader>e   <Cmd>exec 'NvimTreeFindFileToggle '.getcwd()<CR>
nnoremap <silent>  <leader>u   <Cmd>UndotreeToggle<CR>
nnoremap <silent>  <leader>o   <Cmd>AerialToggle float<CR>
nnoremap <silent>  <leader>O   <Cmd>AerialNavToggle<CR>
nnoremap <silent>  <leader>k   <Cmd>TranslateW --engines=haici<CR>
xnoremap <silent>  <leader>k   "ty:call translator#start('echo',0,0,0,0,@t)<CR>
nnoremap <silent>  <leader>K   <Cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent>  <leader>D   <Cmd>lua require'utils/devdocs':open_cursor()<CR>

" LSP
nnoremap <silent>  <leader>a  <Cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent>  <leader>r  <Cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent>  <leader>f  <Cmd>lua vim.lsp.buf.format{async=true}<CR>
xnoremap <silent>  <leader>f  <Cmd>lua vim.lsp.buf.format{async=true}<CR>
nnoremap <silent>  <leader>S  <Cmd>lua require'ssr'.open()<CR>
xnoremap <silent>  <leader>S  <Cmd>lua require'ssr'.open()<CR>
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
nnoremap <silent>  <leader>hB  <Cmd>Gitsigns toggle_current_line_blame<CR>
nnoremap <silent>  <leader>hd  <Cmd>Gitsigns toggle_deleted<CR>
nnoremap <silent>  <leader>hw  <Cmd>Gitsigns toggle_word_diff<CR>

nnoremap <silent>  <leader>go  <Cmd>DiffviewOpen<CR>
nnoremap <silent>  <leader>gh  <Cmd>DiffviewFileHistory %<CR>
xnoremap <silent>  <leader>gh  :DiffviewFileHistory<CR>
nnoremap <silent>  <leader>gH  <Cmd>DiffviewFileHistory<CR>
nnoremap <silent>  <leader>gd  <Cmd>lua require'utils/term-git'.
				\ run('diff', true)<CR>
nnoremap <silent>  <leader>ga  <Cmd>lua require'utils/term-git'.
				\ run('diff', false)<CR>
nnoremap <silent>  <leader>gt  <Cmd>lua require'utils/term-git'.
				\ run('diff --staged', false)<CR>
" 搜索git所有的提交内容
lua << EOF
function git_pickaxe(all)
  return function()
    prompt = all and 'Git Pickaxe' or 'Git Pickaxe %'
    vim.ui.input({ prompt = prompt }, function(query)
      if not query or query == '' then return end
      arg = string.format("-G'%s'", query)
      if not all then arg = '% ' .. arg end
      vim.cmd.DiffviewFileHistory (arg)
    end)
  end
end
vim.keymap.set('n', '<leader>gs', git_pickaxe(false))
vim.keymap.set('n', '<leader>gS', git_pickaxe(true))
EOF

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
nnoremap <silent>  <leader>nn  <Cmd>ObsidianDraft<CR>
nnoremap <silent>  <leader>ns  <Cmd>ObsidianSearch<CR>
nnoremap <silent>  <leader>nf  <Cmd>ObsidianQuickSwitch<CR>
nnoremap <silent>  <leader>ne  <Cmd>NvimTreeObsidian<CR>
nnoremap <silent>  <leader>nS  <Cmd>ObsidianSync<CR>
nnoremap <silent>  <leader>nC  <Cmd>ObsidianCommit<CR>

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
" mini.ai占用a和i

" 缩进
onoremap <silent>  ii  <Cmd>lua require'various-textobjs'.indentation(true, true)<CR>
xnoremap <silent>  ii  <Cmd>lua require'various-textobjs'.indentation(true, true)<CR>

" 数字
onoremap <silent>  i0  <Cmd>lua require'various-textobjs'.number(true)<CR>
xnoremap <silent>  i0  <Cmd>lua require'various-textobjs'.number(true)<CR>

" 单词按分隔符划分
onoremap <silent>  iS  <Cmd>lua require'various-textobjs'.subword(true)<CR>
xnoremap <silent>  iS  <Cmd>lua require'various-textobjs'.subword(true)<CR>
onoremap <silent>  aS  <Cmd>lua require'various-textobjs'.subword(false)<CR>
xnoremap <silent>  aS  <Cmd>lua require'various-textobjs'.subword(false)<CR>

" diagnostic
onoremap <silent>  !   <Cmd>lua require'various-textobjs'.diagnostic()<CR>
xnoremap <silent>  !   <Cmd>lua require'various-textobjs'.diagnostic()<CR>

" Git hunk
onoremap <silent>  ih  <Cmd>Gitsigns select_hunk<CR>
xnoremap <silent>  ih  :Gitsigns select_hunk<CR>

" AST节点
onoremap <silent>  m   <Cmd>lua require'leap-ast'.leap()<CR>
xnoremap <silent>  m   <Cmd>lua require'leap-ast'.leap()<CR>
" }}}

" vim: foldmethod=marker:foldlevel=0
