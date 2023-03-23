-------------------------------------
-- Lil Strudel's Tokyo Night theme --
-------------------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local rnotification = require("ruled.notification")
local dpi = xresources.apply_dpi

local gcolor = require("gears.color")
local gfs = require("gears.filesystem")

local base_path = gfs.get_configuration_dir()

local wallpaper = "anime-balcony.png"

local theme_path = base_path .. "/themes/tokyo-night/"

local themes_path = base_path .. "/themes/"

-- https://github.com/folke/tokyonight.nvim/blob/main/extras/lua/tokyonight_night.lua
local colors = {
  bg = "#1a1b26",
  bg_dark = "#16161e",
  bg_float = "#16161e",
  bg_highlight = "#292e42",
  bg_popup = "#16161e",
  bg_search = "#3d59a1",
  bg_sidebar = "#16161e",
  bg_statusline = "#16161e",
  bg_visual = "#33467c",
  black = "#15161e",
  blue = "#7aa2f7",
  blue0 = "#3d59a1",
  blue1 = "#2ac3de",
  blue2 = "#0db9d7",
  blue5 = "#89ddff",
  blue6 = "#b4f9f8",
  blue7 = "#394b70",
  border = "#15161e",
  border_highlight = "#27a1b9",
  comment = "#565f89",
  cyan = "#7dcfff",
  dark3 = "#545c7e",
  dark5 = "#737aa2",
  diff = {
    add = "#20303b",
    change = "#1f2231",
    delete = "#37222c",
    text = "#394b70"
  },
  error = "#db4b4b",
  fg = "#c0caf5",
  fg_dark = "#a9b1d6",
  fg_float = "#c0caf5",
  fg_gutter = "#3b4261",
  fg_sidebar = "#a9b1d6",
  git = {
    add = "#4097a3",
    change = "#506d9b",
    delete = "#c47981",
    ignore = "#545c7e"
  },
  gitSigns = {
    add = "#399a96",
    change = "#6382bd",
    delete = "#c25d64"
  },
  green = "#9ece6a",
  green1 = "#73daca",
  green2 = "#41a6b5",
  hint = "#1abc9c",
  info = "#0db9d7",
  magenta = "#bb9af7",
  magenta2 = "#ff007c",
  none = "NONE",
  orange = "#ff9e64",
  purple = "#9d7cd8",
  red = "#f7768e",
  red1 = "#db4b4b",
  teal = "#1abc9c",
  terminal_black = "#414868",
  warning = "#e0af68",
  yellow = "#e0af68"
}

local theme = {}

theme.font          = "MonoLisa Medium 10"

theme.bg_normal     = colors.bg
theme.bg_focus      = colors.bg_highlight
theme.bg_urgent     = colors.bg
theme.bg_minimize   = colors.bg
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = colors.fg
theme.fg_focus      = colors.blue
theme.fg_urgent     = colors.red
theme.fg_minimize   = colors.fg

theme.useless_gap         = dpi(3)
theme.border_width        = dpi(2)
theme.border_color_normal = colors.border
theme.border_color_active = colors.border_highlight
theme.border_color_marked = colors.border_highlight

theme.hotkeys_modifiers_fg = colors.comment
-- There are other variable sets
-- overriding the defaults one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path.."defaults/submenu.png"
theme.menu_height = dpi(20)
theme.menu_width  = dpi(150)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = themes_path.."defaults/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = themes_path.."defaults/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = themes_path.."defaults/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = themes_path.."defaults/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = themes_path.."defaults/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path.."defaults/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path.."defaults/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = themes_path.."defaults/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path.."defaults/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path.."defaults/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path.."defaults/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = themes_path.."defaults/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path.."defaults/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = themes_path.."defaults/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path.."defaults/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = themes_path.."defaults/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path.."defaults/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path.."defaults/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themes_path.."defaults/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = themes_path.."defaults/titlebar/maximized_focus_active.png"

theme.wallpaper = themes_path .. "/wallpapers/" .. wallpaper

-- You can use your own layout icons like this:
theme.layout_fairh = gcolor.recolor_image(themes_path.."defaults/layouts/fairhw.png", theme.fg_normal)
theme.layout_fairv = gcolor.recolor_image(themes_path.."defaults/layouts/fairvw.png", theme.fg_normal)
theme.layout_floating  = gcolor.recolor_image(themes_path.."defaults/layouts/floatingw.png", theme.fg_normal)
theme.layout_magnifier = gcolor.recolor_image(themes_path.."defaults/layouts/magnifierw.png", theme.fg_normal)
theme.layout_max = gcolor.recolor_image(themes_path.."defaults/layouts/maxw.png", theme.fg_normal)
theme.layout_fullscreen = gcolor.recolor_image(themes_path.."defaults/layouts/fullscreenw.png", theme.fg_normal)
theme.layout_tilebottom = gcolor.recolor_image(themes_path.."defaults/layouts/tilebottomw.png", theme.fg_normal)
theme.layout_tileleft   = gcolor.recolor_image(themes_path.."defaults/layouts/tileleftw.png", theme.fg_normal)
theme.layout_tile = gcolor.recolor_image(themes_path.."defaults/layouts/tilew.png", theme.fg_normal)
theme.layout_tiletop = gcolor.recolor_image(themes_path.."defaults/layouts/tiletopw.png", theme.fg_normal)
theme.layout_spiral  = gcolor.recolor_image(themes_path.."defaults/layouts/spiralw.png", theme.fg_normal)
theme.layout_dwindle = gcolor.recolor_image(themes_path.."defaults/layouts/dwindlew.png", theme.fg_normal)
theme.layout_cornernw = gcolor.recolor_image(themes_path.."defaults/layouts/cornernww.png", theme.fg_normal)
theme.layout_cornerne = gcolor.recolor_image(themes_path.."defaults/layouts/cornernew.png", theme.fg_normal)
theme.layout_cornersw = gcolor.recolor_image(themes_path.."defaults/layouts/cornersww.png", theme.fg_normal)
theme.layout_cornerse = gcolor.recolor_image(themes_path.."defaults/layouts/cornersew.png", theme.fg_normal)

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

-- Set different colors for urgent notifications.
rnotification.connect_signal('request::rules', function()
    rnotification.append_rule {
        rule       = { urgency = 'critical' },
        properties = { bg = '#ff0000', fg = '#ffffff' }
    }
end)

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
