if exists("b:current_syntax")
    finish
endif

runtime! syntax/conf.vim

let b:current_syntax = 'gitignore'

setlocal commentstring=#\ %s
