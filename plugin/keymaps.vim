" {{{ 按键 (覆盖默认行为)
noremap  H  ^
noremap  L  $
noremap  ;  :
noremap  :  ;
" 修改缩进后保持选中
xnoremap <  <gv
xnoremap >  >gv

" leap.nvim跳转
map                m   <Plug>(leap-forward-to)
map                M   <Plug>(leap-backward-to)

" g组：按当前词跳转
" 插件vim-matchup/matchit提供g%，Comment.nvim提供gc gb
" mini.align提供ga gA，mini.ai提供g[ g]
nnoremap <silent>  gd  <Cmd>lua Snacks.picker.lsp_definitions()<CR>
nnoremap <silent>  gD  <Cmd>lua Snacks.picker.lsp_declarations()<CR>
nnoremap <silent>  gy  <Cmd>lua Snacks.picker.lsp_type_definitions()<CR>
nnoremap <silent>  gi  <Cmd>lua Snacks.picker.lsp_implementations()<CR>
nnoremap <silent>  gr  <Cmd>lua Snacks.picker.lsp_references()<CR>
noremap  <silent>  gs  <Cmd>lua Snacks.picker.grep_word()<CR>

" 分页时按q直接退出
if get(g:, 'pager', v:false) | nnoremap q <Cmd>exit<CR> | endif

" s组：搜索/位置/文件跳转
" 另外有插件vim-sandwich占用sa、sd、sr
nnoremap           s   <NOP>
nnoremap <silent>  S   <Cmd>lua Snacks.picker()<CR>
nnoremap <silent>  sl  <Cmd>lua Snacks.picker.resume()<CR>

nnoremap <silent>  ss  <Cmd>lua Snacks.picker.grep()<CR>
nnoremap <silent>  sS  <Cmd>lua Snacks.picker.grep{exclude={},ignored=true,hidden=true}<CR>
nnoremap <silent>  sn  <Cmd>lua Snacks.picker.lsp_symbols()<CR>
nnoremap <silent>  sN  <Cmd>lua Snacks.picker.lsp_workspace_symbols()<CR>
nnoremap <silent>  sf  <Cmd>lua Snacks.picker.files()<CR>
nnoremap <silent>  sF  <Cmd>lua Snacks.picker.files{exclude={},ignored=true,hidden=true}<CR>
nnoremap <silent>  sg  <Cmd>lua Snacks.picker.git_status()<CR>
nnoremap <silent>  so  <Cmd>lua Snacks.picker.smart()<CR>
nnoremap <silent>  st  <Cmd>lua Snacks.picker.tagstack()<CR>
nnoremap <silent>  sp  <Cmd>lua Snacks.picker.projects()<CR>
nnoremap <silent>  s/  <Cmd>lua Snacks.picker.lines()<CR>
nnoremap <silent>  s;  <Cmd>lua Snacks.picker.command_history()<CR>
nnoremap <silent>  sq  <Cmd>lua Snacks.picker.diagnostics()<CR>
" Vim
nnoremap <silent>  svm <Cmd>lua Snacks.picker.noice()<CR>
nnoremap <silent>  svv <Cmd>lua Snacks.picker.help()<CR>
nnoremap <silent>  svh <Cmd>lua Snacks.picker.highlights()<CR>
nnoremap <silent>  svK <Cmd>lua Snacks.picker.keymaps()<CR>
nnoremap <silent>  svk <Cmd>lua Snacks.picker.grep { dirs={
			\ vim.fn.stdpath'config'..'/plugin/keymaps.vim'}}<CR>

" OMNI组：特殊种类的补全
imap     <silent>  <C-x><C-s>  <Cmd>lua Snacks.picker.icons()<CR>

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
" []组：前后跳转，切换选项
" 插件vim-matchup/matchit提供 [% ]%, snacks.scope提供[i ]i
" vim-unimpaired提供更多映射
nnoremap <silent>  [g          <Cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent>  ]g          <Cmd>lua vim.diagnostic.goto_next()<CR>
nnoremap <silent>  [G          <Cmd>lua vim.diagnostic.goto_prev{
				\ severity=vim.diagnostic.severity.ERROR}<CR>
nnoremap <silent>  ]G          <Cmd>lua vim.diagnostic.goto_next{
				\ severity=vim.diagnostic.severity.ERROR}<CR>
