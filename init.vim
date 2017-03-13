set rtp^=/usr/share/vim/vimfiles/
set ignorecase smartcase
set scrolloff=5
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

set fillchars=vert:│

let mapleader=" "
noremap <space> <nop>
"nnoremap <expr> j (v:count==0?'gj':'j')
"nnoremap <expr> k (v:count==0?'gk':'k')
nnoremap <silent>p p`]
vnoremap <silent>p p`]
vnoremap <silent>y y`]
cnoremap ww w !sudo tee % >/dev/null
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <expr> %% getcmdtype( ) == ':' ? expand('%:h').'/' : '%%'

noremap <left> :bp<CR>
noremap <right> :bn<CR>
noremap ; :
noremap : ;
noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
noremap <c-h> <c-w>h
noremap <c-l> <c-w>l
noremap <leader>q <c-w>q
"inoremap kj <esc>
inoremap <C-a> <Home>
inoremap <C-e> <End>
tnoremap <Esc> <C-\><C-n>

let $GIT_SSL_NO_VERIFY = 'true'
call plug#begin('~/.config/nvim/plugged')
Plug 'morhetz/gruvbox'
Plug 'fcitx.vim'
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdcommenter'
Plug 'yggdroot/indentline'
Plug 'jiangmiao/auto-pairs'
Plug 'dyng/ctrlsf.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
call plug#end()
" theme appearence
set background=dark
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark="hard"
let g:gruvbox_invert_selection=0
colorscheme gruvbox
set termguicolors
highlight Normal guibg=#160a04
highlight VertSplit ctermbg=None guibg=None
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
" easymotion + incsearch
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_us = 1
map  f <plug>(easymotion-bd-f)
nmap f <plug>(easymotion-overwin-f)
map  t <plug>(easymotion-bd-t)
nmap t <plug>(easymotion-overwin-t)
let g:incsearch#auto_nohlsearch = 1
map / <plug>(incsearch-easymotion-/)
map ? <plug>(incsearch-easymotion-?)
" airline
"let g:airline#extensions#tabline#enabled = 1
let g:airline_left_sep = ''
let g:airline_right_sep = ''
if !exists('g:airline_symbols')
let g:airline_symbols = {}
endif
" nerdcommenter
" map ss <plug>NERDCommenterToggle
" ultisnips
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" YouCompleteMe
nnoremap <leader>jj :YcmCompleter GoTo<CR>
nnoremap <leader>jr :YcmCompleter GoToReferences<CR>
let g:ycm_key_list_select_completion = ['<c-n>']
let g:ycm_key_list_previous_completion = ['<c-p>']
" auto-pairs
let g:AutoPairsFlyMode = 1
" ctrlsf
nnoremap <leader>ss :CtrlSF<CR>
" ctrlp + nerdtree
let g:NERDTreeChDirMode = 2
let g:ctrlp_working_path_mode = 'rw'
noremap <F1> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
