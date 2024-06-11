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
]])


-- Bootsrap for lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


vim.keymap.set("n", "\\p", "<cmd>Telescope find_files<cr>", { silent = true })
vim.keymap.set("n", ",w", "<cmd> HopWord<cr>", { silent = true })

-- show terminal at the bottom when running tasks
vim.g.asynctasks_term_pos = "bottom"
vim.g.asynctasks_term_reuse = 1
vim.g.asynctasks_term_rows = 10

-- source other config files
require("user.globals")
require("user.plugins")
-- require("user.completion")
-- require("user.lsp")
-- require("user.treesitter")
-- require("user.telescope")
-- require("user.dap")
-- require("user.luasnip")
-- require("user.status")
-- require("user.winbar")

-- require("nvim-tree").setup({})

-- vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha
-- require("catppuccin").setup()

-- vim.cmd([[colorscheme catppuccin]])


