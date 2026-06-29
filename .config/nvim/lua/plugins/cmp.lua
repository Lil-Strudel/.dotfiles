return {
    {
        'saghen/blink.cmp',
        dependencies = {},
        version = '1.*',
        opts = {
            keymap = { preset = 'default' },
            appearance = {
                nerd_font_variant = 'mono'
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },
            fuzzy = { implementation = "prefer_rust_with_warning" },
        },
        opts_extend = { "sources.default" }
    },
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        keys = {
            {
                "<leader>f",
                function()
                    require("conform").format({ async = true, lsp_format = "fallback", quiet = true })
                end
            }
        },
        opts = function()
            local is_work = vim.fn.hostname() == "strudel-rx"
            local web_fmt = is_work
                and { "oxfmt", "prettierd", "prettier", stop_after_first = true }
                or { "prettierd", "prettier", stop_after_first = true }
            local bare_fmt = is_work
                and { "oxfmt", "prettier" }
                or { "prettier" }
            return {
                formatters_by_ft = {
                    javascript = web_fmt,
                    javascriptreact = web_fmt,
                    typescript = web_fmt,
                    typescriptreact = web_fmt,
                    vue = web_fmt,
                    css = web_fmt,
                    scss = web_fmt,
                    html = web_fmt,
                    json = web_fmt,
                    jsonc = web_fmt,
                    yaml = web_fmt,
                    markdown = web_fmt,
                    graphql = web_fmt,
                    astro = bare_fmt,
                    svelte = bare_fmt,
                    go = { "gofumpt" },
                    terraform = { "terraform_fmt" },
                    tf = { "terraform_fmt" },
                    hcl = { "terraform_fmt" },
                    python = { "black" },
                },
                format_on_save = { timeout_ms = 3000, lsp_format = "fallback", quiet = true }
            }
        end
    }
}
