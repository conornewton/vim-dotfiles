vim.opt.signcolumn = "yes"
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.encoding = "UTF-8"

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.opt.completeopt = "menuone,noinsert,noselect"

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

-- todo fix this
vim.cmd([[
	imap <expr> <c-j>  v:lua.require("luasnip").jumpable(1)  ? v:lua.require("luasnip").jump(1) : '<Plug>(Tabout)'
	" smap <expr> <c-j>  :luado require("luasnip").jumpable(1)   ? lua require("luasnip").jump(1) : '<c-j>'
	imap <expr> <c-k>  v:lua.require("luasnip").jumpable(-1)  ? v:lua.require("luasnip").jump(-1) : '<Plug>(TaboutBack)'
	" smap <expr> <c-k>  :luado require("luasnip").jumpable(-1)  ? lua require("luasnip").jump(-1) : '<c-k>'
]])

require("user.plugins")
require("user.completion")
require("user.lsp")
require("user.treesitter")
require("user.telescope")
