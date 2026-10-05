vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        if ev.data.spec.name == "nvim-treesitter" and ev.data.kind ~= "delete" then
            if not ev.data.active then vim.cmd.packadd("nvim-treesitter") end
            vim.cmd("TSUpdate")
        end
    end,
})

local gh = function(repo) return "https://github.com/" .. repo end

vim.pack.add({
    gh("rebelot/kanagawa.nvim"),
    gh("folke/snacks.nvim"),
    gh("nvim-tree/nvim-web-devicons"),

    { src = gh("saghen/blink.cmp"), version = vim.version.range("1.*") },
    { src = gh("nvim-treesitter/nvim-treesitter"), version = "main" },
    gh("tpope/vim-sleuth"),

    gh("mason-org/mason.nvim"),
    gh("neovim/nvim-lspconfig"),
    gh("stevearc/conform.nvim"),

    gh("stevearc/oil.nvim"),
    gh("tpope/vim-fugitive"),
    gh("lewis6991/gitsigns.nvim"),
})
