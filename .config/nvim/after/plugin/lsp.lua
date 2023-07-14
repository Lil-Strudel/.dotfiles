local lsp = require('lsp-zero')

lsp.preset("recommended")

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })
end)

lsp.set_sign_icons({
  error = '✘',
  warn = '▲',
  hint = '⚑',
  info = '»'
})

lsp.format_on_save({
    format_opts = {
        timeout_ms = 10000,
    },
    servers = {
        ['null-ls'] = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "css", "scss", "less",
            "html", "json", "jsonc", "yaml", "markdown", "markdown.mdx", "graphql", "handlebars" }
    }
})

lsp.setup()

local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.prettierd,
    }
})

require('mason-null-ls').setup({
  ensure_installed = nil,
  automatic_installation = true,
  automatic_setup = false,
})

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
    preselect = "item",
    completion = {
        completeopt = 'menu,menuone,noinsert'
    },
    sources = {
        {name = 'nvim_lsp'},
        {name = 'luasnip'},
        {name = 'copilot'}
    },
    mapping = {
    }
})
