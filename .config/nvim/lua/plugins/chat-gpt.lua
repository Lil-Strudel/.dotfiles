return {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    opts = {
        api_key_cmd = "cat " .. vim.env.HOME .. "/secrets/chatgpt.txt"
    },
    dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim"
    }
}
