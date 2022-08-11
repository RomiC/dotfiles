let mapleader = " "
  " - Close all
nnoremap  <silent>  ZA  :qa!<CR>
nnoremap  <silent>  <leader>q  :qa!<CR>
  " - Save all 
nnoremap  <silent>  ZS  :wa<CR>
nnoremap  <silent>  <leader>s  :wa<CR>
inoremap  <silent>  <C-s>  <Esc>:wa<CR>
if !exists('g:vscode')
" - File explorer (NERDTree)
  " - Open/close file explorer
  nnoremap  <silent>  ge  :Vifm<CR>
endif
" - Windows navigation
. " - Split vertically
nnoremap  <silent>  <leader>]   :vsplit<CR>
  " - Focus on window above
tnoremap  <silent>  <C-w>k      <C-\><C-N><C-w>k
inoremap  <silent>  <C-w>k      <Esc><C-w>k
  " - Focus on window beloplit
nnoremap  <silent>  <leader>j   <C-w>j
tnoremap  <silent>  <C-w>j      <C-\><C-N><C-w>j
inoremap  <silent>  <C-w>j      <Esc><C-w>j
  " - Focus on window to the right
nnoremap  <silent>  <leader>l   <C-w>l
tnoremap  <silent>  <C-w>l      <C-\><C-N><C-w>l
inoremap  <silent>  <C-w>l      <Esc><C-w>l
  " - Focus on window to the left
nnoremap  <silent>  <leader>h   <C-w>h
tnoremap  <silent>  <C-w>h      <C-\><C-N><C-w>h
inoremap  <silent>  <C-w>h      <Esc><C-w>h
  " - Close current window
" - Tabs
  " - New tab
nnoremap  <silent>  <leader>n  :tabnew<CR>
  " - Next tab
nnoremap  <silent>  <leader>L  :tabn<CR>
  " - Prev tab
nnoremap  <silent>  <leader>H  :tabp<CR>
  " - Close tab
nnoremap  <silent>  <leader>W  <C-w>q!
  " - Close tab & delete buffer
nnoremap  <silent>  <leader>w  :bdelete<CR>
" - Quickfix
  " - Next item
nnoremap  <silent>  <leader><leader>j  :cnext<CR>
  " - Prev item
nnoremap  <silent>  <leader><leader>j  :cnext<CR>
" - Buffers
  " - Open buffer
nnoremap  <silent>  <C-b>  :Buffers<CR>
tnoremap  <silent>  <C-b>  <C-\><C-N>:Buffers<CR>
nnoremap  <silent>  <leader>b  :Buffers<CR>
" - Windows
nnoremap  <silent>  <leader>r  :Windows<CR>
" - File open
nnoremap  <silent>  <C-p>  :Files<CR>
tnoremap  <silent>  <C-p>  <C-\><C-N>
nnoremap  <silent>  <leader>p  :Files<CR>
" - Completion
" - Searching
  " - Search project
nnoremap  <silent>  <leader>f  :Rg<CR>
" - Code editing
  " - Symbol renaming
" nnoremap  <silent>  <leader>rn <Plug>(coc-rename)
  " - Indent + 
nnoremap  <silent>  <Tab>  >> 
vnoremap  <silent>  <Tab>   >gv
  " - Indent - 
nnoremap  <silent>  <S-Tab>  << 
vnoremap  <silent>  <S-Tab>  <gv
  " - Commenting
map <leader>/ <plug>NERDCommenterToggle
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
  " - Open terminal in a new pane from the right
nnoremap  <silent>  gs  :80vsplit term://zsh<CR>
  " - Open terminal in a new pane below
nnoremap  <silent>  gS  :25split term://zsh<CR>
. " - Exit terminal mode
"tnoremap  <silent>  <Esc>  <C-\><C-n>
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