nnoremap <silent>  ]w          <Cmd>NextTrailingWhitespace<CR>
nnoremap <silent>  [w          <Cmd>PrevTrailingWhitespace<CR>
nnoremap <silent>  [om         <Cmd>set colorcolumn=80<CR>
nnoremap <silent>  ]om         <Cmd>set colorcolumn=<CR>
nnoremap <silent>  [oh         <Cmd>lua vim.lsp.inlay_hint.enable(true)<CR>
nnoremap <silent>  ]oh         <Cmd>lua vim.lsp.inlay_hint.enable(false)<CR>
nnoremap <silent>  [ow         <Cmd>lua vim.lsp.buf.document_highlight()<CR>
nnoremap <silent>  ]ow         <Cmd>lua vim.lsp.buf.clear_references()<CR>
nnoremap <silent>  [of         <Cmd>FormatOnSaveEnable<CR>
nnoremap <silent>  ]of         <Cmd>FormatOnSaveDisable<CR>

" Ctrl组：前后跳转
inoremap <silent>  <C-j>       <Cmd>lua require'luasnip'.jump(1)<CR>
inoremap <silent>  <C-k>       <Cmd>lua require'luasnip'.jump(-1)<CR>
snoremap <silent>  <C-j>       <cmd>lua require'luasnip'.jump(1)<Cr>
snoremap <silent>  <C-k>       <cmd>lua require'luasnip'.jump(-1)<Cr>
nnoremap <silent>  <C-j>       <Cmd>Gitsigns nav_hunk next<CR>
nnoremap <silent>  <C-k>       <Cmd>Gitsigns nav_hunk prev<CR>
nnoremap <silent>  <C-S-j>     <Cmd>Gitsigns nav_hunk next target=staged<CR>
nnoremap <silent>  <C-S-k>     <Cmd>Gitsigns nav_hunk prev target=staged<CR>

" Ctrl+Alt组：语法跳转
noremap  <silent>  <C-A-j>     <Cmd>Treewalker Down<CR>
noremap  <silent>  <C-A-k>     <Cmd>Treewalker Up<CR>
noremap  <silent>  <C-A-u>     <Cmd>Treewalker Left<CR>
noremap  <silent>  <C-A-d>     <Cmd>Treewalker Right<CR>

" Alt组：移动语法节点，移动光标，调整窗口大小，关闭
nnoremap <silent>  <A-s>       <Cmd>ISwapNode<CR>
nnoremap <silent>  <A-m>       <Cmd>IMoveNode<CR>
nnoremap <silent>  <A-o>       <Cmd>lua require'symbols'.api.action'show-symbol-under-cursor'<CR>
map      <silent>  <A-p>       <Plug>(matchup-[%)
map      <silent>  <A-n>       <Plug>(matchup-]%)
imap     <silent>  <A-p>       <C-o><Plug>(matchup-[%)
imap     <silent>  <A-n>       <C-o><Plug>(matchup-]%)
inoremap           <A-i>       <C-k>
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
nnoremap           <A-f>       <Cmd>lua Snacks.bufdelete()<CR>
nnoremap           <A-t>       <Cmd>tabclose<CR>
nnoremap           <A-q>       <Cmd>call <SID>toggleQuickFix()<CR>
function! s:toggleQuickFix()
    if getqflist({'winid' : 0}).winid | cclose | else | copen | endif
endfunction
" }}}

" {{{ 按键 (Emacs风格)
noremap!           <C-a>       <Home>
noremap!           <C-e>       <End>
noremap!           <A-b>       <C-Left>
noremap!           <A-f>       <C-Right>

" 允许滚动函数传参时出现的文档
noremap! <silent>  <C-b>       <Cmd>lua NoiceScrollDoc(-4, '<Left>', 'i')<CR>
noremap! <silent>  <C-f>       <Cmd>lua NoiceScrollDoc(4, '<Right>', 'i')<CR>
snoremap <silent>  <C-b>       <Cmd>lua NoiceScrollDoc(-4, '<Left>', 'i')<CR>
snoremap <silent>  <C-f>       <Cmd>lua NoiceScrollDoc(4, '<Right>', 'i')<CR>
" 注意开启插件Neoscroll会覆盖此设置，所以Neosroll的配置内需要再次设置一次
nnoremap <silent>  <C-b>       <Cmd>lua NoiceScrollDoc(-4, '<C-b>', 'n')<CR>
nnoremap <silent>  <C-f>       <Cmd>lua NoiceScrollDoc(4, '<C-f>', 'n')<CR>

" 根据前缀补全
cnoremap           <C-p>       <Up>
cnoremap           <C-n>       <Down>
" }}}

" {{{ 按键 (Leader单键)
let g:mapleader=' ' | nnoremap <Space> <Nop>
let g:maplocalleader='\'

nnoremap <silent>  <leader>s   <Cmd>lua require'treesj'.split()<CR>
nnoremap <silent>  <leader>j   <Cmd>lua require'treesj'.join()<CR>

" 数字组：编译运行
nnoremap <silent>  <leader>1   <Cmd>AsyncTask cwd-run<CR>
nnoremap <silent>  <leader>2   <Cmd>AsyncTask cwd-build<CR>
nnoremap <silent>  <leader>3   <Cmd>AsyncTask cwd-build-release<CR>
nnoremap <silent>  <leader>4   <Cmd>AsyncTask cwd-test<CR>
nnoremap <silent>  <leader>5   <Cmd>AsyncTask cwd-command<CR>

nnoremap <silent>  <leader>6   <Cmd>AsyncTask file-command<CR>
nnoremap <silent>  <leader>7   <Cmd>AsyncTask file-run<CR>
nnoremap <silent>  <leader>8   <Cmd>AsyncTask file-build<CR>
nnoremap <silent>  <leader>9   <Cmd>AsyncTask file-test<CR>

nnoremap <silent>  <leader>0   <Cmd>AsyncTask repl<CR>
nnoremap <silent>  <leader>-   <Cmd>AsyncTaskTogglePos<CR>

noremap  <silent>  <leader><Enter>    <Cmd>SnipRun<CR>
noremap  <silent>  <leader><S-Enter>  <Cmd>call <SID>SnipRunFile()<CR>
function s:SnipRunFile() abort
	let l:caret=winsaveview()
	execute '%SnipRun'
	call winrestview(l:caret)
endfunction

xnoremap <silent>  <leader>y   "+y
nnoremap <silent>  <leader>p   "+p
nnoremap <silent>  <leader>P   "+P
nnoremap <silent>  <leader>e   <Cmd>NvimTreeFindFileToggle!<CR>
nnoremap <silent>  <leader>u   <Cmd>lua Snacks.picker.undo {layout='sidebar'}<CR>
nnoremap <silent>  <leader>o   <Cmd>SymbolsToggle<CR>
nnoremap <silent>  <leader>K   <Cmd>normal! K<CR>

" LSP
nnoremap <silent>  <leader>a  <Cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent>  <leader>r  <Cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent>  <leader>f  <Cmd>LspFormat<CR>
xnoremap <silent>  <leader>f  <Cmd>lua vim.lsp.buf.format{async=true}<CR>
nnoremap <silent>  <leader>F  <Cmd>LspFixAll<CR>
" }}}

" {{{ 按键 (Leader多键)
" c组：复制
nnoremap <silent>  <leader>cN  <Cmd>echo     expand('%:t')<CR>
nnoremap <silent>  <leader>cn  <Cmd>let @+ = expand('%:t')<CR>
nnoremap <silent>  <leader>cF  <Cmd>echo     expand('%:p:~')<CR>
nnoremap <silent>  <leader>cf  <Cmd>let @+ = expand('%:p:~')<CR>
nnoremap <silent>  <leader>cD  <Cmd>echo     expand('%:p:~:h')..'/'<CR>
nnoremap <silent>  <leader>cd  <Cmd>let @+ = expand('%:p:~:h')..'/'<CR>

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
nnoremap <silent>  <leader>hq  <Cmd>Gitsigns setqflist all<CR>

nnoremap <silent>  <leader>G   <Cmd>Neogit<CR>
nnoremap <silent>  <leader>go  <Cmd>DiffviewOpen<CR>
xnoremap <silent>  <leader>gl  :DiffviewFileHistory<CR>
nnoremap <silent>  <leader>gl  <Cmd>lua Snacks.picker.git_log_file()<CR>
nnoremap <silent>  <leader>gL  <Cmd>lua Snacks.picker.git_log()<CR>
nnoremap <silent>  <leader>gb  <Cmd>lua Snacks.picker.git_branches()<CR>
nnoremap <silent>  <leader>gB  <Cmd>lua Snacks.gitbrowse()<CR>
nnoremap <silent>  <leader>gd  <Cmd>GitDiffCurrent<CR>
nnoremap <silent>  <leader>ga  <Cmd>GitDiffAll<CR>
nnoremap <silent>  <leader>gt  <Cmd>GitDiffStagedCurrent<CR>
nnoremap <silent>  <leader>gT  <Cmd>GitDiffStagedAll<CR>
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

" l组：调试打印日志
nnoremap <silent>  <leader>ll  <Cmd>Chainsaw messageLog<CR>
nnoremap <silent>  <leader>lt  <Cmd>Chainsaw timeLog<CR>
noremap  <silent>  <leader>lv  <Cmd>Chainsaw variableLog<CR>
noremap  <silent>  <leader>ly  <Cmd>Chainsaw typeLog<CR>
noremap  <silent>  <leader>la  <Cmd>Chainsaw assertLog<CR>
noremap  <silent>  <leader>lx  <Cmd>Chainsaw removeLogs<CR>

" n组：笔记
nnoremap <silent>  <leader>nn  <Cmd>ObsidianDraft<CR>
nnoremap <silent>  <leader>ns  <Cmd>ObsidianSearch<CR>
nnoremap <silent>  <leader>nf  <Cmd>ObsidianQuickSwitch<CR>
nnoremap <silent>  <leader>ne  <Cmd>NvimTreeObsidian<CR>
nnoremap <silent>  <leader>nS  <Cmd>ObsidianSync<CR>
nnoremap <silent>  <leader>nc  <Cmd>ObsidianGitAdd<CR>
nnoremap <silent>  <leader>nC  <Cmd>ObsidianCommit<CR>
" }}}

" {{{ 按键 (LocalLeader) 特定文件类型
" Rust
function! RustKeymap() abort
	nnoremap <buffer><silent> <LocalLeader>r <Cmd>RustLsp runnables<CR>
	nnoremap <buffer><silent> <LocalLeader>e <Cmd>RustLsp expandMacro<CR>
	nnoremap <buffer><silent> <LocalLeader>u <Cmd>RustLsp parentModule<CR>
	nnoremap <buffer><silent> <LocalLeader>c <Cmd>RustLsp openCargo<CR>
	nnoremap <buffer><silent> <LocalLeader>p <Cmd>RustPlayground<CR>
endfunction
autocmd filetype rust call RustKeymap()

" Markdown
function! MarkdownKeymap() abort
	nmap     <buffer><silent> <LocalLeader>p <Plug>MarkdownPreviewToggle
	nnoremap <buffer><silent> <LocalLeader>f <Cmd>TypoSpace<CR>
	nnoremap <buffer><silent> <LocalLeader>g <Cmd>ObsidianFollowLink<CR>
endfunction
autocmd filetype markdown call MarkdownKeymap()
" }}}

" {{{ 按键 (文本对象)
" 注意mini.ai占用a和i，修改a和i前需要先确认mini-ai.lua

" 数字
onoremap <silent>  i0  <Cmd>lua require'various-textobjs'.number(true)<CR>
xnoremap <silent>  i0  <Cmd>lua require'various-textobjs'.number(true)<CR>

" 单词按分隔符划分
onoremap <silent>  iS  <Cmd>lua require'various-textobjs'.subword('inner')<CR>
xnoremap <silent>  iS  <Cmd>lua require'various-textobjs'.subword('inner')<CR>
onoremap <silent>  aS  <Cmd>lua require'various-textobjs'.subword('outer')<CR>
xnoremap <silent>  aS  <Cmd>lua require'various-textobjs'.subword('outer')<CR>

" 缩进
onoremap <silent>  iI  <Cmd>lua require'various-textobjs'.indentation('inner','inner')<CR>
xnoremap <silent>  iI  <Cmd>lua require'various-textobjs'.indentation('inner','inner')<CR>
onoremap <silent>  aI  <Cmd>lua require'various-textobjs'.indentation('outer','inner')<CR>
xnoremap <silent>  aI  <Cmd>lua require'various-textobjs'.indentation('outer','inner')<CR>

" diagnostic
onoremap <silent>  !   <Cmd>lua require'various-textobjs'.diagnostic()<CR>
xnoremap <silent>  !   <Cmd>lua require'various-textobjs'.diagnostic()<CR>

" Git hunk
onoremap <silent>  ih  <Cmd>Gitsigns select_hunk<CR>
xnoremap <silent>  ih  :Gitsigns select_hunk<CR>
" }}}

" vim: foldmethod=marker:foldlevel=0
