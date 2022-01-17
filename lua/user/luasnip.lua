-- load friendly snippets
require("luasnip/loaders/from_vscode").load({
	paths = { "~/.local/share/nvim/site/pack/packer/start/friendly-snippets", "~/.config/nvim/snippets/" },
})

-- lua snip shortcuts
vim.cmd([[
  imap <silent><expr> <c-j> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<Plug>(Tabout)'
  imap <silent><expr> <c-k> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<Plug>(TaboutBack)'
  imap <c-l> <Plug>luasnip-expand-snippet
]])
