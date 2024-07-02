require("lspconfig").lua_ls.setup {
    on_init = function(client)
        local path = client.workspace_folders[1].name
        if vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc') then
            return
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
                version = 'LuaJIT'
            },
            workspace = {
                checkThirdParty = true,
                library = {
                    vim.env.VIMRUNTIME,
                    "${3rd}/luv/library",
                }
            }
        })
    end,
    settings = {
        Lua = {}
    },
}

require("lspconfig").ltex.setup({ settings = { ltex = { language = "en-gb" } } })

require("lspconfig").texlab.setup({})

-- require("lspconfig").clangd.setup({ capabilities = capabilities })

-- require("lspconfig").jedi_language_server.setup({
-- 	on_attach = on_attach,
-- })
-- require("lspconfig").tsserver.setup({
-- 	on_attach = on_attach,
-- })
-- require("lspconfig").eslint.setup({
-- 	on_attach = on_attach,
-- })
-- require("lspconfig").gopls.setup({})
--
