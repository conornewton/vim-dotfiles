-- load friendly snippets
-- require("luasnip/loaders/from_vscode").load({
-- 	paths = { "~/.local/share/nvim/site/pack/packer/start/friendly-snippets" },
-- })
--
-- vim.o.runtimepath = vim.o.runtimepath .. "~/.config/nvim/snippets"
-- require("luasnip/loaders/from_vscode").load()

require("luasnip.loaders.from_vscode").load({
	paths = { vim.fn.stdpath("config") .. "/snippets/vscode" },
})

-- lua snip shortcuts
vim.cmd([[
  imap <silent><expr> <c-j> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<Plug>(Tabout)'
  imap <silent><expr> <c-k> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<Plug>(TaboutBack)'
  imap <c-l> <Plug>luasnip-expand-snippet
]])

local luasnip = require("luasnip")

function _G.snippets_clear()
	for m, _ in pairs(luasnip.snippets) do
		package.loaded["snippets." .. m] = nil
	end
	luasnip.snippets = setmetatable({}, {
		__index = function(t, k)
			local ok, m = pcall(require, "snippets." .. k)
			if not ok and not string.match(m, "^module.*not found:") then
				error(m)
			end
			t[k] = ok and m or {}
			return t[k]
		end,
	})
end

_G.snippets_clear()

vim.cmd([[
augroup snippets_clear
au!
au BufWritePost ~/.config/nvim/snippets/luasnip/*.lua lua _G.snippets_clear()
augroup END
]])

function _G.edit_ft()
	-- returns table like {"lua", "all"}
	local fts = require("luasnip.util.util").get_snippet_filetypes()
	vim.ui.select(fts, {
		prompt = "Select which filetype to edit:",
	}, function(item, idx)
		-- selection aborted -> idx == nil
		if idx then
			vim.cmd("edit ~/.config/nvim/snippets/luasnip/" .. item .. ".lua")
		end
	end)
end

vim.cmd([[command! LuaSnipEdit :lua _G.edit_ft()]])
