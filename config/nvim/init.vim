

set encoding=UTF-8
set nocompatible
set t_Co=256
set number
set ruler

call plug#begin('~/.local/share/nvim/plugged')

"Plug 'davidhalter/jedi-vim'
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"let g:deoplete#enable_at_startup = 1

" Python syntax highlighting
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
" Vertical lines at each indentation level
Plug 'Yggdroot/indentLine'
" Auto insert closing quotes and parenthesis
Plug 'jiangmiao/auto-pairs'
" File system explorer
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
map <F2> :NERDTreeToggle<CR>
" Python motion
Plug 'jeetsukumaran/vim-pythonsense'
" Status bar
Plug 'itchyny/lightline.vim'
" Identify changed lines
" [c and ]c to move between hunks
Plug 'airblade/vim-gitgutter'


Plug 'neoclide/coc.nvim', {'branch': 'release'}
nmap <leader>rn <Plug>(coc-rename)

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Plug 'preservim/nerdcommenter'
"Plug 'ryanoasis/vim-devicons'

call plug#end()

let g:coc_global_extensions = [
    \ 'coc-json',
    \ 'coc-tsserver',
    \ 'coc-python',
    \ ]

" filetype plugin on
