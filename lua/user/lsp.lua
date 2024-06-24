-- local saga = require("lspsaga")
-- saga.init_lsp_saga({
-- 	error_sign = "",
-- 	warn_sign = "",
-- 	hint_sign = "",
-- 	infor_sign = "",
-- 	code_action_prompt = { enable = false },
-- })
--
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
-- capabilities.textDocument.completion.completionItem.resolveSupport = {
-- 	properties = {
-- 		"documentation",
-- 		"detail",
-- 		"additionalTextEdits",
-- 	},
-- }

-- require("null-ls").setup({
-- 	sources = {
-- 		require("null-ls").builtins.formatting.stylua,
-- 		require("null-ls").builtins.formatting.autopep8,
-- 		require("null-ls").builtins.code_actions.gitsigns,
-- 		require("null-ls").builtins.hover.dictionary,
-- 	},
-- 	on_attach = on_attach,
-- })
--
require 'lspconfig'.lua_ls.setup {
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
                checkThirdParty = false,
                library = vim.api.nvim_get_runtime_file("", true),
            }
        })
    end,
    settings = {
        Lua = {}
    },
    on_attach = require("lsp-format").on_attach,
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
