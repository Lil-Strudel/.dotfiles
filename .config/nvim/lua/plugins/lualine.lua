return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        -- local bg_light = '#35332C'
        -- local bg = '#272520'
        -- local bg_dark = '#1B1A18'
        --
        -- local fg = '#FEF6E6'
        -- local fg_dark = '#DED2BA'
        -- local fg_darkest = '#A39C8F'
        --
        -- local ghost = '#5E5B55'
        -- local ghost_dark = '#484743'
        --
        -- local red = '#F46B73'
        -- local orange = '#F2A77D'
        -- local yellow = '#FCD68C'
        -- local green = '#A9DD97'
        -- local blue = '#3E8FB0'
        -- local light_blue = '#9CCFD8'
        -- local purple = '#C4A7E7'
        -- local pink = '#ED8B9D'
        -- local light_pink = '#FCB9D5'
        --
        -- local theme = {}
        --
        -- theme.normal = {
        --     a = { bg = blue, fg = bg },
        --     b = { bg = bg_light, fg = blue },
        --     c = { bg = bg_dark, fg = fg },
        --
        --     y = { bg = bg_light, fg = light_pink },
        --     z = { bg = green, fg = bg }
        -- }
        --
        -- theme.insert = {
        --     a = { bg = green, fg = bg },
        --     b = { bg = bg_light, fg = green },
        -- }
        --
        -- theme.command = {
        --     a = { bg = light_blue, fg = bg },
        --     b = { bg = bg_light, fg = light_blue },
        -- }
        --
        -- theme.visual = {
        --     a = { bg = purple, fg = bg },
        --     b = { bg = bg_light, fg = purple },
        -- }
        --
        -- theme.replace = {
        --     a = { bg = red, fg = bg },
        --     b = { bg = bg_light, fg = red },
        -- }
        --
        -- theme.terminal = {
        --     a = { bg = light_blue, fg = bg },
        --     b = { bg = bg_light, fg = light_blue },
        -- }
        --
        -- theme.inactive = {
        --     a = { bg = bg_dark, fg = blue },
        --     b = { bg = bg_dark, fg = bg_light, gui = "bold" },
        --     c = { bg = bg_dark, fg = bg_light }
        -- }
        --
        -- -- Remove to not bold
        -- for _, mode in pairs(theme) do
        --     mode.a.gui = "bold"
        -- end

        local theme = require("kanagawa.colors").setup({ theme = "dragon" }).theme

        local kanagawa = {}

        kanagawa.normal = {
            a = { bg = theme.syn.fun, fg = theme.ui.bg_m3 },
            b = { bg = theme.diff.change, fg = theme.syn.fun },
            c = { bg = theme.ui.bg_p1, fg = theme.ui.fg },
        }

        kanagawa.insert = {
            a = { bg = theme.diag.ok, fg = theme.ui.bg },
            b = { bg = theme.ui.bg, fg = theme.diag.ok },
        }

        kanagawa.command = {
            a = { bg = theme.syn.operator, fg = theme.ui.bg },
            b = { bg = theme.ui.bg, fg = theme.syn.operator },
        }

        kanagawa.visual = {
            a = { bg = theme.syn.keyword, fg = theme.ui.bg },
            b = { bg = theme.ui.bg, fg = theme.syn.keyword },
        }

        kanagawa.replace = {
            a = { bg = theme.syn.constant, fg = theme.ui.bg },
            b = { bg = theme.ui.bg, fg = theme.syn.constant },
        }

        kanagawa.inactive = {
            a = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            b = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim, gui = "bold" },
            c = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
        }

        if vim.g.kanagawa_lualine_bold then
            for _, mode in pairs(kanagawa) do
                mode.a.gui = "bold"
            end
        end

        require("lualine").setup({
            options = {
                theme = kanagawa,
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
