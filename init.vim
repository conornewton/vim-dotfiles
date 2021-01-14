call plug#begin('~/.vim/plugged')
"Colors and stuff
Plug 'NLKNguyen/papercolor-theme'
Plug 'sjl/badwolf'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'sheerun/vim-polyglot'

"Misc Plugins
Plug 'skywind3000/asyncrun.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mk12/vim-lean'
Plug 'honza/vim-snippets'

"Better Concealing for latex
Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}
Plug 'matze/vim-tex-fold', {'for': 'tex'}

"Pandoc Markdown
Plug 'vim-pandoc/vim-pandoc'
Plug 'conornewton/vim-pandoc-markdown-preview'

"R Markdown Syntax
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-pandoc/vim-rmarkdown'

"LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

set nocompatible " fuck off vi

set background=light
colorscheme badwolf
let g:airline_theme = 'badwolf'

filetype plugin on
syntax on

set number                  "show line number
set relativenumber
set encoding=UTF-8

"shows trailing spaces as dots
set list

set tabstop=4               "tab stuff
set shiftwidth=4
set expandtab
set softtabstop=4

set nohlsearch

"escape insert mode
inoremap jj <ESC>

let g:latex_engine = "xelatex"

let g:md_pdf_viewer = "mupdf"
let g:md_args = "--template eisvogel.tex"
let g:latex_pdf_viewer = "mupdf"

autocmd FileType make setlocal noexpandtab
autocmd FileType tex,rmarkdown,markdown setlocal spell

"tab cycles through coc suggestions
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

"snippets
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

"faster updating for coc.nvim
set updatetime=300
set signcolumn=yes

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

set conceallevel=2
let g:tex_conceal="abdgm"

nnoremap <C-b> :Buffers<CR>
nnoremap <C-f> :Files<CR>

"Open fzf in a popup window
let g:fzf_layout = { 'window': { 'width': 0.7, 'height': 0.6 } }

"Compile commands
autocmd FileType r nmap <F2> :! Rscript %<CR>
autocmd BufWritePost *.Rmd :AsyncRun Rscript -e 'library(rmarkdown);render("%", "pdf_document")'
"autocmd FileType r :command Rtest !Rscript -e 'devtools::test()'

let g:python3_host_prog = '/usr/bin/python3'
