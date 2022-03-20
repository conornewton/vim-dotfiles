require("telescope").setup({
	defaults = {
		file_ignore_patterns = { "node_modules" },
	},
})
require("telescope").load_extension("fzf")

vim.cmd([[nnoremap <leader>en <cmd>lua Edit_neovim()<CR>]])

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
