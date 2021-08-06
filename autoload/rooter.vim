function! rooter#match_all(dir, patterns) abort
	for l:pattern in a:patterns
		let l:res = rooter#match(a:dir, l:pattern)
		if !empty(l:res)
                        return l:res
		endif
	endfor
endfunction

function rooter#match(dir, pattern) abort
	let l:dir = a:dir
	while 1
		if rooter#has(l:dir, a:pattern)
			return l:dir
		endif
		let [current, l:dir] = [l:dir, s:parent(l:dir)]
		if current == l:dir | return | endif
	endwhile
endfunction

function rooter#has(dir, pattern) abort
	return !empty(globpath(escape(a:dir, '?*[]'), a:pattern, 1))
endfunction

function s:parent(path) abort
	return fnamemodify(a:path, ':h')
endfunction
