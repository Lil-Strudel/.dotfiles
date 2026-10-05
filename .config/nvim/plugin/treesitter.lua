require("nvim-treesitter").install({
    "javascript", "typescript", "tsx", "astro", "html", "css", "json", "yaml",
    "go", "python", "rust", "terraform", "hcl",
})

vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        if pcall(vim.treesitter.start) then
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
    end,
})
