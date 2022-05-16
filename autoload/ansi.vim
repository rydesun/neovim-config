function! ansi#term_cat() abort
        let l:tempfile = tempname()
        exec 'write '.l:tempfile
        exec 'term cat '.l:tempfile.'; cat'
endfunction
