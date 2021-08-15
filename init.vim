call plug#begin('~/.vim/plugged')
"Colours
Plug 'NLKNguyen/papercolor-theme'
Plug 'sjl/badwolf'
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"TPOPE
Plug 'tpope/vim-commentary' " Easy commenting
Plug 'tpope/vim-fugitive'   " Git stuff
Plug 'tpope/vim-surround'   " Surrounding stuff (maybe there is a tree sitter version)?
Plug 'tpope/vim-sleuth'     " Heuristically sets filespecific data such as indent

"Nvim LSP
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'kabouzeid/nvim-lspinstall'
Plug 'windwp/nvim-autopairs'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'rafamadriz/friendly-snippets'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'


" Lean
Plug 'andrewradev/switch.vim'  " For Lean switch support
Plug 'Julian/lean.nvim'

" Nvim file explorer
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'nvim-treesitter/playground'

" Treesitter plugins
Plug 'windwp/nvim-ts-autotag'
Plug 'JoosepAlviste/nvim-ts-context-commentstring'

"Writing plugins
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" Startup screen
Plug 'mhinz/vim-startify'

" VSCODE EXTENSIONS"
Plug 'dsznajder/vscode-es7-javascript-react-snippets'
call plug#end()

set background=dark
colorscheme gruvbox
let g:airline_theme = 'gruvbox'
let g:airline_powerline_fonts = 1

filetype plugin on
syntax on

set cursorline
set number
set relativenumber
set encoding=UTF-8

set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4
set nobackup
set signcolumn=yes

" Source lua files
luafile ~/.config/nvim/lua/lsp.lua
luafile ~/.config/nvim/lua/treesitter.lua

let mapleader=" "
nnoremap <silent><leader>h :wincmd h<CR>
nnoremap <silent><leader>j :wincmd j<CR>
nnoremap <silent><leader>k :wincmd k<CR>
nnoremap <silent><leader>l :wincmd l<CR>
nnoremap <silent><leader>v :vsplit<CR>
nnoremap <silent><leader>c :split<CR>
nnoremap <silent><leader>so :so %<CR>
nnoremap <silent><leader>n :NvimTreeToggle<CR>

if has("win32") 
    nnoremap <leader>ef :e C:/Users/Conor/AppData/Local/nvim/ftplugin/<C-R>=&filetype<CR>.vim<CR>
else
    nnoremap <leader>ef :e ~/.config/nvim/ftplugin/<C-R>=&filetype<CR>.vim<CR>
endif

autocmd! FileType make setlocal noexpandtab " Make files need proper tabs
autocmd! FileType tex,rmarkdown,markdown setlocal spell " Turn on spell checking for latex and markdown

set completeopt=menuone,noselect

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm(luaeval("require 'nvim-autopairs'.autopairs_cr()"))
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Treesitter folding
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

let g:startify_bookmarks = ['~/.config/nvim/init.vim',]

" Jump forward or backward through snippets
imap <expr> <c-j>  vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Esc>ea'
smap <expr> <c-j>  vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<c-j>'
smap <expr> <c-k>  vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<c-k>'
imap <expr> <c-k>  vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<Esc>bi'

noremap <silent> <C-S-Left> :vertical resize +5<CR>
noremap <silent> <C-S-Right> :vertical resize -5<CR>
noremap <silent> <C-S-Up> :resize +5<CR>
noremap <silent> <C-S-Down> :resize -5<CR>

" jump to the end of line in insert mode
imap <c-l> <Esc>A
imap <c-h> <Esc>I

augroup neovim_terminal
    autocmd!
    " Enter Terminal-mode (insert) automatically
    autocmd TermEnter * startinsert
    " Disables number lines on terminal buffers
    autocmd TermOpen * :set nonumber norelativenumber
    " ctrl w out of terminal"
    autocmd TermOpen * tnoremap <buffer> <C-w> <C-\><C-n><C-w>
augroup END


" Format before saving
autocmd BufWritePre * lua vim.lsp.buf.formatting()

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

let g:vsnip_snippet_dir = "$HOME/.config/nvim/vsnip"

nnoremap <leader><leader> <c-^>
