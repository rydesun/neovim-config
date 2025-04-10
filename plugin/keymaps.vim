" {{{ 按键 (覆盖默认行为)
noremap  H  ^
noremap  L  $
noremap  ;  :
noremap  :  ;
" 修改缩进后保持选中
xnoremap <  <gv
xnoremap >  >gv

" leap.nvim跳转
map  m  <Plug>(leap-forward-to)
map  M  <Plug>(leap-backward-to)

" 分页时按q直接退出
if get(g:, 'pager', v:false) | nnoremap q <Cmd>exit<CR> | endif

" s组：搜索/位置/文件跳转
" 另外有插件vim-sandwich占用sa、sd、sr
nnoremap   s   <NOP>
nnoremap   S   <Cmd>lua Snacks.picker()<CR>
nnoremap   sl  <Cmd>lua Snacks.picker.resume()<CR>

nnoremap   ss  <Cmd>lua Snacks.picker.grep()<CR>
nnoremap   sS  <Cmd>lua Snacks.picker.grep{exclude={},ignored=true,hidden=true}<CR>
nnoremap   sn  <Cmd>lua Snacks.picker.lsp_symbols()<CR>
nnoremap   sN  <Cmd>lua Snacks.picker.lsp_workspace_symbols()<CR>
nnoremap   sf  <Cmd>lua Snacks.picker.files()<CR>
nnoremap   sF  <Cmd>lua Snacks.picker.files{exclude={},ignored=true,hidden=true}<CR>
nnoremap   sg  <Cmd>lua Snacks.picker.git_status()<CR>
nnoremap   so  <Cmd>lua Snacks.picker.smart()<CR>
nnoremap   st  <Cmd>lua Snacks.picker.tagstack()<CR>
nnoremap   sp  <Cmd>lua Snacks.picker.projects()<CR>
nnoremap   s/  <Cmd>lua Snacks.picker.lines()<CR>
nnoremap   s;  <Cmd>lua Snacks.picker.command_history()<CR>
nnoremap   sq  <Cmd>lua Snacks.picker.diagnostics()<CR>
" Vim
nnoremap   svm <Cmd>lua Snacks.picker.noice()<CR>
nnoremap   svv <Cmd>lua Snacks.picker.help()<CR>
nnoremap   svh <Cmd>lua Snacks.picker.highlights()<CR>
nnoremap   svK <Cmd>lua Snacks.picker.keymaps()<CR>
nnoremap   svk <Cmd>lua Snacks.picker.grep { dirs={
                \ vim.fn.stdpath'config'..'/plugin/keymaps.vim'}}<CR>

" 跳转
nnoremap   [d  <Cmd>lua vim.diagnostic.jump{count=-vim.v.count1, float=true}<CR>
nnoremap   ]d  <Cmd>lua vim.diagnostic.jump{count=vim.v.count1, float=true}<CR>
nnoremap   [D  <Cmd>lua vim.diagnostic.jump{count=-vim.v.count1, float=true,
                \ severity=vim.diagnostic.severity.ERROR}<CR>
nnoremap   ]D  <Cmd>lua vim.diagnostic.jump{count=vim.v.count1, float=true,
                \ severity=vim.diagnostic.severity.ERROR}<CR>

" 特殊种类的补全
imap  <C-x><C-i>  <Cmd>lua Snacks.picker.icons()<CR>
imap  <C-x><C-x>  <Cmd>lua require'blink.cmp'.show{providers={'lsp'}}<CR>
imap  <C-x><C-s>  <Cmd>lua require'blink.cmp'.show{providers={'snippets'}}<CR>
imap  <C-x><C-b>  <Cmd>lua require'blink.cmp'.show{providers={'buffer'}}<CR>
imap  <C-x><C-r>  <Cmd>lua require'blink.cmp'.show{providers={'ripgrep'}}<CR>

