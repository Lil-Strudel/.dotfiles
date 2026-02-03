return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "ravitemer/mcphub.nvim"
    },
    config = function()
        require("codecompanion").setup({
            adapters = {
                http = {
                    anthropic = function()
                        return require("codecompanion.adapters").extend("anthropic", {
                            env = {
                                api_key = "cmd:cat ~/secrets/anthropic.txt"
                            },
                        })
                    end,
                    openai = function()
                        return require("codecompanion.adapters").extend("openai", {
                            env = {
                                api_key = "cmd:cat ~/secrets/chatgpt.txt"
                            },
                        })
                    end,
                }
            },
            strategies = {
                chat = {
                    adapter = "anthropic",
                },
                inline = {
                    adapter = "anthropic",
                },
            },
            extensions = {
                mcphub = {
                    callback = "mcphub.extensions.codecompanion",
                    opts = {
                        make_vars = true,
                        make_slash_commands = true,
                        show_result_in_chat = true
                    }
                }
            }
        })
    end
}
