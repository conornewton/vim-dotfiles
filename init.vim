" Local vim settings for projects
set exrc

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
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'honza/vim-snippets'
Plug 'mbbill/undotree'

"Better Concealing for latex
Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}
Plug 'matze/vim-tex-fold', {'for': 'tex'}

"Pandoc Markdown
Plug 'vim-pandoc/vim-pandoc'
Plug 'conornewton/vim-pandoc-markdown-preview'

"R Markdown Syntax
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-pandoc/vim-rmarkdown'

"
Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}

"LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Linting
Plug 'dense-analysis/ale'
" Plug 'neovim/nvim-lspconfig'

"Writing plugins
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
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

set guicursor=

set tabstop=4               "tab stuff
set shiftwidth=4
set expandtab
set softtabstop=4

set incsearch
set nohlsearch

set nobackup
set undodir=~/.vim/undodir
set undofile

let mapleader=" "

nnoremap <leader>b :Buffers<CR>
nnoremap <leader>f :GFiles<CR>
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>v :vsplit<CR>
nnoremap <leader>c :split<CR>
nnoremap <leader>so :so %<CR>

"TODO: tidy up filepaths
if has("win32") 
    nnoremap <leader>ef :e C:/Users/Conor/AppData/Local/nvim/ftplugin/<C-R>=&filetype<CR>.vim<CR>
    nnoremap <leader>sp :e C:/Users/Conor/AppData/Local/nvim/ultisnips/<C-R>=&filetype<CR>.snippets<CR>
else
    nnoremap <leader>ef :e ~/.config/nvim/ftplugin/<C-R>=&filetype<CR>.vim<CR>
    nnoremap <leader>sp :e ~/.config/nvim/ultisnips/<C-R>=&filetype<CR>.snippets<CR>
endif

let g:latex_pdf_viewer = "mupdf"
let g:latex_engine = "xelatex"
let g:md_pdf_viewer = "evince"
let g:md_args = "--template eisvogel.tex"

autocmd! FileType make setlocal noexpandtab
autocmd! FileType tex,rmarkdown,markdown setlocal spell

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
nmap <leader> gd <Plug>(coc-definition)
nmap <leader> gy <Plug>(coc-type-definition)
nmap <leader> gi <Plug>(coc-implementation)
nmap <leader> gr <Plug>(coc-references)
nmap <leader> rn <Plug>(coc-rename)

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
set updatetime=30
set signcolumn=yes

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

set conceallevel=2
let g:tex_conceal="abdgm"

let g:ale_disable_lsp = 1

"Open fzf in a popup window
let g:fzf_layout = { 'window': { 'width': 0.7, 'height': 0.6 } }

if has('win32')

else
    " let g:python3_host_prog = '/usr/bin/python3'
endif
