function! s:detect_gohtmltmpl() abort
	for lnum in range(1, min([line("$"), 50]))
		" 不准确
		if getline(lnum) =~# '{{.*}}'
			set filetype=gohtmltmpl
			return
		endif
	endfor
	set filetype=html
endfunction
autocmd BufRead,BufWritePost *.html call s:detect_gohtmltmpl()
