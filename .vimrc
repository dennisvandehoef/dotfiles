execute pathogen#infect()

"  ---------------------------------------------------------------------------
"  General
"  ---------------------------------------------------------------------------

set autoread
syntax enable
set nobackup
set noswapfile
set noswapfile
set nofoldenable
set showmatch

"  ---------------------------------------------------------------------------
"  UI
"  ---------------------------------------------------------------------------


set number
set showtabline=2
set title
set encoding=utf-8
set autoindent
set smartindent
set showmode
set showcmd
set hidden
color ir_black


"  ---------------------------------------------------------------------------
"  Text Formatting
"  ---------------------------------------------------------------------------
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

set nowrap
set textwidth=100
set formatoptions=n

" check to make sure vim has been compiled with colorcolumn support
" before enabling it
if exists("+colorcolumn")
  set colorcolumn=80
endif


"  ---------------------------------------------------------------------------
"  Mappings
"  ---------------------------------------------------------------------------
" Turn off arrow keys (this might not be a good idea for beginners, but it is
" the best way to ween yourself of arrow keys on to hjkl)
" http://yehudakatz.com/2010/07/29/everyone-who-tried-to-convince-me-to-use-vim-was-wrong/

nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" NERDTree
nmap <C-d> :NERDTree<CR>


"  ---------------------------------------------------------------------------
"  Plugins
"  ---------------------------------------------------------------------------

" eradicate all trailing whitespace all the time
let g:DeleteTrailingWhitespace = 1
let g:DeleteTrailingWhitespace_Action = 'delete'

" AutoClose
let g:AutoClosePairs = {'(': ')', '{': '}', '[': ']', '"': '"', "'": "'", '#{': '}'}
let g:AutoCloseProtectedRegions = ["Character"]
