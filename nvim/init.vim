call plug#begin('~/.config/nvim-plugged')
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'neovim/nvim-lspconfig'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' } 
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
set relativenumber " relative number in addition to line number
set wildmode=longest,list
filetype plugin indent on
syntax on
set mouse=a
set clipboard=unnamedplus
filetype plugin on
set ttyfast
nnoremap <C-t> :NERDTreeFocus<CR> " ctrl-t -> go to nerdtree



" get rid of annoying trailing whitespace warning lol
let g:airline#extensions#whitespace#enabled = 0


" NERDTree config
"
" Start NERDTree and move the cursor to the original window.
autocmd VimEnter * NERDTree | wincmd p

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Exit Vim if the empty buffer is the only window remaining in the only tab
" after exiting another buffer (does not work lol)
" autocmd BufLeave * if tabpagenr('$') == 1 && winnr('$') == 2 && getbufline('%', 1, '$') == [''] | quit | endif

" no cursor underline
let g:NERDTreeHighlightCursorline = 0

" close after opening a file
" let g:NERDTreeQuitOnOpen = 1

" hide help text
let g:NERDTreeMinimalUI = 1

" let g:NERDTreeGitStatusWithFlags = 1

" show hidden files, except .DS_Store and .git/
let g:NERDTreeShowHidden = 1
let g:NERDTreeIgnore = ['\.DS_Store$', '\.git$']

let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:NERDTreeWinSize=25


" language server protocol config
" 
lua require('lsp_config')
lua require('treesitter')


" catppuccin theme config
"
lua require('catppuccin_theme')
let g:airline_theme='catppuccin'

