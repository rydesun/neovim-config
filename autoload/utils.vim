" 终端中的git命令
function! utils#term_git(cmd, cur) abort
	let l:cmd = "edit term://".expand('%:p:h')."//git -c delta.paging=never ".a:cmd
	if a:cur
		let l:cmd = cmd." ".expand('%:p:t')
	endif
	exec l:cmd
	nnoremap <buffer><silent> q :bd!<CR>
endfunction

" 弱类型转换
function! utils#bool(val) abort
	if type(a:val) == v:t_string
		if a:val ==? 'false' || a:val == '0' || a:val =~ '^ *$'
			return v:false
		else
			return v:true
		end
	elseif !empty(a:val)
		return v:true
	else
		return v:false
	endif
endfunction
