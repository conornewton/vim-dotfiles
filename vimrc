set nocompatible " fuck off vi

colorscheme badwolf
let g:airline_theme = 'badwolf'

call plug#begin('~/.vim/plugged')
Plug 'leanprover/lean.vim'
Plug 'scrooloose/nerdtree'
Plug 'skywind3000/asyncrun.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim'
Plug 'jiangmiao/auto-pairs'
Plug 'conornewton/vim-pandoc-markdown-preview'
Plug 'conornewton/vim-latex-preview'
call plug#end()


filetype plugin on
filetype on
syntax on

set number                  "show line number
set encoding=UTF-8

"shows trailing spaces as dots
set list
set listchars=tab:≫\ ,trail:·

set tabstop=4               "tab stuff
set shiftwidth=4
set expandtab
set softtabstop=4

"escape insert mode
inoremap jj <ESC>
inoremap zz :w<CR>

"use natural keys for movement
noremap ; l
noremap l k
noremap k j
noremap j h

let g:latex_engine = "xelatex"

let g:md_pdf_viewer = "mupdf"
let g:md_args = "--template eisvogel.tex"
let g:latex_pdf_viewer = "mupdf"

"set .tex files filetype to tex
"Not detected sometimes

noremap J :tabp<CR>
noremap K :tabn<CR>

nnoremap <F8> :setlocal expandtab!<CR>
nnoremap <F7> :setlocal wrap!<CR>

autocmd FileType make setlocal noexpandtab
autocmd FileType latex nnoremap <F4> :StartLatexPreview<CR>

"Open nerdtree on start on the left
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p

"Open terminal at the bottom of vim
autocmd VimEnter * :below terminal ++rows=4 
autocmd VimEnter * wincmd p

"tab cycles through coc suggestions
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()


