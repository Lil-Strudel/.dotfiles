require("oil").setup({
    use_default_keymaps = false,
    keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["-"] = "actions.parent",
    },
    view_options = { show_hidden = true },
})

vim.keymap.set("n", "<leader>pv", "<cmd>Oil<cr>")
