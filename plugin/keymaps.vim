command -nargs=+ Xns xnoremap <silent> <args>
command -nargs=+ Nse nm <silent><expr> <args>

let g:mapleader=' ' | nn <Space> <Nop>
let g:maplocalleader='\'

" {{{ 按键 (覆盖原始行为)
no  ;  :
no  H  ^
no  L  $

" leap.nvim跳转
map m  <Plug>(leap-anywhere)
nn  M  m
nn  `  '
nn  '  `

" 修改缩进后保持选中
xn  <  <gv
xn  >  >gv

" 只在选中区域搜索
xn  /  <Esc>/\%V

" 作为pager时按q或者<C-c>直接退出
if get(g:, 'pager', v:false)
    nn q <Cmd>exit<CR>
    nn <C-c> <Cmd>exit<CR>
endif

" s组：搜索/位置/文件跳转
" mini.surround占用sa、sd、sr、sh、s+
" mini.operators占用sx、s=、s<
nn  s   <NOP>
nn  S   <Cmd>lua Snacks.picker()<CR>
nn  sl  <Cmd>lua Snacks.picker.resume()<CR>

nn  ss  <Cmd>lua Snacks.picker.grep()<CR>
nn  sS  <Cmd>lua Snacks.picker.grep{exclude={},ignored=true,hidden=true}<CR>
nn  sn  <Cmd>lua Snacks.picker.lsp_symbols()<CR>
nn  sN  <Cmd>lua Snacks.picker.lsp_workspace_symbols()<CR>
nn  sf  <Cmd>lua Snacks.picker.files()<CR>
nn  sF  <Cmd>lua Snacks.picker.files{exclude={},ignored=true,hidden=true}<CR>
nn  sg  <Cmd>lua Snacks.picker.git_status()<CR>
nn  so  <Cmd>lua Snacks.picker.smart()<CR>
nn  st  <Cmd>lua Snacks.picker.tagstack()<CR>
nn  sp  <Cmd>lua Snacks.picker.projects()<CR>
nn  s/  <Cmd>lua Snacks.picker.lines()<CR>
nn  s?  <Cmd>lua Snacks.picker.search_history()<CR>
nn  s;  <Cmd>lua Snacks.picker.command_history()<CR>
nn  sq  <Cmd>lua Snacks.picker.diagnostics()<CR>
nn  sy  <Cmd>YankyRingHistory<CR>
" Vim
nn  svm <Cmd>lua Snacks.picker.noice()<CR>
nn  svM <Cmd>NoiceAll<CR>
nn  svv <Cmd>lua Snacks.picker.help()<CR>
nn  svh <Cmd>lua Snacks.picker.highlights()<CR>
nn  svk <Cmd>lua Snacks.picker.keymaps()<CR>
nn  svp <Cmd>lua Snacks.profiler.toggle()<CR>
nn  svP <Cmd>lua Snacks.profiler.scratch()<CR>

" Emacs风格
" <C-f>和<C-b>见keymaps-scroll.lua
map! <C-a>  <Home>
map! <C-e>  <End>
smap <C-a>  <Home>
smap <C-e>  <End>
map! <A-b>  <C-Left>
map! <A-f>  <C-Right>
smap <A-b>  <C-Left>
smap <A-f>  <C-Right>

" 根据前缀补全历史命令
cno  <C-p>  <Up>
cno  <C-n>  <Down>

lua << EOF
vim.keymap.set('n', '<C-l>', function() -- {{{ 额外关闭通知浮窗
  pcall(function() require 'notify'.dismiss { silent = true } end)
  vim.cmd.nohlsearch()
  vim.cmd.diffupdate()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(
    '<C-l>', true, false, true), 'n', true)
end) -- }}}
EOF
" }}}

