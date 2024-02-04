call plug#begin('~/.config/nvim/plugged')
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
call plug#end()

set nocompatible
set showmatch
set ignorecase
set mouse=v
set hlsearch
set incsearch
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set autoindent
set number
set wildmode=longest,list
filetype plugin indent on
syntax on
set mouse=a
set clipboard=unnamedplus
filetype plugin on
set ttyfast
nnoremap <C-t> :NERDTreeToggle<CR> " ctrl-t -> toggle nerdtree

" airline_theme config
"
let g:airline_theme='bubblegum'

" get rid of annoying trailing whitespace warning lol
let g:airline#extensions#whitespace#enabled = 0


" NERDTree config
"
" Start NERDTree. If a file is specified, move the cursor to its window.
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" no cursor underline
let g:NERDTreeHighlightCursorline = 0

" close after opening a file
let g:NERDTreeQuitOnOpen = 1

" hide help text
let g:NERDTreeMinimalUI = 1

" let g:NERDTreeGitStatusWithFlags = 1

" show hidden files, except .DS_Store and .git/
let g:NERDTreeShowHidden = 1
let g:NERDTreeIgnore = ['\.DS_Store$', '\.git$']

let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:NERDTreeWinSize=25

