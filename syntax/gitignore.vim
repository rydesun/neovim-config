" URL: https://github.com/gisphm/vim-gitignore

if exists("b:current_syntax")
    finish
endif

syn keyword     gitignoreTodo       contained TODO FIXME XXX
syn match       gitignoreComment    "^#.*" contains=gitignoreTodo
syn match       gitignoreDirectory  "^\(#\)\@!.*\/$"
syn match       gitignoreFile       "^\(#\)\@!.*\(/\)\@<!$"

hi def link     gitignoreTodo       Todo
hi def link     gitignoreComment    Comment
hi def link     gitignoreDirectory  Constant
hi def link     gitignoreFile       Type

let b:current_syntax = 'gitignore'

setlocal commentstring=#\ %s
