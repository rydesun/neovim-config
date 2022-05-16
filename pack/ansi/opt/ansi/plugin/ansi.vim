if !get(g:, 'ansi', v:false)
	finish
endif

autocmd VimEnter * call s:term_cat()
function! s:term_cat() abort
        let l:tempfile = tempname()
        exec 'write '.l:tempfile
        exec 'term cat '.l:tempfile.'; cat'
endfunction
