local awful = require("awful")

awful.mouse.append_global_mousebindings {
    awful.button({}, 3, function()
        M.main:toggle()
    end),

    awful.button({}, 4, awful.tag.viewprev),

    awful.button({}, 5, awful.tag.viewnext),
}


client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings {
        awful.button({ }, 1, function (c)
            c:emit_signal("request::activate", "mouse_click", {raise = true})
        end),
        -- awful.button({ modkey }, 1, function (c)
        --     c:emit_signal("request::activate", "mouse_click", {raise = true})
        --     awful.mouse.client.move(c)
        -- end),
        awful.button({ modkey }, 3, function (c)
            c:emit_signal("request::activate", "mouse_click", {raise = true})
            awful.mouse.client.resize(c)
        end)
    }
end)