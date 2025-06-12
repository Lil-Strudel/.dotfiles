return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("codecompanion").setup({
            adapters = {
                anthropic = function()
                    return require("codecompanion.adapters").extend("anthropic", {
                        env = {
                            api_key = "cmd:cat ~/secrets/anthropic.txt"
                        },
                    })
                end,
            },
            strategies = {
                chat = {
                    adapter = "anthropic",
                },
                inline = {
                    adapter = "anthropic",
                },
            },
        })
    end
}
