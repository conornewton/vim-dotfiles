call plug#begin('~/.vim/plugged')
"Colours
Plug 'NLKNguyen/papercolor-theme'
Plug 'sjl/badwolf'
Plug 'morhetz/gruvbox'
Plug 'folke/lsp-colors.nvim'


"TPOPE
Plug 'tpope/vim-commentary' " Easy commenting
Plug 'tpope/vim-fugitive'   " Git stuff
Plug 'tpope/vim-surround'   " Surrounding stuff (maybe there is a tree sitter version)?
Plug 'tpope/vim-sleuth'     " Heuristically sets filespecific data such as indent

"Nvim LSP
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
" Plug 'kabouzeid/nvim-lspinstall'
Plug 'williamboman/nvim-lsp-installer'
Plug 'windwp/nvim-autopairs'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'rafamadriz/friendly-snippets'
Plug 'jose-elias-alvarez/null-ls.nvim'
" Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
Plug 'onsails/lspkind-nvim' "Lsp Icons
Plug 'folke/trouble.nvim'

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'GustavoKatel/telescope-asynctasks.nvim'

" Python
Plug 'jpalardy/vim-slime'
Plug 'hanschen/vim-ipython-cell'

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

" Debugging
Plug 'puremourning/vimspector'

"Writing plugins
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'plasticboy/vim-markdown'
Plug 'jkramer/vim-checkbox'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'lervag/vimtex'
Plug 'pbrisbin/vim-mkdir'

" Startup screen
Plug 'mhinz/vim-startify'

" Tabout
Plug 'abecodes/tabout.nvim'

" Async run
Plug 'skywind3000/asynctasks.vim'
Plug 'skywind3000/asyncrun.vim'

" VSCODE EXTENSIONS"
Plug 'dsznajder/vscode-es7-javascript-react-snippets'
call plug#end()

" set background=dark
colorscheme badwolf
" let g:airline_theme = 'gruvbox'
" let g:airline_powerline_fonts = 1

filetype plugin on
syntax on

" set cursorline
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

if has("win32") 
    nnoremap <leader>ef :e C:/Users/Conor/AppData/Local/nvim/ftplugin/<C-R>=&filetype<CR>.vim<CR>
else
    nnoremap <leader>ef :e ~/.config/nvim/ftplugin/<C-R>=&filetype<CR>.vim<CR>
endif

autocmd! FileType make setlocal noexpandtab " Make files need proper tabs

"pop up menu shows 16 suggestions at a time
set pumheight=16
set completeopt=menuone,noselect

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm(luaeval("require 'nvim-autopairs'.autopairs_cr()"))
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

nnoremap \f <cmd>Telescope find_files<cr>
nnoremap \b <cmd>Telescope buffers<cr>
nnoremap \r <cmd>Telescope registers<cr>
nnoremap \s <cmd>Telescope spell_suggest<cr>
nnoremap \t <cmd>TroubleToggle <CR>
nnoremap <silent>\n :NvimTreeToggle<CR>

" Treesitter folding
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevel=99 "unfolded by defualt

let g:startify_bookmarks = ['~/.config/nvim/init.vim',]


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
autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 1000)

let g:vsnip_snippet_dir = "$HOME/.config/nvim/vsnip"

nnoremap <leader><leader> <c-^>

autocmd FileType vim lua require('nvim-autopairs').remove_rule('\"')

lua << EOF
require('tabout').setup{
    tabkey = '',
    backwards_tabkey = '',
    act_as_tab = false,
    act_as_shift_tab = false,
    completion = true
}
EOF

" TODO create tabout event checking if we can tabout forward of backwards
" otherwise just use w or b commands

" Jump forward or backward through snippets
imap <expr> <c-j>  vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Plug>(Tabout)'
smap <expr> <c-j>  vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<c-j>'
smap <expr> <c-k>  vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<c-k>'
imap <expr> <c-k>  vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<Plug>(TaboutBack)'

highlight clear SignColumn "Makes the sign column the same colour as the rest of the page

let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
set conceallevel=2

" Open splits automatically on the bottom right
set splitbelow splitright

let g:mkdp_markdown_css = expand('~/Documents/notes/grubox-md.css')

" Center after scrolling the screen
nnoremap {  {zz
nnoremap }  }zz
nnoremap n  nzz
nnoremap N  Nzz

let g:asyncrun_open = 6

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight

hi Conceal ctermbg=NONE guibg=NONE

lua require('nvim-tree').setup {}
