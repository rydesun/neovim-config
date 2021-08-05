" 切换侧边栏
function! utils#toggle_signcolumn() abort
	if &signcolumn ==# 'yes'
		setlocal signcolumn=no
		echom 'SignColumn disabled'
	else
		setlocal signcolumn=yes
		echom 'SignColumn enabled'
	endif
endfunction

" 切换工作模式: 默认git
function utils#toggle_workmode() abort
	if !exists('b:work_mode') || b:work_mode == '' || b:work_mode == 'git'
		let b:work_mode = 'diagnostic'
		nmap <buffer><silent>  <C-k>  <Plug>(coc-diagnostic-prev)
		nmap <buffer><silent>  <C-j>  <Plug>(coc-diagnostic-next)
	else
		let b:work_mode = ''
		nunmap <buffer> <C-k>
		nunmap <buffer> <C-j>
	endif
endfunction

" 封装Git命令
function utils#git_wrapper(cmd) abort
	let l:cmd = get({
	\ 'd': 'diff',
	\ 'ds': 'diff --staged',
	\ 'show': 'show',
	\ 'c': 'commit',
	\ }, a:cmd, '')
	if l:cmd == ''
		return
	else
		execute 'Gina'.' '.l:cmd
	endif
endfunction

" 工作目录
" 依赖coc workspace
function! utils#rootpath(patterns) abort
        if exists("b:rootpath")
                return b:rootpath
        endif
	let l:dir = expand('%:p:h')
	let l:home = '/'.trim($HOME, '/')

	for l:pattern in a:patterns
		let l:res = matchstr(l:dir.'/', l:pattern)
		if !empty(l:res)
                        let b:rootpath = l:res
                        return b:rootpath
		endif
	endfor

	if !exists("g:WorkspaceFolders")
		return l:dir
	endif
	for l:workspace_folder in g:WorkspaceFolders
		" 无视coc workspace中的家目录
		if l:workspace_folder == l:home
			continue
		endif
		if stridx(l:dir, l:workspace_folder) == 0
			let b:rootpath = l:workspace_folder
			return b:rootpath
		endif
	endfor

        return l:dir
endfunction

" 浏览dash文档
function! utils#doc_dash(language, keyword) abort
	if empty(a:language)
		let l:url = 'dash://'.a:keyword
	else
		let l:url = 'dash://'.a:language.':'.a:keyword
	endif
	call netrw#BrowseX(l:url, netrw#CheckIfRemote())
endfunction

" 终端中的git命令
function! utils#term_git(cmd, cur) abort
	let l:cmd = "edit term://".expand('%:p:h')."//git -c delta.paging=never ".a:cmd
	if a:cur
		let l:cmd = cmd." ".expand('%:p:t')
	endif
	exec l:cmd
	nnoremap <buffer><silent> q :bd!<CR>
endfunction
