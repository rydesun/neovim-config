function! Foldtext() abort
	let l:start = getline(v:foldstart)
	let l:cnt = v:foldend - v:foldstart - 1
	if &foldmethod == 'marker'
		let l:comment = substitute(&commentstring, '%s', '', '')
		let l:marker = &foldmarker[:stridx(&foldmarker, ',')-1]
		let l:text = substitute(l:start, l:marker, '', '')
		let l:text = substitute(l:text, l:comment, '', '')
		let l:text = trim(l:text)
		return '＋❰'.printf('%3d', l:cnt).'❱ '.l:text
	else
		let l:end = trim(getline(v:foldend))
		" TODO: 应该根据闭合状态判断
		if l:end =~ '^\s*[_a-zA-Z0-9]'
			let l:cnt += 1
			return l:start.' ❰'.l:cnt.'❱'
		endif
		if l:cnt == 0
			return l:start.' '.l:end
		else
			return l:start.' ❰'.l:cnt.'❱ '.l:end
		end
	endif
endfunction
set foldtext=Foldtext()
