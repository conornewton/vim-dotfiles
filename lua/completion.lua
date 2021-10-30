local lspkind = require("lspkind")
lspkind.init()

local cmp = require("cmp")

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	mapping = {
		["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-y>"] = cmp.config.disable, -- If you want to remove the default `<C-y>` mapping, You can specify `cmp.config.disable` value.
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	},
	sources = cmp.config.sources({
		{ name = "nvim_lua" },
		{ name = "nvim_lsp" },
		{ name = "vsnip" }, -- For vsnip users.
		{ name = "path" },
	}, {
		{ name = "buffer" },
	}),
	formatting = {
		format = lspkind.cmp_format({
			with_text = false,
			menu = {
				buffer = "[buf]",
				nvim_lsp = "[LSP]",
				nvim_lua = "[api]",
				path = "[path]",
				vsnip = "[snip]",
			},
		}),
	},
	experimental = {
		native_menu = false,
		ghost_text = true,
	},
})

-- Use buffer source for `/`.
cmp.setup.cmdline("/", {
	sources = {
		{ name = "buffer" },
	},
})

-- require("lspkind").init({
-- 	with_text = false,
-- 	symbol_map = {
-- 		Text = "",
-- 		Method = "",
-- 		Function = "",
-- 		Constructor = "",
-- 		Field = "ﰠ",
-- 		Variable = "",
-- 		Class = "ﴯ",
-- 		Interface = "",
-- 		Module = "",
-- 		Property = "ﰠ",
-- 		Unit = "塞",
-- 		Value = "",
-- 		Enum = "",
-- 		Keyword = "",
-- 		Snippet = "",
-- 		Color = "",
-- 		File = "",
-- 		Reference = "",
-- 		Folder = "",
-- 		EnumMember = "",
-- 		Constant = "",
-- 		Struct = "פּ",
-- 		Event = "",
-- 		Operator = "",
-- 		TypeParameter = "",
-- 	},
-- })
