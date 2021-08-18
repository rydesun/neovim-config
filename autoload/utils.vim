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

" 将buffer写入临时文件
function! utils#write_buffer_tmpfile() abort
        let l:tempfile = tempname()
        exec 'write '.l:tempfile
        return l:tempfile
endfunction

" 在终端中输出文件
function! utils#term_cat(tempfile) abort
        exec 'term cat '.a:tempfile.'; cat'
endfunction

" 终端pager
function! utils#term_paging() abort
	let l:tempfile = utils#write_buffer_tmpfile()
	call utils#term_cat(l:tempfile)
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
