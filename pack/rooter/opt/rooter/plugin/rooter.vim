" 自动设置工作目录

augroup myconfig
	autocmd!
	let g:rootpath_patterns = [
		\ '.git', '.hg', '.svn', 'Makefile', 'package.json',
	\ ]
	autocmd VimEnter,BufReadPost,BufEnter,BufWritePost * call s:cd_root()
	function! s:cd_root() abort
		if &buftype != '' | return | endif
		let p = luaeval("require('rooter').get(_A)", g:rootpath_patterns)
		if isdirectory(p)
			try | exec 'lcd '.p | catch /E472/ | endtry
		endif
	endfunction
augroup END
