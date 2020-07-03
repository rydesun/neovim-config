function! coc#source#id#init() abort
	return {
		\ 'shortcut': 'ID',
		\ 'priority': 9,
	\ }
endfunction

function! coc#source#id#complete(opt, cb) abort
	let items = ['rydesun', 'rydesun@gmail.com']
	call a:cb(items)
endfunction
