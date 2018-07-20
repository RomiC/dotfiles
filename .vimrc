" Common settings
set tabstop=2
set shiftwidth=2
set smarttab
set wrap
set linebreak
set nolist
set textwidth=0
set wrapmargin=0
set ai
set showmatch
set hlsearch
set incsearch
set ignorecase
set ffs=unix,dos,mac
set clipboard=unnamed,unnamedplus
set fencs=utf-8,cp1251,koi8-r,ucs-2,cp866
if has("mouse")
  set mouse=a
endif
set number

" Turn on soft wrappers in diff mode
au VimEnter * if &diff | execute 'windo set wrap' | endif
syntax on
" Enabling tabs
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

" Colorscheme
try
	colorscheme darcula
catch /^Vim\%((\a\+)\)\=:E185/
	" using default theme
endtry
" Airline theme
let g:airline_theme='wombat'


" GVIM options
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
set guifont=Fira\ Mono\ for\ Powerline\ Medium\ 11

" Keybindings
nmap ZA :qa!<CR>   " Close all
map <C-n> :NERDTreeToggle<CR>  " Toggle NerdTree
nnoremap <C-S-tab> :bprevious<CR>  " Prev tab
nnoremap <C-tab>   :bnext<CR>  " Next tab

" Plugins
call plug#begin('~/.vim/plugged')

Plug 'ctrlpvim/ctrlp.vim'
Plug 'leafgarland/typescript-vim'
Plug 'powerman/vim-plugin-ruscmd'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Xuyuanp/nerdtree-git-plugin'

call plug#end()
