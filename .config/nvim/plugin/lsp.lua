vim.lsp.enable({
    "astro",
    "biome",
    "eslint",
    "gopls",
    "lua_ls",
    "oxlint",
    "pyright",
    "rust_analyzer",
    "tailwindcss",
    "terraformls",
    "vtsls",
})

vim.diagnostic.config({ virtual_text = true, severity_sort = true })
