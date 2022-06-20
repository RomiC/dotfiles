source $HOME/.config/nvim/plugins.vim

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

" Coc settings
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

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

" Disable Netrw Banner (annoying semi-file-manager on start)
let g:netrw_banner = 0

" NERDTree settings
" - Keybindings
let NERDTreeMapActivateNode='l'
let NERDTreeMapPreview='p'
let NERDTreeJumpRoot='H'
let NERDTreeJumpParent='h'

" Prettier settings
autocmd FileType css,scss let b:prettier_exec_cmd = "prettier-stylelint"

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

" GUI settings
" - Font
set guifont=MonoLisa:h13

" Setup russing keylayout
" set keymap=russian-jcukenmac

" Terminal
autocmd BufEnter term://* startinsert

" Enabling code-completion
" Use deoplete.
let g:deoplete#enable_at_startup = 1

" Ale settings
" Use quickfix instead of loc-list
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
" Do not lint or fix minified files.
let g:ale_pattern_options = {
\ '\.min\.js$': {'ale_linters': [], 'ale_fixers': []},
\ '\.min\.css$': {'ale_linters': [], 'ale_fixers': []},
\}
" If you configure g:ale_pattern_options outside of vimrc, you need this.
let g:ale_pattern_options_enabled = 1

" Keybindings
source $HOME/.config/nvim/keybindings.vim

if !exists('g:vscode')
" - File explorer (NERDTree)
  " - Open/close file explorer
  nnoremap  <silent>  ge  :Vifm<CR>
endif
" - Completion
" - Searching
  " - Search project
nnoremap  <silent>  <leader>f  :Rg<CR>
" - Code editing
  " - Symbol renaming
" nnoremap  <silent>  <leader>rn <Plug>(coc-rename)
  " - Indent + 
nnoremap  <silent>  <Tab>  >> 
vnoremap  <silent>  <Tab>  >gv
  " - Indent - 
nnoremap  <silent>  <S-Tab>  << 
vnoremap  <silent>  <S-Tab>  <gv
  " - Formatting
" vmap  <silent>  ==  <Plug>(coc-format-selected)
" nmap  <silent>  ==  <Plug>(coc-format-selected)
  " - Multi-cursor
let g:VM_leader = '<leader><leader>'
let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<C-n>'
let g:VM_maps['Find Subword Under'] = '<C-n>'
let g:VM_maps['Undo'] = 'u'
let g:VM_maps['Redo'] = '<C-r>'
" - Switching layout
inoremap  <silent>  <C-space>  <C-^>
" - Terminal
if !exists('g:vscode')
  " - Open terminal in a new pane from the right
  nnoremap  <silent>  gs  :80vsplit term://zsh<CR>
  " - Open terminal in a new pane below
  nnoremap  <silent>  gS  :25split term://zsh<CR>
endif
" - Buffers
"   - Recent
nnoremap  <leader>p  :Buffers<CR>
" - Miscellaneous
  " - Reload config
nnoremap  <leader>u  :so $MYVIMRC<CR>
" - Unmapping
  " - Annoying <F1> help
nnoremap  <F1>  <nop>
  " - Disable recording
nnoremap  q  <nop>
" - FZF
  " - Opening Files
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-_': 'split',
  \ 'ctrl-]': 'vsplit' }

if exists('veonim')
  source $HOME/.config/nvim/veonim.vim
endif

if exists('g:vscode')
  source $HOME/.config/nvim/vscode.vim
endif

"lua << EOF 
"require'lspconfig'.tsserver.setup{}
"require'lspconfig'.cssls.setup{}
"EOF 
