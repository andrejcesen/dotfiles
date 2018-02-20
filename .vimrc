" vim:fdm=marker

" Settings -------------------------------------------------------------

" Preamble {{{

" Make vim more useful {{{
set nocompatible
" }}}

" Syntax highlighting {{{
syntax enable
set t_Co=16
set background=dark
colorscheme solarized
let g:solarized_termtrans=1
" }}}

" Local directories {{{
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
  set undodir=~/.vim/undo
endif
" }}}


" Set some junk {{{
set autoindent " Copy indent from last line when starting new line
set clipboard=unnamed " Use the OS clipboard by default (on versions compiled with `+clipboard`)
set diffopt=filler " Add vertical spaces to keep right and left aligned
set diffopt+=iwhite " Ignore whitespace changes (focus on code changes)
set encoding=utf-8 nobomb " BOM often causes trouble
set expandtab " Expand tabs to spaces
set ignorecase " Ignore case of searches
set lazyredraw " Don't redraw when we don't have to
set noerrorbells " Disable error bells
set shiftwidth=2 " The # of spaces for indenting
set softtabstop=2 " Tab key results in 2 spaces
set title " Show the filename in the window titlebar
set ttyfast " Send more characters at a given time
set ttymouse=xterm " Set mouse type to xterm
set wildmenu " Hitting TAB in command mode will show possible completions above command line
" }}}