lua << EOF
vim.keymap.set('n', '<C-l>', function()
-- {{{ 额外关闭通知浮窗
  pcall(function()
    require 'notify'.dismiss { silent = true }
  end)
  vim.cmd.nohlsearch()
  vim.cmd.diffupdate()
  vim.cmd.normal {
    vim.api.nvim_replace_termcodes('<C-l>', true, true, true), bang = true
  }
-- }}}
end)
EOF
" }}}

" {{{ 按键 (新增行为)
" g组：注释、按当前词跳转
" 插件vim-matchup/matchit提供g%，Comment.nvim提供gc gb
" mini.align提供ga gA，mini.ai提供g[ g]
" snacks.picker覆盖了LSP跳转键位
nnoremap   gbO  <Cmd>Neogen<CR>
nnoremap   gbo  <Cmd>Neogen<CR>
nnoremap   grt  <Cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap   grI  <Cmd>lua vim.lsp.buf.incoming_calls()<CR>
nnoremap   grO  <Cmd>lua vim.lsp.buf.outgoing_calls()<CR>
nnoremap   grl  <Cmd>lua vim.lsp.codelens.run()<CR>
noremap    gs   <Cmd>lua Snacks.picker.grep_word()<CR>

" []组：前后跳转，切换选项
" 插件vim-matchup/matchit提供 [% ]%, snacks.scope提供[i ]i
" nvim-treesitter-textobjects提供 [[ ]] [m ]m
" vim-unimpaired提供更多映射
nnoremap   ]w   <Cmd>NextTrailingWhitespace<CR>
nnoremap   [w   <Cmd>PrevTrailingWhitespace<CR>
nnoremap   [om  <Cmd>set colorcolumn=80<CR>
nnoremap   ]om  <Cmd>set colorcolumn=<CR>
nnoremap   [os  <Cmd>StatusColumnSignsInc<CR>
nnoremap   ]os  <Cmd>StatusColumnSignsReset<CR>
nnoremap   [oh  <Cmd>lua vim.lsp.inlay_hint.enable(true)<CR>
nnoremap   ]oh  <Cmd>lua vim.lsp.inlay_hint.enable(false)<CR>
nnoremap   [ow  <Cmd>lua vim.lsp.buf.document_highlight()<CR>
nnoremap   ]ow  <Cmd>lua vim.lsp.buf.clear_references()<CR>
nnoremap   [of  <Cmd>FormatOnSaveEnable<CR>
nnoremap   ]of  <Cmd>FormatOnSaveDisable<CR>
nnoremap   [oL  <Cmd>CodelensEnable<CR>
nnoremap   ]oL  <Cmd>CodelensDisable<CR>

" Ctrl组：前后跳转
inoremap   <C-j>    <Cmd>lua require'luasnip'.jump(1)<CR>
inoremap   <C-k>    <Cmd>lua require'luasnip'.jump(-1)<CR>
snoremap   <C-j>    <cmd>lua require'luasnip'.jump(1)<Cr>
snoremap   <C-k>    <cmd>lua require'luasnip'.jump(-1)<Cr>
nnoremap   <C-j>    <Cmd>Gitsigns nav_hunk next<CR>
nnoremap   <C-k>    <Cmd>Gitsigns nav_hunk prev<CR>
nnoremap   <C-S-j>  <Cmd>Gitsigns nav_hunk next target=staged<CR>
nnoremap   <C-S-k>  <Cmd>Gitsigns nav_hunk prev target=staged<CR>

" Ctrl+Alt组：语法节点跳转，修改节点
noremap    <C-A-j>  <Cmd>Treewalker Down<CR>
noremap    <C-A-k>  <Cmd>Treewalker Up<CR>
noremap    <C-A-u>  <Cmd>Treewalker Left<CR>
noremap    <C-A-d>  <Cmd>Treewalker Right<CR>
noremap    <C-A-o>  <Cmd>lua require'treesitter-context'.go_to_context(vim.v.count1)<CR>
nnoremap   <C-A-a>  <Cmd>lua require'ts-node-action'.node_action()<CR>

" Alt组：移动语法节点，移动光标，调整窗口大小，关闭
nnoremap   <A-s>    <Cmd>ISwapNode<CR>
nnoremap   <A-m>    <Cmd>IMoveNode<CR>
nnoremap   <A-o>    <Cmd>lua Symbols.sidebar.symbols.goto_symbol_under_cursor(0)<CR>
map        <A-p>    <Plug>(matchup-[%)
map        <A-n>    <Plug>(matchup-]%)
imap       <A-p>    <C-o><Plug>(matchup-[%)
imap       <A-n>    <C-o><Plug>(matchup-]%)
inoremap   <A-i>    <C-k>
nnoremap   <A-w>    <C-w>c
nnoremap   <A-S-w>  <Cmd>only<CR>
nnoremap   <A-j>    <Cmd>wincmd j<CR>
nnoremap   <A-k>    <Cmd>wincmd k<CR>
nnoremap   <A-h>    <Cmd>wincmd h<CR>
nnoremap   <A-l>    <Cmd>wincmd l<CR>
nnoremap   <A-S-j>  <C-w>+
nnoremap   <A-S-k>  <C-w>-
nnoremap   <A-S-h>  <C-w><
nnoremap   <A-S-l>  <C-w>>
tnoremap   <A-j>    <Cmd>wincmd j<CR>
tnoremap   <A-k>    <Cmd>wincmd k<CR>
tnoremap   <A-h>    <Cmd>wincmd h<CR>
tnoremap   <A-l>    <Cmd>wincmd l<CR>
tnoremap   <A-q>    <C-\><C-n>
nnoremap   <A-f>    <Cmd>lua Snacks.bufdelete()<CR>
nnoremap   <A-t>    <Cmd>tabclose<CR>
nnoremap   <A-q>    <Cmd>call <SID>toggleQuickFix()<CR>
function! s:toggleQuickFix()
    if getqflist({'winid' : 0}).winid | cclose | else | copen | endif
endfunction
" }}}

" {{{ 按键 (Emacs风格)
noremap!   <C-a>    <Home>
noremap!   <C-e>    <End>
noremap!   <A-b>    <C-Left>
noremap!   <A-f>    <C-Right>

" 允许滚动函数传参时出现的文档
noremap!   <C-b>    <Cmd>lua NoiceScrollDoc(-4, '<Left>', 'i')<CR>
noremap!   <C-f>    <Cmd>lua NoiceScrollDoc(4, '<Right>', 'i')<CR>
snoremap   <C-b>    <Cmd>lua NoiceScrollDoc(-4, '<Left>', 'i')<CR>
snoremap   <C-f>    <Cmd>lua NoiceScrollDoc(4, '<Right>', 'i')<CR>
" 注意开启插件Neoscroll会覆盖此设置，所以Neosroll的配置内需要再次设置一次
nnoremap   <C-b>    <Cmd>lua NoiceScrollDoc(-4, '<C-b>', 'n')<CR>
nnoremap   <C-f>    <Cmd>lua NoiceScrollDoc(4, '<C-f>', 'n')<CR>

" 根据前缀补全
cnoremap   <C-p>    <Up>
cnoremap   <C-n>    <Down>
" }}}

" {{{ 按键 (Leader单键)
let g:mapleader=' ' | nnoremap <Space> <Nop>
let g:maplocalleader='\'

nnoremap   <leader>s   <Cmd>lua require'treesj'.split()<CR>
nnoremap   <leader>j   <Cmd>lua require'treesj'.join()<CR>

" 数字组：编译运行
nnoremap   <leader>1   <Cmd>AsyncTask cwd-run<CR>
nnoremap   <leader>2   <Cmd>AsyncTask cwd-build<CR>
nnoremap   <leader>3   <Cmd>AsyncTask cwd-build-release<CR>
nnoremap   <leader>4   <Cmd>AsyncTask cwd-test<CR>
nnoremap   <leader>5   <Cmd>AsyncTask cwd-command<CR>

nnoremap   <leader>6   <Cmd>AsyncTask file-command<CR>
nnoremap   <leader>7   <Cmd>AsyncTask file-run<CR>
nnoremap   <leader>8   <Cmd>AsyncTask file-build<CR>
nnoremap   <leader>9   <Cmd>AsyncTask file-test<CR>

nnoremap   <leader>0   <Cmd>AsyncTask repl<CR>
nnoremap   <leader>-   <Cmd>AsyncTaskTogglePos<CR>

noremap    <leader><Enter>    <Cmd>SnipRun<CR>
noremap    <leader><S-Enter>  <Cmd>call <SID>SnipRunFile()<CR>
function s:SnipRunFile() abort
    let l:caret=winsaveview()
    execute '%SnipRun'
    call winrestview(l:caret)
endfunction

xnoremap   <leader>y   "+y
nn<expr>   <leader>p   empty(getreg('+')) ? '<Cmd>PasteImage<CR>' : '"+p'
nnoremap   <leader>P   "+P
nnoremap   <leader>e   <Cmd>NvimTreeFindFileToggle!<CR>
nnoremap   <leader>u   <Cmd>lua Snacks.picker.undo {layout='sidebar'}<CR>
nnoremap   <leader>o   <Cmd>SymbolsToggle<CR>
nnoremap   <leader>K   <Cmd>normal! K<CR>

" LSP
nnoremap   <leader>f   <Cmd>LspFormat<CR>
xnoremap   <leader>f   <Cmd>lua vim.lsp.buf.format{async=true}<CR>
nnoremap   <leader>F   <Cmd>LspFixAll<CR>
" }}}

" {{{ 按键 (Leader多键)
" c组：复制
nnoremap   <leader>cN  <Cmd>echo     expand('%:t')<CR>
nnoremap   <leader>cn  <Cmd>let @+ = expand('%:t')<CR>
nnoremap   <leader>cF  <Cmd>echo     expand('%:p:~')<CR>
nnoremap   <leader>cf  <Cmd>let @+ = expand('%:p:~')<CR>
nnoremap   <leader>cD  <Cmd>echo     expand('%:p:~:h')..'/'<CR>
nnoremap   <leader>cd  <Cmd>let @+ = expand('%:p:~:h')..'/'<CR>

" h组g组：Git Hunk
nnoremap   <leader>hs  <Cmd>Gitsigns stage_hunk<CR>
xnoremap   <leader>hs  :Gitsigns stage_hunk<CR>
nnoremap   <leader>hS  <Cmd>Gitsigns stage_buffer<CR>
nnoremap   <leader>hu  <Cmd>Gitsigns reset_hunk<CR>
xnoremap   <leader>hu  :Gitsigns reset_hunk<CR>
nnoremap   <leader>hU  <Cmd>Gitsigns undo_stage_hunk<CR>
nnoremap   <leader>hR  <Cmd>Gitsigns reset_buffer<CR>
nnoremap   <leader>hi  <Cmd>Gitsigns preview_hunk<CR>
nnoremap   <leader>hb  <Cmd>lua require'gitsigns'.blame_line{full=true}<CR>
nnoremap   <leader>hB  <Cmd>Gitsigns toggle_current_line_blame<CR>
nnoremap   <leader>hd  <Cmd>Gitsigns toggle_deleted<CR>
nnoremap   <leader>hw  <Cmd>Gitsigns toggle_word_diff<CR>
nnoremap   <leader>hq  <Cmd>Gitsigns setqflist all<CR>

nnoremap   <leader>G   <Cmd>Neogit<CR>
nnoremap   <leader>go  <Cmd>DiffviewOpen<CR>
xn<silent> <leader>gl  :DiffviewFileHistory<CR>
nnoremap   <leader>gl  <Cmd>lua Snacks.picker.git_log_file()<CR>
nnoremap   <leader>gL  <Cmd>lua Snacks.picker.git_log()<CR>
nnoremap   <leader>gb  <Cmd>lua Snacks.picker.git_branches()<CR>
nnoremap   <leader>gB  <Cmd>lua Snacks.gitbrowse()<CR>
nnoremap   <leader>gd  <Cmd>GitDiffCurrent<CR>
nnoremap   <leader>ga  <Cmd>GitDiffAll<CR>
nnoremap   <leader>gt  <Cmd>GitDiffStagedCurrent<CR>
nnoremap   <leader>gT  <Cmd>GitDiffStagedAll<CR>
nnoremap   <leader>gs  <Cmd>DiffViewPickaxeCurrent<CR>
nnoremap   <leader>gS  <Cmd>DiffViewPickaxeAll<CR>

" t组：操作终端、测试
nnoremap   <leader>tt  <Cmd>ToggleTerm direction=float<CR>
nnoremap   <leader>tb  <Cmd>ToggleTerm direction=horizontal<CR>
nnoremap   <leader>ts  <Cmd>ToggleTermSendCurrentLine<CR>
xnoremap   <leader>ts  <Cmd>ToggleTermSendVisualSelection<CR>
nnoremap   <leader>tn  <Cmd>TestNearest<CR>
nnoremap   <leader>tf  <Cmd>TestFile<CR>
nnoremap   <leader>tl  <Cmd>TestLast<CR>
nnoremap   <leader>tv  <Cmd>TestVisit<CR>
nnoremap   <leader>ta  <Cmd>lua Snacks.picker.alternative_file{affix='test'}<CR>

" d组：调试
nnoremap   <leader>dd  <Cmd>DapNew<CR>
nnoremap   <leader>dc  <Cmd>DapContinue<CR>
nnoremap   <leader>di  <Cmd>DapStepInto<CR>
nnoremap   <leader>do  <Cmd>DapStepOut<CR>
nnoremap   <leader>dn  <Cmd>DapStepOver<CR>
nnoremap   <leader>db  <Cmd>DapToggleBreakpoint<CR>
nnoremap   <leader>dx  <Cmd>DapClearBreakpoints<CR>
nnoremap   <leader>dl  <Cmd>lua require'dap'.run_last()<CR>
nnoremap   <leader>dL  <Cmd>lua require'dap'.
                        \ set_breakpoint(nil, nil, vim.fn.input'Log: ')<CR>
nnoremap   <leader>de  <Cmd>DapEval<CR>
nnoremap   <leader>dr  <Cmd>DapToggleRepl<CR>
nnoremap   <leader>du  <Cmd>DapViewToggle<CR>
nnoremap   <leader>dv  <Cmd>lua require'dap.ui.widgets'.
                        \ centered_float(require'dap.ui.widgets'.scopes)<CR>
function! RustDapKeymap() abort
    nnoremap  <buffer> <leader>dd  <Cmd>RustLsp debug<CR>
endfunction
autocmd filetype rust call RustDapKeymap()
function! PythonDapKeymap() abort
    xn<silent><buffer> <leader>dd  :lua require'dap-python'.debug_selection()<CR>
    nnoremap  <buffer> <leader>dt  <Cmd>lua require'dap-python'.test_method()<CR>
    nnoremap  <buffer> <leader>dT  <Cmd>lua require'dap-python'.test_class()<CR>
endfunction
autocmd filetype python call PythonDapKeymap()

" l组：调试打印日志
nnoremap   <leader>ll  <Cmd>Chainsaw messageLog<CR>
nnoremap   <leader>lt  <Cmd>Chainsaw timeLog<CR>
noremap    <leader>lv  <Cmd>Chainsaw variableLog<CR>
noremap    <leader>ly  <Cmd>Chainsaw typeLog<CR>
noremap    <leader>la  <Cmd>Chainsaw assertLog<CR>
noremap    <leader>lx  <Cmd>Chainsaw removeLogs<CR>

" q组：Session
nnoremap   <leader>ql  <Cmd>PossessionLoad<CR>
nnoremap   <leader>qL  <Cmd>PossessionLoadCwd<CR>
nnoremap   <leader>qp  <Cmd>PossessionPick<CR>

" n组：笔记
nnoremap   <leader>nn  <Cmd>ObsidianDraft<CR>
nnoremap   <leader>ns  <Cmd>ObsidianSearch<CR>
nnoremap   <leader>nf  <Cmd>ObsidianQuickSwitch<CR>
nnoremap   <leader>ne  <Cmd>NvimTreeObsidian<CR>
nnoremap   <leader>nS  <Cmd>ObsidianSync<CR>
nnoremap   <leader>nc  <Cmd>ObsidianGitAdd<CR>
nnoremap   <leader>nC  <Cmd>ObsidianCommit<CR>
" }}}

" {{{ 按键 (LocalLeader) 特定文件类型
nnoremap   <LocalLeader>p  <Cmd>lua Snacks.scratch()<CR>

" Rust
function! RustKeymap() abort
    nnoremap <buffer> <LocalLeader>r <Cmd>RustLsp runnables<CR>
    nnoremap <buffer> <LocalLeader>e <Cmd>RustLsp expandMacro<CR>
    nnoremap <buffer> <LocalLeader>u <Cmd>RustLsp parentModule<CR>
    nnoremap <buffer> <LocalLeader>c <Cmd>RustLsp openCargo<CR>
    nnoremap <buffer> <LocalLeader>p <Cmd>RustPlayground<CR>
endfunction
autocmd filetype rust call RustKeymap()

" Markdown
function! MarkdownKeymap() abort
    nmap     <buffer> <LocalLeader>p <Plug>MarkdownPreviewToggle
    nnoremap <buffer> <LocalLeader>f <Cmd>TypoSpace<CR>
    nnoremap <buffer> <LocalLeader>g <Cmd>ObsidianFollowLink<CR>
endfunction
autocmd filetype markdown call MarkdownKeymap()
" }}}

" {{{ 按键 (文本对象)
" 注意mini.ai占用a和i，修改a和i前需要先确认mini-ai.lua

" 数字
onoremap   i0  <Cmd>lua require'various-textobjs'.number(true)<CR>
xnoremap   i0  <Cmd>lua require'various-textobjs'.number(true)<CR>

" 单词按分隔符划分
onoremap   iS  <Cmd>lua require'various-textobjs'.subword('inner')<CR>
xnoremap   iS  <Cmd>lua require'various-textobjs'.subword('inner')<CR>
onoremap   aS  <Cmd>lua require'various-textobjs'.subword('outer')<CR>
xnoremap   aS  <Cmd>lua require'various-textobjs'.subword('outer')<CR>

" 缩进
onoremap   iI  <Cmd>lua require'various-textobjs'.indentation('inner','inner')<CR>
xnoremap   iI  <Cmd>lua require'various-textobjs'.indentation('inner','inner')<CR>
onoremap   aI  <Cmd>lua require'various-textobjs'.indentation('outer','inner')<CR>
xnoremap   aI  <Cmd>lua require'various-textobjs'.indentation('outer','inner')<CR>

" diagnostic
onoremap   !   <Cmd>lua require'various-textobjs'.diagnostic()<CR>
xnoremap   !   <Cmd>lua require'various-textobjs'.diagnostic()<CR>

" Git hunk
onoremap   ih  <Cmd>Gitsigns select_hunk<CR>
xn<silent> ih  :Gitsigns select_hunk<CR>
" }}}

" vim: foldmethod=marker:foldlevel=0
