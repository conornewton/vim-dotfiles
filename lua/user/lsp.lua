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
        if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
            return
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT'
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME
                    -- Depending on the usage, you might want to add additional paths here.
                    -- "${3rd}/luv/library"
                    -- "${3rd}/busted/library",
                }
                -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                -- library = vim.api.nvim_get_runtime_file("", true)
            }
        })
    end,
    settings = {
        Lua = {}
    },
    on_attach = require("lsp-format").on_attach,
}

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
-- require("lspconfig").texlab.setup({
-- 	on_attach = on_attach,
-- })

--Make this use british english???
require("lspconfig").ltex.setup({ settings = { ltex = { language = "en-gb" } } })
