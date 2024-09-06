-------------------------------------
-- Lil Strudel's Tokyo Night theme --
-------------------------------------

local theme_assets                              = require("beautiful.theme_assets")
local xresources                                = require("beautiful.xresources")
local rnotification                             = require("ruled.notification")
local dpi                                       = xresources.apply_dpi

local gcolor                                    = require("gears.color")
local gfs                                       = require("gears.filesystem")

local base_path                                 = gfs.get_configuration_dir()
local config_path                               = gfs.get_xdg_config_home()

local wallpaper                                 = "gruv-street.jpg"

local theme_path                                = base_path .. "/themes/strhuedel/"

local themes_path                               = base_path .. "/themes/"

local bg_light                                  = '#35332C'
local bg                                        = '#272520'
local bg_dark                                   = '#1B1A18'

local fg                                        = '#FEF6E6'
local fg_dark                                   = '#DED2BA'
local fg_darkest                                = '#A39C8F'

local ghost                                     = '#5E5B55'
local ghost_dark                                = '#484743'

local red                                       = '#F46B73'
local orange                                    = '#F2A77D'
local yellow                                    = '#FCD68C'
local green                                     = '#A9DD97'
local blue                                      = '#3E8FB0'
local light_blue                                = '#9CCFD8'
local purple                                    = '#C4A7E7'
local pink                                      = '#ED8B9D'
local light_pink                                = '#FCB9D5'

local theme                                     = {}

theme.font                                      = "MonoLisa Medium 10"

theme.bg_normal                                 = bg
theme.bg_focus                                  = bg_light
theme.bg_urgent                                 = bg
theme.bg_minimize                               = bg
theme.bg_systray                                = theme.bg_normal

theme.fg_normal                                 = fg
theme.fg_focus                                  = blue
theme.fg_urgent                                 = red
theme.fg_minimize                               = fg

theme.useless_gap                               = dpi(3)
theme.border_width                              = dpi(2)
theme.border_color_normal                       = bg_dark
theme.border_color_active                       = blue
theme.border_color_marked                       = orange

theme.hotkeys_modifiers_fg                      = ghost
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
local taglist_square_size                       = dpi(4)
theme.taglist_squares_sel                       = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel                     = theme_assets.taglist_squares_unsel(
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
theme.menu_submenu_icon                         = themes_path .. "defaults/submenu.png"
theme.menu_height                               = dpi(20)
theme.menu_width                                = dpi(150)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal              = themes_path .. "defaults/titlebar/close_normal.png"
theme.titlebar_close_button_focus               = themes_path .. "defaults/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal           = themes_path .. "defaults/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus            = themes_path .. "defaults/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive     = themes_path .. "defaults/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive      = themes_path .. "defaults/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active       = themes_path .. "defaults/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active        = themes_path .. "defaults/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive    = themes_path .. "defaults/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive     = themes_path .. "defaults/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active      = themes_path .. "defaults/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active       = themes_path .. "defaults/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive  = themes_path .. "defaults/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive   = themes_path .. "defaults/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active    = themes_path .. "defaults/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active     = themes_path .. "defaults/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path .. "defaults/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path .. "defaults/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active   = themes_path .. "defaults/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active    = themes_path .. "defaults/titlebar/maximized_focus_active.png"

theme.wallpaper                                 = config_path .. "/wallpapers/" .. wallpaper

-- You can use your own layout icons like this:
theme.layout_fairh                              = gcolor.recolor_image(themes_path .. "defaults/layouts/fairhw.png",
    theme.fg_normal)
theme.layout_fairv                              = gcolor.recolor_image(themes_path .. "defaults/layouts/fairvw.png",
    theme.fg_normal)
theme.layout_floating                           = gcolor.recolor_image(themes_path .. "defaults/layouts/floatingw.png",
    theme.fg_normal)
theme.layout_magnifier                          = gcolor.recolor_image(themes_path .. "defaults/layouts/magnifierw.png",
    theme.fg_normal)
theme.layout_max                                = gcolor.recolor_image(themes_path .. "defaults/layouts/maxw.png",
    theme.fg_normal)
theme.layout_fullscreen                         = gcolor.recolor_image(themes_path .. "defaults/layouts/fullscreenw.png",
    theme.fg_normal)
theme.layout_tilebottom                         = gcolor.recolor_image(themes_path .. "defaults/layouts/tilebottomw.png",
    theme.fg_normal)
theme.layout_tileleft                           = gcolor.recolor_image(themes_path .. "defaults/layouts/tileleftw.png",
    theme.fg_normal)
theme.layout_tile                               = gcolor.recolor_image(themes_path .. "defaults/layouts/tilew.png",
    theme.fg_normal)
theme.layout_tiletop                            = gcolor.recolor_image(themes_path .. "defaults/layouts/tiletopw.png",
    theme.fg_normal)
theme.layout_spiral                             = gcolor.recolor_image(themes_path .. "defaults/layouts/spiralw.png",
    theme.fg_normal)
theme.layout_dwindle                            = gcolor.recolor_image(themes_path .. "defaults/layouts/dwindlew.png",
    theme.fg_normal)
theme.layout_cornernw                           = gcolor.recolor_image(themes_path .. "defaults/layouts/cornernww.png",
    theme.fg_normal)
theme.layout_cornerne                           = gcolor.recolor_image(themes_path .. "defaults/layouts/cornernew.png",
    theme.fg_normal)
theme.layout_cornersw                           = gcolor.recolor_image(themes_path .. "defaults/layouts/cornersww.png",
    theme.fg_normal)
theme.layout_cornerse                           = gcolor.recolor_image(themes_path .. "defaults/layouts/cornersew.png",
    theme.fg_normal)

-- Generate Awesome icon:
theme.awesome_icon                              = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme                                = nil

-- Set different colors for urgent notifications.
rnotification.connect_signal('request::rules', function()
    rnotification.append_rule {
        rule       = { urgency = 'critical' },
        properties = { bg = '#ff0000', fg = '#ffffff' }
    }
end)

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
