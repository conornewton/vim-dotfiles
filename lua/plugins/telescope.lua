local telescope = require("telescope")
telescope.builtin = require("telescope.builtin")
telescope.themes = require("telescope.themes")

telescope.setup({
    defaults = {
        file_ignore_patterns = { "node_modules" },
    },
})

-- only this after checking!!
telescope.load_extension("remote-sshfs")

vim.cmd([[nnoremap <leader>en <cmd>lua Edit_neovim()<CR>]])
vim.cmd([[nnoremap <leader>sp <cmd>lua Search_papers()<CR>]])

function Command()
    -- local opts
    --
    -- opts = {
    --     prompt_title = "Command",
    --     previewer = false,
    --
    --     layout_strategy = "center",
    --     layout_config = {
    --         prompt_position = 'top',
    --         anchor = 'N',
    --     }
    -- }
    -- TODO: change look of results
    telescope.builtin.commands(telescope.themes.get_dropdown({ previewer = false }))
    -- telescope.builtin.commands(opts)
end

vim.keymap.set("n", "<leader><leader>p", Command, {})

function Edit_neovim()
    local opts_with_preview, opts_without_preview

    opts_with_preview = {
        prompt_title = "Neovim Config",
        shorten_path = false,
        cwd = "~/.config/nvim",

        layout_strategy = "flex",
        layout_config = {
            width = 0.9,
            height = 0.8,

            horizontal = {
                width = { padding = 0.15 },
            },
            vertical = {
                preview_height = 0.75,
            },
        },

        mappings = {
            i = {
                ["<C-y>"] = false,
            },
        },
    }

    opts_without_preview = vim.deepcopy(opts_with_preview)
    opts_without_preview.previewer = false

    require("telescope.builtin").find_files(opts_with_preview)
end

function Search_papers()
    local opts_with_preview, opts_without_preview

    opts_with_preview = {
        prompt_title = "Searching Papers",
        shorten_path = false,
        cwd = "~/OneDrive/Documents/UniLaptop/Research/Papers/",
        search_file = "*.{tex, bib}",

        layout_strategy = "flex",
        layout_config = {
            width = 0.9,
            height = 0.8,

            horizontal = {
                width = { padding = 0.15 },
            },
            vertical = {
                preview_height = 0.75,
            },
        },

        mappings = {
            i = {
                ["<C-y>"] = false,
            },
        },
    }

    opts_without_preview = vim.deepcopy(opts_with_preview)
    opts_without_preview.previewer = false

    require("telescope.builtin").find_files(opts_with_preview)
end
