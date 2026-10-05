local js = { "biome", "oxfmt", "prettierd", stop_after_first = true }
local not_biome = { "oxfmt", "prettierd", stop_after_first = true }

require("conform").setup({
    formatters_by_ft = {
        javascript = js,
        javascriptreact = js,
        typescript = js,
        typescriptreact = js,
        css = js,
        json = js,
        jsonc = js,
        html = not_biome,
        yaml = not_biome,
        markdown = not_biome,
        astro = { "prettierd" },
        go = { "gofumpt" },
        python = { "black" },
        terraform = { "terraform_fmt" },
        hcl = { "terraform_fmt" },
    },
    formatters = {
        biome = { require_cwd = true },
        oxfmt = {
            require_cwd = true,
            -- the default also matches vite.config.*, which prettier projects have too
            cwd = require("conform.util").root_file({ ".oxfmtrc.json", ".oxfmtrc.jsonc", "oxfmt.config.ts" }),
        },
    },
    format_on_save = { timeout_ms = 3000, lsp_format = "fallback", quiet = true },
})

vim.keymap.set("n", "<leader>f", function()
    require("conform").format({ async = true, lsp_format = "fallback", quiet = true })
end)
