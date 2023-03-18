local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")

screen.connect_signal("request::wallpaper", function(s)
    awful.wallpaper {
        screen = s,
        widget =
            {
                image     = beautiful.wallpaper,
                widget    = wibox.widget.imagebox,
		horizontal_fit_policy = "auto",
		vertical_fit_policy = "fit",
		upscale = true,
		downscale = true, 
		resize = true, 
            },
    }
end)
