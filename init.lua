require("user.options")
require("user.globals")
require("user.keymaps")

require("user.plugins")
require("user.lsp")
require("user.completion")
require("user.telescope")
require("user.luasnip")
require("user.winbar")
require("user.status")


require("catppuccin").setup({
    flavour = "macchiato"

})
vim.cmd.colorscheme("catppuccin")

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- require("remote-sshfs").setup({})
