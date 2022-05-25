vim.opt.signcolumn = "yes"
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.encoding = "UTF-8"

vim.opt.showmode = false

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.opt.completeopt = { "menuone", "noinsert", "noselect" }

vim.g.oceanic_next_terminal_bold = 1
vim.g.oceanic_next_terminal_italic = 1
vim.cmd([[ 
    syntax enable
    set t_Co=256

    if has('termguicolors') 
	set termguicolors
    endif

    colorscheme OceanicNext
]])

vim.cmd([[
    highlight WinSeparator guibg=None
    highlight WinBar gui=italic
    highlight WinBar guibg=bg
]])

-- Format on save
vim.cmd([[ autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 1000) ]])

-- File movement shortcuts
vim.cmd([[
    nnoremap \p <cmd>Telescope find_files<cr>
    nnoremap \b <cmd>Telescope buffers<cr>
    nnoremap \r <cmd>Telescope registers<cr>
    nnoremap \f <cmd>Telescope lsp_document_symbols<cr>
    nnoremap <silent>\t :lua require('telescope').extensions.asynctasks.all()<CR>
    nnoremap <silent>\n :NvimTreeToggle<CR>
    tnoremap <Esc> <C-\><C-n>
]])

-- Text editing shortcuts
-- provided by hop.nvim
vim.cmd([[
    nmap ,w <cmd> HopWord<cr>
]])

-- Find highlight group
vim.cmd([[
    function! SynStack ()
	for i1 in synstack(line("."), col("."))
	    let i2 = synIDtrans(i1)
	    let n1 = synIDattr(i1, "name")
	    let n2 = synIDattr(i2, "name")
	    echo n1 "->" n2
	endfor
    endfunction
    map gm :call SynStack()<CR>
]])

-- show terminal at the bottom when running tasks
vim.cmd([[
    let g:asynctasks_term_pos = 'bottom'
    let g:asynctasks_term_reuse = 1
    let g:asynctasks_term_rows = 10
]])

-- source other config files
require("user.globals")
require("user.plugins")
require("user.completion")
require("user.lsp")
require("user.treesitter")
require("user.telescope")
require("user.luasnip")
require("user.orgmode")
require("user.status")
require("user.winbar")
