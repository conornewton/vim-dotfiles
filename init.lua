require("user.plugins")
require("user.lsp")
require("user.completion")
require("user.telescope")
require("user.luasnip")

require("user.options")
require("user.globals")
require("user.keymaps")

require("catppuccin").setup({
    flavour = "macchiato"
})
vim.cmd.colorscheme("catppuccin")

require("nvim-treesitter.configs").setup({
    highlight = { enable = true }
})

require("nvim-tree").setup()
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("remote-sshfs").setup({})
