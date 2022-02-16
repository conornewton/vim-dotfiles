vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	-- Colourschemes
	use("mhartington/oceanic-next")

	-- Tpope!
	use("tpope/vim-commentary")
	use("tpope/vim-fugitive")
	use("tpope/vim-surround")
	use("tpope/vim-sleuth")

	-- LSP
	use("neovim/nvim-lspconfig")
	use("tami5/lspsaga.nvim")
	use("hrsh7th/cmp-nvim-lua")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("saadparwaiz1/cmp_luasnip")

	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/nvim-cmp")

	use("nvim-lua/popup.nvim")
	use("nvim-lua/plenary.nvim")

	use("L3MON4D3/LuaSnip")

	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	use("GustavoKatel/telescope-asynctasks.nvim")

	use("jose-elias-alvarez/null-ls.nvim")
	use("onsails/lspkind-nvim")
	use("folke/trouble.nvim")

	use({
		"lewis6991/gitsigns.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
		config = function()
			require("gitsigns").setup({
				keymaps = {},
			})
		end,
	})

	use("jupyter-vim/jupyter-vim")

	use("kyazdani42/nvim-web-devicons")
	use({
		"kyazdani42/nvim-tree.lua",
		requires = { { "kyazdani42/nvim-web-devicons" } },
		config = function()
			require("nvim-tree").setup()
		end,
	})

	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})

	use({
		"abecodes/tabout.nvim",
		config = function()
			require("tabout").setup({})
		end,
	})

	use({
		"phaazon/hop.nvim",
		branch = "v1", -- optional but strongly recommended
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require("hop").setup()
		end,
	})

	use("nvim-treesitter/nvim-treesitter")
	use("nvim-treesitter/playground")
	use("windwp/nvim-ts-autotag")
	use("JoosepAlviste/nvim-ts-context-commentstring")

	use("skywind3000/asynctasks.vim")
	use("skywind3000/asyncrun.vim")

	use("puremourning/vimspector")

	use("plasticboy/vim-markdown")
	use("jkramer/vim-checkbox")
	use("iamcco/markdown-preview.nvim")
	use("pbrisbin/vim-mkdir")

	use("lervag/vimtex")

	use("mfussenegger/nvim-jdtls")

	use("vimwiki/vimwiki")

	use("rcarriga/nvim-notify")
	use({
		"nvim-orgmode/orgmode",
	})

	-- Nice menus
	use("stevearc/dressing.nvim")

	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
end)
