return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "folke/tokyonight.nvim"
    },
    config = function()
        local colors = require("tokyonight.colors").setup({ transform = true })
        local config = require("tokyonight.config").options

        local tokyonight = {}

        tokyonight.normal = {
            a = { bg = colors.blue, fg = colors.bg },
            b = { bg = colors.bg_highlight, fg = colors.blue },
            c = { bg = colors.bg_statusline, fg = colors.fg_sidebar },

            y = { bg = colors.bg_highlight, fg = colors.magenta },
            z = { bg = colors.green, fg = colors.bg }
        }

        tokyonight.insert = {
            a = { bg = colors.green, fg = colors.bg },
            b = { bg = colors.bg_highlight, fg = colors.green },
        }

        tokyonight.command = {
            a = { bg = colors.orange, fg = colors.bg },
            b = { bg = colors.bg_highlight, fg = colors.yellow },
        }

        tokyonight.visual = {
            a = { bg = colors.purple, fg = colors.bg },
            b = { bg = colors.bg_highlight, fg = colors.magenta },
        }

        tokyonight.replace = {
            a = { bg = colors.red, fg = colors.bg },
            b = { bg = colors.bg_highlight, fg = colors.red },
        }

        tokyonight.terminal = {
            a = { bg = colors.teal, fg = colors.bg },
            b = { bg = colors.bg_highlight, fg = colors.teal },
        }

        tokyonight.inactive = {
            a = { bg = colors.bg_statusline, fg = colors.blue },
            b = { bg = colors.bg_statusline, fg = colors.bg_highlight, gui = "bold" },
            c = { bg = colors.bg_statusline, fg = colors.bg_highlight }
        }

        if config.lualine_bold then
            for _, mode in pairs(tokyonight) do
                mode.a.gui = "bold"
            end
        end

        require("lualine").setup({
            options = {
                theme = tokyonight,
                component_separators = '',
                section_separators = { left = '', right = '' }
                -- section_separators = { left = '', right = '' }
                -- section_separators = { left = '', right = '' }
            },
            sections = {
                lualine_a = {
                    { 'mode', right_padding = 2 }
                },
                lualine_b = { 'filename', 'branch' },
                lualine_c = {},
                lualine_x = {},
                lualine_y = { { 'filetype', separator = { left = '' } }, 'progress' },
                lualine_z = {
                    { 'location', separator = { left = '' }, left_padding = 2 }
                }
            }
        })
    end
}
