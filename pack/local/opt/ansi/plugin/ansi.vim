function! s:term_cat() abort
        let l:tempfile = tempname()
        " 非utf-8编码的输入自动转换
        set fileencoding=utf-8
        exec 'write '.l:tempfile
        bd
        exec 'term cat '.l:tempfile.'; cat'
endfunction

augroup ansi
	autocmd!
	autocmd VimEnter * call s:term_cat()
augroup END
