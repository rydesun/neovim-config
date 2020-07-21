if exists("loaded_typography")
	finish
endif
let loaded_typography = 1

command! -nargs=0 Typography call typography#format()
command! -nargs=0 TypographyHugo call typography#format_hugo()
