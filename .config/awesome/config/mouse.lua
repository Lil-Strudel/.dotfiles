local awful = require("awful")

awful.mouse.append_global_mousebindings({
    -- Menu on background right click
    awful.button({}, 3, function() M.main:toggle() end),

    -- Activate client on mouse click
    awful.button({}, 1, function(c)
        if c then
            c:activate { context = "mouse_click" }
        end
    end),
})

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:activate { context = "mouse_enter", raise = false }
end)
