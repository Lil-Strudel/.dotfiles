-- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/tailwindcss.lua
function root_markers_with_field(root_files, new_names, field, fname)
    local path = vim.fn.fnamemodify(fname, ':h')
    local found = vim.fs.find(new_names, { path = path, upward = true })

    for _, f in ipairs(found or {}) do
        -- Match the given `field`.
        for line in io.lines(f) do
            if line:find(field) then
                root_files[#root_files + 1] = vim.fs.basename(f)
                break
            end
        end
    end

    return root_files
end

function insert_package_json(root_files, field, fname)
    return root_markers_with_field(root_files, { 'package.json', 'package.json5' }, field, fname)
end

return {
    cmd = { 'tailwindcss-language-server', '--stdio' },
    -- filetypes copied and adjusted from tailwindcss-intellisense
    filetypes = {
        -- html
        'aspnetcorerazor',
        'astro',
        'astro-markdown',
        'blade',
        'clojure',
        'django-html',
        'htmldjango',
        'edge',
        'eelixir', -- vim ft
        'elixir',
        'ejs',
        'erb',
        'eruby', -- vim ft
        'gohtml',
        'gohtmltmpl',
        'haml',
        'handlebars',
        'hbs',
        'html',
        'htmlangular',
        'html-eex',
        'heex',
        'jade',
        'leaf',
        'liquid',
        'markdown',
        'mdx',
        'mustache',
        'njk',
        'nunjucks',
        'php',
        'razor',
        'slim',
        'twig',
        -- css
        'css',
        'less',
        'postcss',
        'sass',
        'scss',
        'stylus',
        'sugarss',
        -- js
        'javascript',
        'javascriptreact',
        'reason',
        'rescript',
        'typescript',
        'typescriptreact',
        -- mixed
        'vue',
        'svelte',
        'templ',
    },
    settings = {
        tailwindCSS = {
            validate = true,
            lint = {
                cssConflict = 'warning',
                invalidApply = 'error',
                invalidScreen = 'error',
                invalidVariant = 'error',
                invalidConfigPath = 'error',
                invalidTailwindDirective = 'error',
                recommendedVariantOrder = 'warning',
            },
            classAttributes = {
                'class',
                'className',
                'class:list',
                'classList',
                'ngClass',
            },
            includeLanguages = {
                eelixir = 'html-eex',
                elixir = 'phoenix-heex',
                eruby = 'erb',
                heex = 'phoenix-heex',
                htmlangular = 'html',
                templ = 'html',
            },
        },
    },
    before_init = function(_, config)
        if not config.settings then
            config.settings = {}
        end
        if not config.settings.editor then
            config.settings.editor = {}
        end
        if not config.settings.editor.tabSize then
            config.settings.editor.tabSize = vim.lsp.util.get_effective_tabstop()
        end
    end,
    workspace_required = true,
    root_dir = function(bufnr, on_dir)
        local root_files = {
            -- Generic
            'tailwind.config.js',
            'tailwind.config.cjs',
            'tailwind.config.mjs',
            'tailwind.config.ts',
            'postcss.config.js',
            'postcss.config.cjs',
            'postcss.config.mjs',
            'postcss.config.ts',
            -- Phoenix
            'assets/tailwind.config.js',
            'assets/tailwind.config.cjs',
            'assets/tailwind.config.mjs',
            'assets/tailwind.config.ts',
            -- Django
            'theme/static_src/tailwind.config.js',
            'theme/static_src/tailwind.config.cjs',
            'theme/static_src/tailwind.config.mjs',
            'theme/static_src/tailwind.config.ts',
            'theme/static_src/postcss.config.js',
            -- Rails
            'app/assets/stylesheets/application.tailwind.css',
            'app/assets/tailwind/application.css',
        }
        local fname = vim.api.nvim_buf_get_name(bufnr)
        root_files = insert_package_json(root_files, 'tailwindcss', fname)
        root_files = root_markers_with_field(root_files, { 'mix.lock' }, 'tailwind', fname)
        on_dir(vim.fs.dirname(vim.fs.find(root_files, { path = fname, upward = true })[1]))
    end,
}
