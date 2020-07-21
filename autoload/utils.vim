" 切换侧边栏
function! utils#signColumn_toggle() abort
	if &signcolumn ==# 'yes'
		setlocal signcolumn=no
		echom 'SignColumn disabled'
	else
		setlocal signcolumn=yes
		echom 'SignColumn enabled'
	endif
endfunction

" 切换工作模式: 默认git
function utils#work_mode_toggle() abort
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

" 封装Gina
function utils#gina_wrapper(cmd) abort
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
