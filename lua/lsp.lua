local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
	properties = {
		"documentation",
		"detail",
		"additionalTextEdits",
	},
}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	--Enable completion triggered by <c-x><c-o>
	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	local opts = { noremap = true, silent = true }

	buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
	buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
	buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
	buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
end

-- local function ts_on_attach(client, bufnr)
-- 	client.resolved_capabilities.document_formatting = false
-- 	on_attach(client, bufnr)

-- 	require("nvim-lsp-ts-utils").setup({
-- 		eslint_bin = "eslint_d",
-- 		eslint_enable_diagnostics = true,
-- 		enable_formatting = true,
-- 		formatter = "eslint_d",
-- 	})

-- 	require("nvim-lsp-ts-utils").setup_client(client)
-- end

-- require("lspconfig").tsserver.setup({
-- 	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
-- 	on_attach = ts_on_attach,
-- 	root_dir = function()
-- 		return vim.loop.cwd()
-- 	end, --not sure what this does
-- })

-- require("lean").setup({
-- 	-- Lean 4
-- 	lsp = { on_attach = on_attach },

-- 	-- Lean 3
-- 	lsp3 = { on_attach = on_attach },

-- 	-- Abbreviation support
-- 	abbreviations = {
-- 		compe = true, -- nvim-compe source
-- 		leader = "\\",
-- 	},

-- 	mappings = true,
-- })

require("null-ls").config({
	sources = {
		require("null-ls").builtins.formatting.stylua,
		require("null-ls").builtins.formatting.autopep8,
	},
})

require("lspconfig")["null-ls"].setup({
	on_attach = on_attach,
})

local lsp_installer = require("nvim-lsp-installer")

lsp_installer.settings({
	ui = {
		icons = {
			server_installed = "✓",
			server_pending = "➜",
			server_uninstalled = "✗",
		},
	},
})

lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = on_attach,
	}

	server:setup(opts)
	vim.cmd([[ do User LspAttachBuffers ]])
end)

-- Compe setup
require("compe").setup({
	enabled = true,
	autocomplete = true,
	debug = false,
	min_length = 1,
	preselect = "enable",
	throttle_time = 80,
	source_timeout = 200,
	incomplete_delay = 400,
	max_abbr_width = 100,
	max_kind_width = 100,
	max_menu_width = 100,
	documentation = true,

	source = {
		path = true,
		nvim_lsp = true,
		nvim_lua = true,
		vsnip = true,
		buffer = true,
	},
})

require("nvim-autopairs").setup({})
require("nvim-autopairs.completion.compe").setup({
	map_cr = true, --  map <CR> on insert mode
	map_complete = true, -- it will auto insert `(` after select function or method item
	auto_select = false, -- auto select first item
})

-- icons in autocompletion menu
require("lspkind").init({
	with_text = false,
	symbol_map = {
		Text = "",
		Method = "",
		Function = "",
		Constructor = "",
		Field = "ﰠ",
		Variable = "",
		Class = "ﴯ",
		Interface = "",
		Module = "",
		Property = "ﰠ",
		Unit = "塞",
		Value = "",
		Enum = "",
		Keyword = "",
		Snippet = "",
		Color = "",
		File = "",
		Reference = "",
		Folder = "",
		EnumMember = "",
		Constant = "",
		Struct = "פּ",
		Event = "",
		Operator = "",
		TypeParameter = "",
	},
})

--Show diagnostic errors
require("trouble").setup({})

-- -- Lua
-- require("lsp-colors").setup({
-- 	Error = "#db4b4b",
-- 	Warning = "#e0af68",
-- 	Information = "#0db9d7",
-- 	Hint = "#10B981",
-- })
