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
function! utils#toggle_workmode() abort
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
function! utils#git_wrapper(cmd) abort
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
        if exists('b:rootpath') && 'b:rootpath'
                return b:rootpath
        endif

	let l:dir = expand('%:p:h')
	let l:res = rooter#match_all(l:dir, a:patterns)
	if !empty(l:res)
		let b:rootpath = l:res
		return b:rootpath
	endif

	let b:rootpath = l:dir
	return b:rootpath
endfunction
function! utils#rootpath_clear() abort
	let b:rootpath = ''
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

function! utils#popup_open(message, max) abort
        call s:popup_close()

        let l:raw_width = len(a:message)
        if l:raw_width == 0
                return
        endif

        let width = min([l:raw_width, a:max])

        let buf = nvim_create_buf(v:false, v:true)
        call nvim_buf_set_option(buf, 'filetype', 'popup')
        call nvim_buf_set_lines(buf, 0, 0, v:false, [a:message])

        let ui = nvim_list_uis()[0]
        let opts = {'relative': 'editor',
                \ 'width': width,
                \ 'height': 1,
                \ 'col': ui.width - width,
                \ 'row': 0,
                \ 'anchor': 'NW',
                \ 'style': 'minimal',
                \ }
        let s:win = nvim_open_win(buf, 0, opts)
        call nvim_win_set_option(s:win, 'winhl', 'Normal:InfoFloat')
endfunction

function! s:popup_close() abort
	if !exists('s:win')
		return
	endif
        try
                call nvim_win_close(s:win, 0)
        catch
        endtry
endfunction
