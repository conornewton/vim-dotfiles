-- load vs code snippets
require("luasnip.loaders.from_vscode").load({
    paths = { vim.fn.stdpath("config") .. "/snippets/vscode" },
})

require("tabout").setup({})

-- lua snip shortcuts
vim.cmd([[
  imap <silent><expr> <c-j> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<Plug>(Tabout)'
  imap <silent><expr> <c-k> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<Plug>(TaboutBack)'
  imap <c-l> <Plug>luasnip-expand-snippet
  imap <silent><expr> <c-e> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
]])

-- load all lua snippet files
local dir_path = vim.fn.stdpath("config") .. "/snippets/luasnip/*lua"
local paths = vim.split(vim.fn.glob(dir_path), "\n")

vim.api.nvim_create_augroup("LuaSnipFiles", { clear = true })

--After saving a luasnip file reload it
vim.api.nvim_create_autocmd("BufWritePost", {
    callback = function()
        dofile(vim.fn.expand("%"))
        require("cmp_luasnip").clear_cache() --reload the cmp source
    end,
    pattern = paths,
    group = "LuaSnipFiles",
})

for _, v in ipairs(paths) do
    dofile(v)
end

-- edit local lua snippet files
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

function _G.edit_snippets()
    local dir_path = vim.fn.stdpath("config") .. "/snippets/luasnip/"
    local ext = vim.fn.expand("%:e")
    vim.cmd("edit" .. dir_path .. ext .. ".lua")
end

vim.cmd([[nnoremap <silent> \es :lua _G.edit_snippets()<cr>]])
