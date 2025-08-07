-- Tools to install with mason:
-- astro-language-server
-- eslint-lsp
-- gofumpt
-- gopls
-- lua-language-server
-- prettierd
-- vtsls

vim.lsp.enable({
    "astro",
    "eslint",
    "gopls",
    "lua_ls",
    "tailwindcss",
    "vtsls"
})

-- Remove lua_ls warnings on all vim global variables
vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true)
            }
        }
    }
})
