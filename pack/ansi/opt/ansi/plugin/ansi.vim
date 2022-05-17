if get(g:, 'ansi', v:false)
	augroup ansi
		autocmd!
		autocmd VimEnter * call ansi#term_cat()
	augroup END
endif