" {{{ 按键 (新增行为)
" g组：注释、按当前词跳转
" 插件vim-matchup/matchit提供g%，Comment.nvim提供gc gb
" mini.align提供ga gA，mini.ai提供g[ g]
" snacks.picker覆盖了LSP跳转键位
nn  g?  <Cmd>lua Snacks.picker.keymap_file()<CR>
nm  gyc yygccp
xm  gyc y<Cmd>'><CR>=pgvgc<Cmd>'><CR>j
nn  gbO <Cmd>Neogen<CR>
nn  gbo <Cmd>Neogen<CR>
nn  grt <Cmd>lua vim.lsp.buf.type_definition()<CR>
nn  grI <Cmd>lua vim.lsp.buf.incoming_calls()<CR>
nn  grO <Cmd>lua vim.lsp.buf.outgoing_calls()<CR>
nn  grl <Cmd>lua vim.lsp.codelens.run()<CR>
no  gs  <Cmd>lua Snacks.picker.grep_word()<CR>
nn  g<leader>r <Cmd>Glance references<CR>
nn  g<leader>d <Cmd>Glance definitions<CR>
nn  g<leader>t <Cmd>Glance type_definitions<CR>
nn  g<leader>i <Cmd>Glance implementations<CR>
nn  g<leader>l <Cmd>Glance resume<CR>

