return require("packer").startup(function()
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
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/nvim-cmp")
	use("williamboman/nvim-lsp-installer")

	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	use("nvim-lua/popup.nvim")
	use("GustavoKatel/telescope-asynctasks.nvim")

	use("hruse/vim-vsnip")
	use("rafamadriz/friendly-snippets")
	use("jose-elias-alvarez/null-ls.nvim")
	use("onsails/lspkind-nvim")
	use("folke/trouble.nvim")

	use("lewis6991/gitsigns.nvim")

	use("jpalardy/vim-slime")
	use("hanschen/vim-ipython-cell")

	use({
		"kyazdani42/nvim-tree.lua",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("nvim-tree").setup({})
		end,
	})

	use("nvim-treesitter/nvim-treesitter")
	use("nvim-treesitter/playground")

	use("windwp/nvim-ts-autotag")
	use("JoosepAlviste/nvim-ts-context-commentstring")

	use("puremourning/vimspector")

	use("junegunn/goyo.vim")
	use("junegunn/limelight.vim")
	use("plasticboy/vim-markdown")
	use("jkramer/vim-checkbox")
	use("iamcco/markdown-preview.nvim")
	use("lervag/vimtex")
	use("pbrisbin/vim-mkdir")

	use("abecodes/tabout.nvim")

	use("skywind3000/asynctasks.vim")
	use("skywind3000/asyncrun.vim")

	use("dsznajder/vscode-es7-javascript-react-snippets")
end)
