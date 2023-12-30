return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    lazy = false,
    cmd = { "Neotree" },
    keys = {
        { "<leader>pv", "<cmd>Neotree<cr>" }
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim"
    },
    opts = {
        close_if_last_window = true,
        window = {
            position = "current"
        },
        filesystem = {
            hijack_netrw_behavior = "open_current"
        }
    }
}