" []组：前后跳转，切换选项
" 插件vim-matchup/matchit提供 [% ]%, snacks.scope提供[i ]i
" nvim-treesitter-textobjects提供 [[ ]] [m ]m
" mini.bracketed提供更多映射
nn  [e  <Cmd>lua vim.diagnostic.jump{count=-vim.v.count1,severity=1}<CR>
nn  ]e  <Cmd>lua vim.diagnostic.jump{count=vim.v.count1,severity=1}<CR>
nn  [r  <Cmd>MoltenPrev<CR>
nn  ]r  <Cmd>MoltenNext<CR>
nn  ]R  <Cmd>lua require'kulala.ui'.show_next()<CR>
nn  [R  <Cmd>lua require'kulala.ui'.show_previous()<CR>
nn  [w  <Cmd>lua vim.lsp.buf.document_highlight()<CR>
nn  ]w  <Cmd>lua vim.lsp.buf.clear_references()<CR>
nn  [ob <Cmd>set background=light<CR>
nn  ]ob <Cmd>set background=dark<CR>
nn  [oc <Cmd>set colorcolumn=80<CR>
nn  ]oc <Cmd>set colorcolumn=<CR>
nn  [of <Cmd>FormatOnSaveEnable<CR>
nn  ]of <Cmd>FormatOnSaveDisable<CR>
nn  [oh <Cmd>lua vim.lsp.inlay_hint.enable(true)<CR>
nn  ]oh <Cmd>lua vim.lsp.inlay_hint.enable(false)<CR>
nn  [oH <Cmd>HexDump<CR>
nn  ]oH <Cmd>HexAssemble<CR>
nn  [ol <Cmd>setlocal list<CR>
nn  ]ol <Cmd>setlocal nolist<CR>
nn  [oL <Cmd>CodelensEnable<CR>
nn  ]oL <Cmd>CodelensDisable<CR>
nn  [oM <Cmd>DoMatchParen<CR>
nn  ]oM <Cmd>NoMatchParen<CR>
nn  [os <Cmd>StatusColumnSignsInc<CR>
nn  ]os <Cmd>StatusColumnSignsReset<CR>
nn  [ow <Cmd>setlocal wrap<CR>
nn  ]ow <Cmd>setlocal nowrap<CR>

" Ctrl组：前后跳转
" kitty_mod默认为C-S-前缀，需要注意冲突
" emmet占用<C-S-y>
" nvim-recorder占用<C-q>
" 另见blink.cmp
nn  <C-j>   <Cmd>Gitsigns nav_hunk next<CR>
nn  <C-k>   <Cmd>Gitsigns nav_hunk prev<CR>
nn  <C-S-j> <Cmd>Gitsigns nav_hunk next target=staged<CR>
nn  <C-S-k> <Cmd>Gitsigns nav_hunk prev target=staged<CR>
ino <C-j>   <Cmd>lua require'luasnip'.jump(1)<CR>
ino <C-k>   <Cmd>lua require'luasnip'.jump(-1)<CR>
snor<C-j>   <cmd>lua require'luasnip'.jump(1)<Cr>
snor<C-k>   <cmd>lua require'luasnip'.jump(-1)<Cr>
snor<C-l>   <Esc>`>a
ino <C-n>   <Plug>luasnip-next-choice
ino <C-p>   <Plug>luasnip-prev-choice

" Ctrl-x组：特殊种类的补全
im  <C-x><C-j>  <Cmd>lua require'luasnip'.expand()<CR>
im  <C-x><C-s>  <Cmd>lua Snacks.picker.icons()<CR>
im  <C-x><C-x>  <Cmd>lua require'blink.cmp'.show{providers={'lsp'}}<CR>
im  <C-x><C-b>  <Cmd>lua require'blink.cmp'.show{providers={'buffer'}}<CR>
im  <C-x><C-r>  <Cmd>lua require'blink.cmp'.show{providers={'ripgrep'}}<CR>

" Ctrl-w组：窗口
nn  <C-w><Enter>  <Cmd>lua Snacks.zen.zen()<CR>

" Ctrl+Alt组：语法节点跳转，修改节点
no  <C-A-j> <Cmd>Treewalker Down<CR>
no  <C-A-k> <Cmd>Treewalker Up<CR>
no  <C-A-u> <Cmd>Treewalker Left<CR>
no  <C-A-d> <Cmd>Treewalker Right<CR>
no  <C-A-o> <Cmd>lua require'treesitter-context'.go_to_context(vim.v.count1)<CR>
nn  <C-A-a> <Cmd>lua require'ts-node-action'.node_action()<CR>

" Alt组：切换复制内容，移动语法节点，移动光标，调整窗口大小，关闭
nn  <A-p>   <Plug>(YankyPreviousEntry)
nn  <A-n>   <Plug>(YankyNextEntry)
nn  <A-s>   <Cmd>ISwapNode<CR>
nn  <A-m>   <Cmd>IMoveNode<CR>
nn  <A-o>   <Cmd>lua Symbols.sidebar.symbols.goto_symbol_under_cursor(0)<CR>
ino <A-i>   <C-k>
nn  <A-w>   <C-w>c
nn  <A-j>   <Cmd>wincmd j<CR>
nn  <A-k>   <Cmd>wincmd k<CR>
nn  <A-h>   <Cmd>wincmd h<CR>
nn  <A-l>   <Cmd>wincmd l<CR>
nn  <A-S-j> <C-w>+
nn  <A-S-k> <C-w>-
nn  <A-S-h> <C-w><
nn  <A-S-l> <C-w>>
tno <A-j>   <Cmd>wincmd j<CR>
tno <A-k>   <Cmd>wincmd k<CR>
tno <A-h>   <Cmd>wincmd h<CR>
tno <A-l>   <Cmd>wincmd l<CR>
tno <A-q>   <C-\><C-n>
nn  <A-f>   <Cmd>lua Snacks.bufdelete()<CR>
nn  <A-t>   <Cmd>tabclose<CR>
nn  <A-q>   <Cmd>call <SID>toggleQuickFix()<CR>
function! s:toggleQuickFix()
    if getqflist({'winid' : 0}).winid | cclose | else | copen | endif
endfunction
" }}}

" {{{ 按键 (Leader单键)
nn  <leader>s   <Cmd>lua require'treesj'.split()<CR>
nn  <leader>j   <Cmd>lua require'treesj'.join()<CR>

xn  <leader>S   <Cmd>ScissorsAddNewSnippet<CR>
nn  <leader>S   <Cmd>ScissorsEditSnippet<CR>

" 数字组：编译运行
nn  <leader>1   <Cmd>AsyncTask cwd-run<CR>
nn  <leader>2   <Cmd>AsyncTask cwd-build<CR>
nn  <leader>3   <Cmd>AsyncTask cwd-build-release<CR>
nn  <leader>4   <Cmd>AsyncTask cwd-test<CR>
nn  <leader>5   <Cmd>AsyncTask cwd-command<CR>

nn  <leader>6   <Cmd>AsyncTask file-command<CR>
nn  <leader>7   <Cmd>AsyncTask file-run<CR>
nn  <leader>8   <Cmd>AsyncTask file-build<CR>
nn  <leader>9   <Cmd>AsyncTask file-test<CR>

nn  <leader>0   <Cmd>AsyncTask repl<CR>
nn  <leader>-   <Cmd>AsyncTaskPos<CR>

xn  <leader>y   "+y
Nse <leader>p   empty(getreg('+')) ? '<Cmd>PasteImage<CR>' : '"+p'
nn  <leader>P   "+P
nn  <leader>e   <Cmd>NvimTreeFindFileToggle!<CR>
nn  <leader>u   <Cmd>lua Snacks.picker.undo {layout='sidebar'}<CR>
nn  <leader>o   <Cmd>SymbolsToggle<CR>
nn  <leader>K   <Cmd>normal! K<CR>

" LSP+Linter+Formatter
no  <leader>f   <Cmd>LspFormat<CR>
nn  <leader>F   <Cmd>LspFixAll<CR>
nn  <leader>C   <Cmd>lua require'lint'.try_lint()<CR>

" 查询
nn  <leader>k   <Cmd>lua require 'hover'.hover()<CR>
nn  <leader>K   <Cmd>lua require 'hover'.hover_select()<CR>
" }}}

" {{{ 按键 (Leader多键)
" c组：替换、复制
no  <leader>cs  <Cmd>lua require'rip-substitute'.sub()<CR>
nn  <leader>cS  <Cmd>lua require'grug-far'.open{prefills={paths=vim.fn.expand'%'}}<CR>
Xns <leader>cS  :GrugFarWithin<CR>
nn  <leader>cg  <Cmd>GrugFar<CR>
Xns <leader>cg  :GrugFar<CR>
no  <leader>cr  <Cmd>lua require'ssr'.open()<CR>
nn  <leader>cN  <Cmd>echo     expand('%:t')<CR>
nn  <leader>cn  <Cmd>let @+ = expand('%:t')<CR>
nn  <leader>cF  <Cmd>echo     expand('%:p:~')<CR>
nn  <leader>cf  <Cmd>let @+ = expand('%:p:~')<CR>
nn  <leader>cD  <Cmd>echo     expand('%:p:~:h')..'/'<CR>
nn  <leader>cd  <Cmd>let @+ = expand('%:p:~:h')..'/'<CR>

" h组g组：Git Hunk
nn  <leader>hs  <Cmd>Gitsigns stage_hunk<CR>
xn  <leader>hs  :Gitsigns stage_hunk<CR>
nn  <leader>hS  <Cmd>Gitsigns stage_buffer<CR>
nn  <leader>hu  <Cmd>Gitsigns reset_hunk<CR>
xn  <leader>hu  :Gitsigns reset_hunk<CR>
nn  <leader>hU  <Cmd>Gitsigns undo_stage_hunk<CR>
nn  <leader>hR  <Cmd>Gitsigns reset_buffer<CR>
nn  <leader>hi  <Cmd>Gitsigns preview_hunk<CR>
nn  <leader>hb  <Cmd>lua require'gitsigns'.blame_line{full=true}<CR>
nn  <leader>hB  <Cmd>Gitsigns blame<CR>
nn  <leader>hd  <Cmd>Gitsigns toggle_deleted<CR>
nn  <leader>hw  <Cmd>Gitsigns toggle_word_diff<CR>
nn  <leader>hq  <Cmd>Gitsigns setqflist all<CR>

nn  <leader>G   <Cmd>Neogit<CR>
nn  <leader>go  <Cmd>DiffviewOpen<CR>
Xns <leader>gl  :DiffviewFileHistory<CR>
nn  <leader>gl  <Cmd>lua Snacks.picker.git_log_file()<CR>
nn  <leader>gL  <Cmd>lua Snacks.picker.git_log()<CR>
nn  <leader>gb  <Cmd>lua Snacks.picker.git_branches()<CR>
no  <leader>gB  <Cmd>lua Snacks.gitbrowse()<CR>
nn  <leader>gd  <Cmd>GitDiffCurrent<CR>
nn  <leader>ga  <Cmd>GitDiffAll<CR>
nn  <leader>gt  <Cmd>GitDiffStagedCurrent<CR>
nn  <leader>gT  <Cmd>GitDiffStagedAll<CR>
nn  <leader>gs  <Cmd>DiffViewPickaxeCurrent<CR>
nn  <leader>gS  <Cmd>DiffViewPickaxeAll<CR>

" t组：操作终端、测试
nn  <leader>tt  <Cmd>ToggleTerm direction=float<CR>
nn  <leader>tb  <Cmd>ToggleTerm direction=horizontal<CR>
nn  <leader>ts  <Cmd>ToggleTermSendCurrentLine<CR>
xn  <leader>ts  <Cmd>ToggleTermSendVisualSelection<CR>
nn  <leader>tn  <Cmd>TestNearest<CR>
nn  <leader>tf  <Cmd>TestFile<CR>
nn  <leader>tl  <Cmd>TestLast<CR>
nn  <leader>tv  <Cmd>TestVisit<CR>
nn  <leader>ta  <Cmd>lua Snacks.picker.alternative_file{affix='test'}<CR>

" r组：运行
nn  <leader>rO  <Cmd>lua require'otter'.activate()<CR>
Xns <leader>r   :<C-u>MoltenEvaluateVisual<CR>
nn  <leader>rr  <Cmd>MoltenReevaluateCell<CR>
nn  <leader>rl  <Cmd>MoltenEvaluateLine<CR>
nn  <leader>ro  <Cmd>noautocmd MoltenEnterOutput<CR>
nn  <leader>rc  <Cmd>MoltenHideOutput<CR>
nn  <leader>rC  <Cmd>MoltenDelete<CR>
nn  <leader>rS  <Cmd>MoltenSave<CR>
nn  <leader>rL  <Cmd>MoltenLoad<CR>
nn  <leader>rE  <Cmd>MoltenExportOutput<CR>
nn  <leader>rI  <Cmd>MoltenImportOutput<CR>

" d组：调试
nn  <leader>dd  <Cmd>DapNew<CR>
nn  <leader>dc  <Cmd>lua require'dap'.continue()<CR>
nn  <leader>di  <Cmd>lua require'dap'.step_into()<CR>
nn  <leader>do  <Cmd>lua require'dap'.step_out()<CR>
nn  <leader>dn  <Cmd>lua require'dap'.step_over()<CR>
nn  <leader>db  <Cmd>lua require'dap'.toggle_breakpoint()<CR>
nn  <leader>dx  <Cmd>lua require'dap'.clear_breakpoints()<CR>
nn  <leader>dl  <Cmd>lua require'dap'.run_last()<CR>
nn  <leader>dL  <Cmd>lua require'dap'.
                \ set_breakpoint(nil, nil, vim.fn.input'Log: ')<CR>
nn  <leader>de  <Cmd>DapEval<CR>
nn  <leader>dr  <Cmd>DapToggleRepl<CR>
nn  <leader>dv  <Cmd>DapViewToggle<CR>
function! RustDapKeymap() abort
    nn  <buffer> <leader>dd  <Cmd>RustLsp debug<CR>
endfunction
autocmd filetype rust call RustDapKeymap()
function! PythonDapKeymap() abort
    Xns <buffer> <leader>dd  :lua require'dap-python'.debug_selection()<CR>
    nn  <buffer> <leader>dt  <Cmd>lua require'dap-python'.test_method()<CR>
    nn  <buffer> <leader>dT  <Cmd>lua require'dap-python'.test_class()<CR>
endfunction
autocmd filetype python call PythonDapKeymap()

" l组：调试打印日志
nn  <leader>ll  <Cmd>Chainsaw messageLog<CR>
nn  <leader>lt  <Cmd>Chainsaw timeLog<CR>
no  <leader>lv  <Cmd>Chainsaw variableLog<CR>
no  <leader>ly  <Cmd>Chainsaw typeLog<CR>
no  <leader>la  <Cmd>Chainsaw assertLog<CR>
no  <leader>lx  <Cmd>Chainsaw removeLogs<CR>

" q组：Session
nn  <leader>ql  <Cmd>PossessionLoad<CR>
nn  <leader>qL  <Cmd>PossessionLoadCwd<CR>
nn  <leader>qp  <Cmd>PossessionPick<CR>

" n组：笔记
nn  <leader>nn  <Cmd>ObsidianDraft<CR>
nn  <leader>ns  <Cmd>ObsidianSearch<CR>
nn  <leader>nf  <Cmd>ObsidianQuickSwitch<CR>
nn  <leader>ne  <Cmd>NvimTreeObsidian<CR>
nn  <leader>nS  <Cmd>ObsidianSync<CR>
nn  <leader>nc  <Cmd>ObsidianGitAdd<CR>
nn  <leader>nC  <Cmd>ObsidianCommit<CR>
" }}}

" {{{ 按键 (LocalLeader) 特定文件类型
nn  <LocalLeader>p  <Cmd>lua Snacks.scratch()<CR>

" Rust
function! RustKeymap() abort
    nn <buffer> <LocalLeader>r <Cmd>RustLsp runnables<CR>
    nn <buffer> <LocalLeader>e <Cmd>RustLsp expandMacro<CR>
    nn <buffer> <LocalLeader>u <Cmd>RustLsp parentModule<CR>
    nn <buffer> <LocalLeader>c <Cmd>RustLsp openCargo<CR>
    nn <buffer> <LocalLeader>p <Cmd>RustPlayground<CR>
endfunction
autocmd filetype rust call RustKeymap()

" Markdown
function! MarkdownKeymap() abort
    nm <buffer> <LocalLeader>p <Plug>MarkdownPreviewToggle
    nn <buffer> <LocalLeader>f <Cmd>TypoSpace<CR>
    nn <buffer> <LocalLeader>g <Cmd>ObsidianFollowLink<CR>
endfunction
autocmd filetype markdown call MarkdownKeymap()

" package.json
function! PackageJsonKeymap() abort
    nn <buffer> <LocalLeader>s <Cmd>lua require'package-info'.show{force=true}<CR>
    nn <buffer> <LocalLeader>c <Cmd>lua require'package-info'.hide()<CR>
    nn <buffer> <LocalLeader>t <Cmd>lua require'package-info'.toggle()<CR>
    nn <buffer> <LocalLeader>u <Cmd>lua require'package-info'.update()<CR>
    nn <buffer> <LocalLeader>d <Cmd>lua require'package-info'.delete()<CR>
    nn <buffer> <LocalLeader>i <Cmd>lua require'package-info'.install()<CR>
    nn <buffer> <LocalLeader>p <Cmd>lua require'package-info'.change_version()<CR>
endfunction
autocmd BufRead package.json call PackageJsonKeymap()
" }}}

" {{{ 按键 (文本对象)
" 注意mini.ai占用a和i，修改a和i前需要先确认mini-ai.lua

" 数字
ono i0  <Cmd>lua require'various-textobjs'.number(true)<CR>
xn  i0  <Cmd>lua require'various-textobjs'.number(true)<CR>

" 单词按分隔符划分
ono iS  <Cmd>lua require'various-textobjs'.subword('inner')<CR>
xn  iS  <Cmd>lua require'various-textobjs'.subword('inner')<CR>
ono aS  <Cmd>lua require'various-textobjs'.subword('outer')<CR>
xn  aS  <Cmd>lua require'various-textobjs'.subword('outer')<CR>

" 缩进
ono iI  <Cmd>lua require'various-textobjs'.indentation('inner','inner')<CR>
xn  iI  <Cmd>lua require'various-textobjs'.indentation('inner','inner')<CR>
ono aI  <Cmd>lua require'various-textobjs'.indentation('outer','inner')<CR>
xn  aI  <Cmd>lua require'various-textobjs'.indentation('outer','inner')<CR>

" diagnostic
ono !   <Cmd>lua require'various-textobjs'.diagnostic()<CR>
xn  !   <Cmd>lua require'various-textobjs'.diagnostic()<CR>

" Git hunk
ono ih  <Cmd>Gitsigns select_hunk<CR>
Xns ih  :Gitsigns select_hunk<CR>
" }}}

" vim: foldmethod=marker:foldlevel=0
