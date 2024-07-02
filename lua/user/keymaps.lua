vim.g.leader = "\\"
vim.g.localleader = " "

local opts = {
    silent = true,
    noremap = true
}

-- TODO: check commands exist before mapping

vim.keymap.set("n", "\\f", "<cmd>Telescope lsp_document_symbols<cr>", opts)
vim.keymap.set("n", "\\r", "<cmd>Telescope registers<cr>", opts)
vim.keymap.set("n", "\\p", "<cmd>Telescope find_files<cr>", opts)
vim.keymap.set("n", "\\n", "<cmd>Neotree<cr>", opts)
vim.keymap.set("n", ",w", "<cmd> HopWord<cr>", opts)
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>", opts)
vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d", opts)
vim.keymap.set("x", "<leader>p", "\"_P", opts)
vim.keymap.set("n", "\\tt", "<cmd>InspectTree<cr>", opts)
vim.keymap.set("n", "\\te", "<cmd>EditQuery<cr>", opts)
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', opts)
