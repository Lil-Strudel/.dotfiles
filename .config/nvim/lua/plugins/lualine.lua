return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local bg_light = '#35332C'
        local bg = '#272520'
        local bg_dark = '#1B1A18'

        local fg = '#FEF6E6'
        local fg_dark = '#DED2BA'
        local fg_darkest = '#A39C8F'

        local ghost = '#5E5B55'
        local ghost_dark = '#484743'

        local red = '#F46B73'
        local orange = '#F2A77D'
        local yellow = '#FCD68C'
        local green = '#A9DD97'
        local blue = '#3E8FB0'
        local light_blue = '#9CCFD8' 
        local purple = '#C4A7E7'
        local pink = '#ED8B9D'
        local light_pink = '#FCB9D5'

        local theme = {}

        theme.normal = {
            a = { bg = blue, fg = bg },
            b = { bg = bg_light, fg = blue },
            c = { bg = bg_dark, fg = fg },

            y = { bg = bg_light, fg = light_pink },
            z = { bg = green, fg = bg }
        }

        theme.insert = {
            a = { bg = green, fg = bg },
            b = { bg = bg_light, fg = green },
        }

        theme.command = {
            a = { bg = light_blue, fg = bg },
            b = { bg = bg_light, fg = light_blue },
        }

        theme.visual = {
            a = { bg = purple, fg = bg },
            b = { bg = bg_light, fg = purple },
        }

        theme.replace = {
            a = { bg = red, fg = bg },
            b = { bg = bg_light, fg = red },
        }

        theme.terminal = {
            a = { bg = light_blue, fg = bg },
            b = { bg = bg_light, fg = light_blue },
        }

        theme.inactive = {
            a = { bg = bg_dark, fg = blue },
            b = { bg = bg_dark, fg = bg_light, gui = "bold" },
            c = { bg = bg_dark, fg = bg_light }
        }

        -- Remove to not bold
        for _, mode in pairs(theme) do
            mode.a.gui = "bold"
        end

        require("lualine").setup({
            options = {
                theme = theme,
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
                -- lualine_y = { { 'filetype', separator = { left = '' } }, 'progress' },
                -- lualine_z = { { 'location', separator = { left = '' }, left_padding = 2 } }
            }
        })
    end
}
