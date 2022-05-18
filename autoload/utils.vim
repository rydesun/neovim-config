" 检查vim-plug加载插件的情况
function! utils#is_loaded(plug) abort
	return exists('g:plugs')
		\ && has_key(g:plugs, a:plug)
		\ && isdirectory(g:plugs[a:plug].dir)
endfunction

" 终端中的git命令
function! utils#term_git(cmd, cur) abort
	let l:cmd = "edit term://".expand('%:p:h')."//git -c delta.paging=never ".a:cmd
	if a:cur
		let l:cmd = cmd." ".expand('%:p:t')
	endif
	exec l:cmd
	nnoremap <buffer><silent> q :bd!<CR>
endfunction
