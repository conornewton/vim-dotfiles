require("nvim-treesitter.configs").setup({
	highlight = { enable = true },
	autotag = { enable = true },
	-- context_commentstring = {
	-- 	enable = true,
	-- },
})

-- vim.cmd([[
--     set foldmethod=expr
--     set foldexpr=nvim_treesitter#foldexpr()
-- ]])
