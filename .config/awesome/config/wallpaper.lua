local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")

screen.connect_signal("request::wallpaper", function(s)
    awful.spawn.with_shell("feh --bg-fill " .. beautiful.wallpaper)
end)
