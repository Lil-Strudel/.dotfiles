require("mason").setup()

local tools = {
    "astro-language-server",
    "eslint-lsp",
    "gopls",
    "lua-language-server",
    "pyright",
    "rust-analyzer",
    "tailwindcss-language-server",
    "terraform-ls",
    "vtsls",

    "black",
    "gofumpt",
    "prettierd",

    "biome",
    "oxfmt",
    "oxlint",
}

local registry = require("mason-registry")
registry.refresh(function()
    for _, name in ipairs(tools) do
        local pkg = registry.get_package(name)
        if not pkg:is_installed() then pkg:install() end
    end
end)
