syn match       gitignoreDirectory  "^\(#\)\@!.*\/$"
syn match       gitignoreFile       "^\(#\)\@!.*\(/\)\@<!$"

hi def link     gitignoreDirectory  Constant
hi def link     gitignoreFile       Type
