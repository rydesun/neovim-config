if exists('b:current_syntax')
  finish
endif

syn match       goIfErrNotNil       "\s*if err != nil "
syn match       goBracket           "("
syn match       goBracket           ")"
syn match       goBracket           "{"
syn match       goBracket           "}"

hi def link     goIfErrNotNil       Folded
hi def          goBracket           guifg=#999999
