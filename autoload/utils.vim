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
function! utils#rootpath(patterns) abort
        if exists("b:rootpath")
                return b:rootpath
        endif
	for l:pattern in a:patterns
		let l:res = matchstr(expand('%:p:h').'/', l:pattern)
		if !empty(l:res)
                        let b:rootpath = l:res
                        return b:rootpath
		endif
	endfor
        let b:rootpath = ''
        return b:rootpath
endfunction

" 依赖vim-clap产生的工作目录
function! utils#clap_rootpath(patterns) abort
	let l:rootpath = utils#rootpath(a:patterns)
	if empty(l:rootpath)
		let l:nr = bufnr('%')
		let l:rootpath = clap#path#find_project_root(l:nr)
	endif
	return l:rootpath
endfunction

" 依赖vim-clap
function! utils#buflen() abort
	return len(clap#util#buflisted(v:false))
endfunction
