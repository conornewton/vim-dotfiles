require("plugins")
require("completion")
require("lsp")
require("treesitter")
require("_telescope")

vim.opt.signcolumn = "yes"
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.encoding = "UTF-8"

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.cmd([[ 
	syntax enable
	set t_Co=256

	if has('termguicolors') 
	    set termguicolors
	endif

	let g:oceanic_next_terminal_bold = 1
	let g:oceanic_next_terminal_italic = 1
	colorscheme OceanicNext

	hi CursorLineNR guibg=NONE guifg=BOLD
]])

-- Format on save
vim.cmd([[ autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 1000) ]])

vim.cmd([[
	nnoremap \f <cmd>Telescope find_files<cr>
	nnoremap \b <cmd>Telescope buffers<cr>
	nnoremap \r <cmd>Telescope registers<cr>
	nnoremap \s <cmd>Telescope spell_suggest<cr>
	nnoremap \t :lua require('telescope').extensions.asynctasks.all()<CR>
	nnoremap <silent>\n :NvimTreeToggle<CR>
]])

-- Setup snippet bindings to jump
vim.cmd([[
	imap <expr> <c-j>  vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)' : '<Plug>(Tabout)'
	smap <expr> <c-j>  vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)' : '<c-j>'
	smap <expr> <c-k>  vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)' : '<Plug>(TaboutBack)'
	imap <expr> <c-k>  vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)' : '<c-k>'
]])
