function! coc#source#id_pub#init() abort
	return {
		\ 'shortcut': 'public ID',
		\ 'priority': 9,
	\ }
endfunction

function! coc#source#id_pub#complete(opt, cb) abort
	let items = ['rydesun', 'rydesun@gmail.com']
	call a:cb(items)
endfunction
