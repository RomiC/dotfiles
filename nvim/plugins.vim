" Plugins
call plug#begin(stdpath('data') . '/plugged')

" Interface
Plug 'danilo-augusto/vim-afterglow'
" Plug 'cocopon/iceberg.vim'

" File browser + plugins
Plug 'vifm/vifm.vim'

"Plug 'scrooloose/nerdtree'
"Plug 'ryanoasis/vim-devicons'
"Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" Searching
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Nunjucks support
Plug 'lepture/vim-jinja'

" Code plugins
" - Treesitter (code highlight)
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" - LSP server
" Plug 'neovim/nvim-lspconfig'
" - Completion
"Plug 'nvim-lua/completion-nvim'
"Plug 'prabirshrestha/asyncomplete.vim'
"Plug 'prabirshrestha/asyncomplete-lsp.vim'
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"lug 'lighttiger2505/deoplete-vim-lsp'
" - Linting
" Plug 'dense-analysis/ale'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
" Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'}
" Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile'}
" Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
" Plug 'neoclide/coc-highlight' {'do': 'yarn install --frozen-lockfile'} " color highlighting

" - Editing
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" 
call plug#end()
