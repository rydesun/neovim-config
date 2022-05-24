function! Foldtext() abort
	return luaeval('require("foldtext")()')
endfunction
set foldtext=Foldtext()
