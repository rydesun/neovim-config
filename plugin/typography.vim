if exists("loaded_typography")
	finish
endif
let loaded_typography = 1

" TODO: incomplete Unified_Ideograph
let s:hans_regexp = '[\u3400-\u4DB5\u4E00-\u9FEA\uFA0E\uFA0F\uFA11\uFA13\uFA14\uFA1F\uFA21\uFA23\uFA24\uFA27-\uFA29]'
let s:alnum_regexp = '[a-zA-Z0-9]'

" 中英文间增加空格
function! Typography()
	exec 'silent! %s/\('.s:hans_regexp.'\)\('.s:alnum_regexp.'\)/\1 \2/g'
	exec 'silent! %s/\('.s:alnum_regexp.'\)\('.s:hans_regexp.'\)/\1 \2/g'
endfunction

function! TypographyHugo()
	call Typography()
	" 修复因为Hugo插件joinLines而去掉的空格
	exec 'silent! %s/\(^[^#].*'.s:alnum_regexp.'\)\(\n\)\('.s:hans_regexp.'\)/\1\2 \3/g'
	exec 'silent! %s/\(^[^#].*'.s:hans_regexp.'\)\(\n\)\('.s:alnum_regexp.'\)/\1\2 \3/g'
endfunction
