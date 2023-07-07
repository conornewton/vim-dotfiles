vim.opt.signcolumn = "yes"
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.encoding = "UTF-8"

vim.opt.showmode = false

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.opt.completeopt = { "menuone", "noinsert", "noselect", "preview" }

vim.opt.ph = 10

vim.opt.foldmethod = "manual"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- vim.g.mapleader = "<Space>"

-- vim.g.oceanic_next_terminal_bold = 1
-- vim.g.oceanic_next_terminal_italic = 1

-- vim.cmd([[
--     syntax enable
--     set t_Co=256

--     if has('termguicolors')
-- 	set termguicolors
--     endif

--     colorscheme OceanicNext
-- ]])

-- Format on save
vim.cmd([[ autocmd BufWritePre * lua vim.lsp.buf.format(nil, 1000) ]])

-- File movement shortcuts
vim.cmd([[
    nnoremap \r <cmd>Telescope registers<cr>
    nnoremap \f <cmd>Telescope lsp_document_symbols<cr>
    nnoremap <silent>\t :lua require('telescope').extensions.asynctasks.all()<CR>
    nnoremap <silent>\n :NvimTreeToggle<CR>
    tnoremap <Esc> <C-\><C-n>

    " Do not place deleted text in paste buffer
    nnoremap <leader>d \"_d
    vnoremap <leader>d \"_d

    xnoremap <leader>p \"_dP

    " IDGAF
    inoremap <C-c> <Esc>
]])

vim.keymap.set("n", "\\p", "<cmd>Telescope find_files<cr>", { silent = true })
vim.keymap.set("n", ",w", "<cmd> HopWord<cr>", { silent = true })

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
vim.g.asynctasks_term_pos = "bottom"
vim.g.asynctasks_term_reuse = 1
vim.g.asynctasks_term_rows = 10

-- source other config files
require("user.globals")
require("user.plugins")
require("user.completion")
require("user.lsp")
require("user.treesitter")
require("user.telescope")
require("user.dap")
require("user.luasnip")
require("user.orgmode")
require("user.status")
require("user.winbar")

require("nvim-tree").setup({})

-- vim.notify = require("notify")

-- vim.diagnostic.config({
-- 	update_in_insert = true,
-- })

vim.cmd([[
    autocmd BufRead,BufNewFile *.h,*.c set filetype=c
]])

-- vim.cmd([[
--     highlight WinSeparator guibg=None
--     highlight NvimTreeWinSeparator guibg=None ctermbg=None
--     highlight WinBar gui=italic
--     highlight WinBar guibg=bg
-- ]])

vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha

require("catppuccin").setup()

vim.cmd([[colorscheme catppuccin]])

vim.g.jupyter_highlight_cells = 0
