" Plugins
call plug#begin(stdpath('data') . '/plugged')

" Interface
Plug 'danilo-augusto/vim-afterglow'

" File browser + plugins
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" Searching
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'


" Nunjucks support
Plug 'lepture/vim-jinja'

" Code plugins
" - Completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" - Linting
Plug 'dense-analysis/ale'
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
