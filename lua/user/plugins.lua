--Bootstrap Lazy.nvim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
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

-- Plugins

require("lazy").setup({
    { "neovim/nvim-lspconfig" },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-cmdline' },
    { "hrsh7th/nvim-cmp" },
    { "lukas-reineke/lsp-format.nvim" }, -- maybe try something else..
    { "onsails/lspkind.nvim" },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
    },
    { 'abecodes/tabout.nvim' }, -- uses treesitter

    { 'L3MON4D3/LuaSnip' },     -- integrate with tabout
    { 'saadparwaiz1/cmp_luasnip' },

    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
    },
    {
        'smoka7/hop.nvim',
        version = "*",
        opts = {
            keys = 'etovxqpdygfblzhckisuran'
        },

    },
    -- not sure if this is good?, i can make something better?
    { "nosduco/remote-sshfs.nvim", dependencies = { "nvim-telescope/telescope.nvim" } },

    { "catppuccin/nvim",           name = "catppuccin",                               priority = 1000 },

    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
    { "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" } },
    {
        "rcarriga/nvim-notify",
    },
})
