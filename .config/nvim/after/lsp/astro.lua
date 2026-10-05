local bundled_tsdk = vim.fn.stdpath("data") .. "/mason/packages/astro-language-server/node_modules/typescript/lib"

return {
    before_init = function(_, config)
        local tsdk = require("lspconfig.util").get_typescript_server_path(config.root_dir)
        if vim.uv.fs_stat(tsdk .. "/tsserverlibrary.js") == nil then
            tsdk = bundled_tsdk
        end
        config.init_options.typescript.tsdk = tsdk
    end,
}
