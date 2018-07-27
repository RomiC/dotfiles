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
setlocal foldmethod=syntax
set clipboard=unnamed,unnamedplus
set fencs=utf-8,cp1251,koi8-r,ucs-2,cp866
if has("mouse")
  set mouse=a
endif
set number
set completeopt=menuone,noinsert
" Turn on soft wrappers in diff mode
au VimEnter * if &diff | execute 'windo set wrap' | endif
syntax on
" Make splitting more natural
set splitbelow
set splitright
" Adding node_modules to ignore list
set wildignore+=*/node_modules/*
" Disabling annoing bell
set visualbell t_vb=
set noerrorbells
" set filetypes as typescript.jsx
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.jsx
autocmd BufNewFile,BufRead *.ts,*.js set filetype=typescript.jsx
" Set jsx-file colors
hi xmlEndTag guifg=#e8bf6a

" Colorscheme
try
  colorscheme afterglow
catch /^Vim\%((\a\+)\)\=:E185/
  " using default theme
endtry

" GVIM options
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
set guifont=Fira\ Mono\ for\ Powerline\ Medium\ 11
set guicursor+=a:blinkon0

" Keybindings
nnoremap <silent> ZA          :qa!<CR>                           " Close all
nnoremap <silent> <C-S-e>     :NERDTreeToggle<CR>                " Toggle NerdTree
nnoremap <silent> <C-S-tab>   :tabprevious<CR>                   " Prev tab
nnoremap <silent> <C-tab>     :tabnext<CR>                       " Next tab
nnoremap <silent> <C-s>			  :wa<CR>							               " Save all tabs
nnoremap <silent> <C-S-s>		  :w<CR>								             " Save current file
nnoremap <silent> tc					:tabc<CR>						               " Close current tab
nnoremap <silent> <leader>gt  :YcmCompleter GetType<CR>          " Get type of entity
nnoremap <silent> <leader>gd  :YcmCompleter GetDoc<CR>           " Get documentation
nnoremap <silent> <leader>go  :YcmCompleter GoTo<CR>             " Go to
nnoremap <silent> <leader>gf  :YcmCompleter GoToDefinition<CR>   " Go to entity definition
nnoremap <silent> <leader>gr  :YcmCompleter GoToReferences<CR>   " Go to entity reference
nnoremap <silent> <A-k>       :wincmd k<CR>                      " Go to window above
nnoremap <silent> <A-j>       :wincmd j<CR>                      " Go to window below
nnoremap <silent> <A-h>       :wincmd h<CR>                      " Go to window from left
nnoremap <silent> <A-l>       :wincmd l<CR>                      " Go to window from right

" Plugins
call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'groenewege/vim-less'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'pangloss/vim-javascript'
Plug 'phanviet/vim-monokai-pro'
Plug 'powerman/vim-plugin-ruscmd'
Plug 'scrooloose/nerdtree'
Plug 'sgur/vim-editorconfig'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'valloric/youcompleteme'
Plug 'w0rp/ale'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
Plug 'Xuyuanp/nerdtree-git-plugin'
call plug#end()

" Plugins specific options
" Airline
let g:airline_section_x=''
let g:airline_theme='dark_minimal'
let g:airline#extensions#tabline#enabled=1                " Enable tabs
let g:airline#extensions#tabline#formatter='unique_tail'  " Show only uniq parts of the titles in tabs
let g:airline#extensions#ale#enabled=1                    " Enable ALE plugin extension to show linting messages
let g:airline_powerline_fonts=1                           " Use powerline fonts
let g:airline_skip_empty_sections=1                       " Don't render empty sections
" Multiple cursor
let g:multi_cursor_exit_from_insert_mode=0 " Don't loose the selected after exit from insert mode
" Sessions
set sessionoptions-=help      " Disabling restoring help windows
let g:session_autoload='yes'  " Disabling session restore propmt
let g:session_autosave='yes'  " Disable session save prompt
