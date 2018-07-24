" Common settings
set tabstop=2
set expandtab
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
let g:airline_powerline_fonts = 1
" Disabling restoring help windows
set sessionoptions-=help
" Disabling session save/restore propmting
let g:session_autoload='yes'
let g:session_autosave='yes'
" Make splitting more natural
set splitbelow
set splitright
" Adding node_modules to ignore list
set wildignore+=*/node_modules/*
" Disabling annoing bell
set visualbell t_vb=
set noerrorbells

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
set guifont=Fira\ Mono\ for\ Powerline\ Medium\ 12

" Keybindings
nnoremap ZA          :qa!<CR>                           " Close all
noremap  <C-n>       :NERDTreeToggle<CR>                " Toggle NerdTree
nnoremap <C-S-tab>   :tabnext<CR>                       " Prev tab
nnoremap <C-tab>     :tabprevious<CR>                   " Next tab
nnoremap <C-s>			 :wa<CR>							              " Save all tabs
nnoremap <C-S-s>		 :w<CR>								              " Save current file
nnoremap tc					 :tabc<CR>						              " Close current tab
nnoremap <leader>gt  :YcmCompleter GetType<CR>          " Get type of entity
nnoremap <leader>gd  :YcmCompleter GetDoc<CR>           " Get documentation
nnoremap <leader>go  :YcmCompleter GoTo<CR>             " Go to
nnoremap <leader>gf  :YcmCompleter GoToDefinition<CR>   " Go to entity definition
nnoremap <leader>gr  :YcmCompleter GoToReferences<CR>   " Go to entity reference

" Plugins
call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'groenewege/vim-less'
Plug 'leafgarland/typescript-vim'
Plug 'powerman/vim-plugin-ruscmd'
Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'valloric/youcompleteme'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
Plug 'Xuyuanp/nerdtree-git-plugin'

call plug#end()
