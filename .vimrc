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
autocmd InsertEnter,InsertLeave * set cul!
syntax on
colorscheme afterglow
au VimEnter * if &diff | execute 'windo set wrap' | endif

nmap ZA :qa!<CR>
