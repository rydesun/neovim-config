set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set ignorecase smartcase
set scrolloff=5
set hidden

let mapleader=" " | noremap <space> <nop>
let maplocalleader="-" | noremap - <nop>
noremap  <C-a>  ^
inoremap <C-a>  <Esc>^i
noremap  <C-e>  <End>
inoremap <C-e>  <End>
noremap  ;  :
noremap  :  ;
noremap  <silent>p  p`]
vnoremap <silent>y  y`]
noremap  H  :bp<CR>
noremap  L  :bn<CR>

cnoremap <C-p>  <Up>
cnoremap <C-n>  <Down>
cnoremap <expr>%%  expand('%:h').'/'
cabbrev  ww  w !sudo tee % >/dev/null


cabbrev i2  setl sw=2 ts=8 noet
cabbrev i4  setl sw=4 ts=4 et
cabbrev i8  setl sw=8 ts=8 noet
autocmd FileType c,cpp,yaml setl sw=4 ts=4 et
autocmd FileType javascript,xml,html,css setl sw=2


let g:markdown_fenced_languages = ['c', 'cpp', 'python', 'bash=sh']


call plug#begin('~/.local/share/nvim/plugged')
" Appearance {{{1
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'Yggdroot/indentLine'
Plug 'luochen1990/rainbow'
" }}}

" Operation {{{1
Plug 'Shougo/denite.nvim', {'do': ':UpdateRemotePlugins'}
Plug 'terryma/vim-multiple-cursors'
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'junegunn/vim-easy-align'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
" }}}

" Programming {{{1
Plug 'w0rp/ale'
Plug 'roxma/nvim-completion-manager'
Plug 'roxma/clang_complete'
Plug 'davidhalter/jedi-vim'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdcommenter'
Plug 'majutsushi/tagbar'
" }}}

" Git {{{1
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" }}}

" Other {{{1
Plug 'tpope/vim-repeat'
Plug 'lilydjwg/fcitx.vim'
" }}}
call plug#end()

" Gruvbox theme {{{1
set background=dark
let g:gruvbox_invert_selection=0
colorscheme gruvbox
highlight Normal guibg=#160a04
highlight Folded guibg=#1a2422
highlight SignColumn guibg=#1a2422
" }}}

" Appearance tweak {{{1
set termguicolors
set fillchars=vert:│
set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20
highlight VertSplit ctermbg=None guibg=None
noremap <F1> :TagbarToggle<CR>
" }}}

" Airline {{{1
let g:airline_powerline_fonts = 1
let g:airline_skip_empty_sections = 1

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#show_tab_type = 0
for i in [1,2,3,4,5,6,7,8,9]
    execute "nmap <leader>" . i . " <Plug>AirlineSelectTab" . i
endfor

let g:airline_symbols = {'linenr': '', 'whitespace': '', 'maxlinenr': 'L'}
let g:airline_mode_map = {'n': 'N', 'i': 'I', 'R': 'R', 'c': 'C', 'v': 'V', 's': 'S'}
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline#extensions#tagbar#flags = 'f'
" }}}

" Rainbow parentheses {{{1
let g:rainbow_active = 1
" }}}

" Denite {{{1
call denite#custom#var('file_rec', 'command',
  \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'default_opts', ['-i', '--vimgrep'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])
" }}}

" Easymotion {{{1
let g:EasyMotion_keys = 'asdghklqweruiopvnfj;'
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_us = 1
let g:EasyMotion_do_shade = 0
map  f <plug>(easymotion-bd-f)
nmap f <plug>(easymotion-overwin-f)
" }}}

" Incsearch {{{1
nnoremap <esc><esc> :nohlsearch<CR>
map / <plug>(incsearch-forward)
map ? <plug>(incsearch-backward)
" }}}

" Vim-easy-align {{{1
xmap <leader>a <Plug>(EasyAlign)
nmap <leader>a <Plug>(EasyAlign)
" }}}

" Jedi-vim {{{1
let g:jedi#completions_enabled = 0
let g:jedi#goto_command = "<leader>j"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = ""
let g:jedi#usages_command = ""
let g:jedi#completions_command = ""
let g:jedi#rename_command = "<leader>r"
" }}}

" Ultisnips {{{1
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsRemoveSelectModeMappings = 0
" }}}

" nerdcommenter {{{1
map <leader>cc <plug>NERDCommenterToggle
map <leader>c<space> <plug>NERDCommenterComment
" }}}


" vim: foldmethod=marker
