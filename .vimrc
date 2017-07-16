set shiftwidth=2    " Indent width (when using 'v >>')
set softtabstop=2   " Number of columns for TAB
set expandtab       " Expand TABs to spaces

" Use the Solarized Dark theme
syntax enable
set background=dark
colorscheme solarized
let g:solarized_termtrans=1

" Make Vim more useful
set nocompatible
" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed
" Enhance command-line completion
set wildmenu
" Optimize for fast terminal connections
set ttyfast
" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
  set undodir=~/.vim/undo
endif

" Disable error bells
set noerrorbells
