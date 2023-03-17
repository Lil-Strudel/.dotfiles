local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")

screen.connect_signal("request::wallpaper", function(s)
    awful.wallpaper {
        screen = s,
        widget = {
            {
                image                 = beautiful.wallpaper,
                upscale               = true,
                downscale             = true,
                horizontal_fit_policy = "fit",
                vertical_fit_policy   = "fit",
                widget                = wibox.widget.imagebox,
            },
            valign = "center",
            halign = "center",
            tiled  = false,
            widget = wibox.container.tile,
        }
    }
end)
