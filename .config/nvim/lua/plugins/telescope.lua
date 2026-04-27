return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        -- nvim-treesitter removed ft_to_lang; shim it for telescope 0.1.5 compatibility
        local ok, parsers = pcall(require, "nvim-treesitter.parsers")
        if ok and not parsers.ft_to_lang then
            parsers.ft_to_lang = function(ft)
                return vim.treesitter.language.get_lang(ft) or ft
            end
        end
    end,
    keys = {
        { "<leader>pf", function() require("telescope.builtin").find_files() end },
        { "<C-p>",      function() require("telescope.builtin").git_files() end },
        { "<leader>ps", function() require("telescope.builtin").live_grep() end }
    }
}
