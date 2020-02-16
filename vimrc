set number
colorscheme darkblue

autocmd BufNewFile,BufRead  /tmp/mutt* set noautoindent filetype=mail wm=0 tw=78 nonumber digraph nolist
autocmd BufNewFile,BufRead ~/tmp/mutt* set noautoindent filetype=mail wm=0 tw=78 nonumber digraph nolist

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'terryma/vim-multiple-cursors'

" Initialize plugin system
call plug#end()

set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

