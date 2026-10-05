local lspconfig_root_dir = dofile(vim.api.nvim_get_runtime_file("lsp/oxlint.lua", false)[1]).root_dir

-- lspconfig falls back to single-file mode when no oxlint config is found
return {
    root_dir = function(bufnr, on_dir)
        lspconfig_root_dir(bufnr, function(dir)
            if dir then on_dir(dir) end
        end)
    end,
}
