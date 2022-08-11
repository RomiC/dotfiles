" Fixing indent
set shiftwidth=2
set tabstop=2 softtabstop=2
set smartindent
set autoindent
set expandtab
set nosmarttab

set noswapfile              " Don't use swap files 
set autoread                " Automatically refresh file on change
set relativenumber          " Relative line numbers
au TermOpen * set norelativenumber  " Hide line number in terminal mode

set mouse=a                 " Enable mouse
set clipboard+=unnamedplus  " Integrate with system clipboard

set noshowcmd

" True Colors support
if (has("termguicolors"))
  set termguicolors
endif

" Colorscheme
set background=dark
colorscheme afterglow
highlight User1 cterm=reverse ctermfg=150 ctermbg=59 gui=reverse guifg=#afd787 guibg=#4d5057
highlight User2 ctermfg=9 ctermbg=59 gui=bold guifg=#ff0000 guibg=#4d5057

" Statusline
let g:currentmode={
       \ 'n'  : 'N ',
       \ 'v'  : 'V ',
       \ 'V'  : 'V·Line ',
       \ '' : 'V·Block ',
       \ 'i'  : 'I ',
       \ 'r'  : 'R ',
       \ 'Rv' : 'V·Replace ',
       \ 'c'  : 'C ',
       \ 't'  : 'T ',
       \}

" Change bg color of the current mode block based on the mode name
" - Red for insert mode
au InsertEnter * highlight User1 guifg=#a54242 guibg=#f9e7c4
au InsertLeave * highlight User1 guifg=#afd787 guibg=#4d5057

set laststatus=2
set statusline=
set statusline+=%1*
set statusline+=\ %{toupper(g:currentmode[mode()])}
set statusline+=%*
set statusline+=\ %w
set statusline+=\ %f
set statusline+=%2*
set statusline+=\%{&modified?'\ *':''}
set statusline+=%*
set statusline+=%= " Right side
set statusline+=\ %l:%c/%L
set statusline+=\ %y\ 

" Cursor based on current mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" Searching
set ignorecase
set smartcase

" Window splitting
set splitbelow
set splitright

" Don't close buffers
set hidden

" Folding settings
set foldmethod=indent
set nofoldenable

" Switch keyboard layout to US on leaving insert mode
function SetUsLayout()
  silent !im-select com.apple.keylayout.US
endfunction
autocmd InsertLeave * call SetUsLayout()

" Terminal
autocmd BufEnter term://* startinsert

" Disabling default file manager
let loaded_netrwPlugin = 1
