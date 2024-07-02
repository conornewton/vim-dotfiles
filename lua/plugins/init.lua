--Bootstrap Lazy.nvimplugs

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
    { "onsails/lspkind.nvim" }, -- symbols in the completion menu
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
    },
    { 'abecodes/tabout.nvim' }, -- uses treesitter - why?, doesn't work with latex

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

    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "macchiato"

            })
            vim.cmd.colorscheme("catppuccin")
        end
    },

    {
        "rcarriga/nvim-notify",
        config = function ()
            vim.notify = require("notify")
        end
    },
    {
        'mrded/nvim-lsp-notify',
        dependencies = {
            "rcarriga/nvim-notify",
        },
        config = function()
            require('lsp-notify').setup({})
        end
    },
    {
        "folke/trouble.nvim"
    },
    {
        "lervag/vimtex",
        lazy = false,
        init = function()
            vim.g.vimtex_view_method = "zathura"
        end
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
            -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        },
        config = function ()
            -- disable netrw
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1
        end
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function ()
            require("gitsigns").setup({})
        end
    }
})
