---------------------------------------------
-- Lil Strudel's Tokyo Night awesome theme --
---------------------------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local rnotification = require("ruled.notification")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")

local base_path = gfs.get_configuration_dir() 

local theme_path = base_path .. "/themes/tokyo-night/"
local themes_path = base_path .. "/themes/"

local colors = {}

colors.red             = "#f7768e"
colors.orange          = "#ff9e64"
colors.dark_orange     = "#e0af68"
colors.lime_green      = "#9ece6a"
colors.sea_green       = "#73daca"
colors.light_blue      = "#b4f9f8"
colors.blue            = "#2ac3d3"
colors.sky_blue        = "#7dcfff"
colors.lilac           = "#7aa2f7"
colors.purple          = "#bb9af7"
colors.off_white       = "#c0caf5"
colors.off_light_grey  = "#a9b1d6"
colors.off_grey        = "#9aa5ce"
colors.eggshell        = "#cfc9c2"
colors.dark_text       = "#565f89"
colors.off_black       = "#414868"
colors.background      = "#1a1b26"
colors.background_dark = "#16161e" 

local theme = {}

theme.font          = "sans 8"

theme.bg_normal     = colors.background_dark
theme.bg_focus      = "#535d6c"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#444444"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = colors.off_black
theme.fg_focus      = colors.eggshell
theme.fg_urgent     = colors.red
theme.fg_minimize   = "#ffffff"

theme.useless_gap         = dpi(5)
theme.border_width        = dpi(0)
theme.border_color_normal = "#000000"
theme.border_color_active = "#535d6c"
theme.border_color_marked = "#91231c"

theme.tasklist_bg_focus = colors.off_black

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
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

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

theme.wallpaper = theme_path.."background.jpg"

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path.."defaults/layouts/fairhw.png"
theme.layout_fairv = themes_path.."defaults/layouts/fairvw.png"
theme.layout_floating  = themes_path.."defaults/layouts/floatingw.png"
theme.layout_magnifier = themes_path.."defaults/layouts/magnifierw.png"
theme.layout_max = themes_path.."defaults/layouts/maxw.png"
theme.layout_fullscreen = themes_path.."defaults/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path.."defaults/layouts/tilebottomw.png"
theme.layout_tileleft   = themes_path.."defaults/layouts/tileleftw.png"
theme.layout_tile = themes_path.."defaults/layouts/tilew.png"
theme.layout_tiletop = themes_path.."defaults/layouts/tiletopw.png"
theme.layout_spiral  = themes_path.."defaults/layouts/spiralw.png"
theme.layout_dwindle = themes_path.."defaults/layouts/dwindlew.png"
theme.layout_cornernw = themes_path.."defaults/layouts/cornernww.png"
theme.layout_cornerne = themes_path.."defaults/layouts/cornernew.png"
theme.layout_cornersw = themes_path.."defaults/layouts/cornersww.png"
theme.layout_cornerse = themes_path.."defaults/layouts/cornersew.png"

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
