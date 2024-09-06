local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")

local modkey = C.modkey or "Mod4"

-- My keybinds
awful.keyboard.append_global_keybindings({
    awful.key({ modkey, }, "Return", function() awful.spawn(C.terminal) end,
        { description = "open a terminal", group = "launcher" }),

    awful.key({ modkey }, "d", function() awful.util.spawn("rofi -show drun") end,
        { description = "run prompt", group = "launcher" }),

    awful.key({ modkey, "Control", "Shift" }, "l", function() awful.util.spawn_with_shell("xsecurelock") end,
        { description = "lock session", group = "custom" }),

    awful.key({}, "Print", function() awful.util.spawn_with_shell("flameshot gui") end,
        { description = "take a screenshot", group = "custom" })
})

-- Media Keybinds
awful.keyboard.append_global_keybindings({
    awful.key({}, "XF86AudioRaiseVolume",
        function() awful.util.spawn_with_shell("pactl set-sink-volume @DEFAULT_SINK@ +5%") end,
        { description = "raise volume", group = "media" }),

    awful.key({}, "XF86AudioLowerVolume",
        function() awful.util.spawn_with_shell("pactl set-sink-volume @DEFAULT_SINK@ -5%") end,
        { description = "lower volume", group = "media" }),

    awful.key({}, "XF86AudioMute",
        function() awful.util.spawn_with_shell("pactl set-sink-mute @DEFAULT_SOURCE@ toggle") end,
        { description = "mute", group = "media" }),

    awful.key({}, "XF86AudioMicMute",
        function() awful.util.spawn_with_shell("pactl set-source-mute @DEFAULT_SOURCE@ toggle") end,
        { description = "mute mic", group = "media" }),
})

awful.keyboard.append_global_keybindings({
    awful.key({}, "XF86AudioPlay", function() awful.util.spawn_with_shell("playerctl play-pause") end,
        { description = "toggle play/pause", group = "media" }),

    awful.key({}, "XF86AudioPause", function() awful.util.spawn_with_shell("playerctl play-pause") end,
        { description = "toggle play/pause", group = "media" }),

    awful.key({}, "XF86AudioNext", function() awful.util.spawn_with_shell("playerctl next") end,
        { description = "next song", group = "media" }),

    awful.key({}, "XF86AudioPrev", function() awful.util.spawn_with_shell("playerctl previous") end,
        { description = "previous song", group = "media" }),
})

-- Brightness Controls
awful.keyboard.append_global_keybindings({
    awful.key({}, "XF86MonBrightnessUp", function() awful.util.spawn_with_shell("brightnessctl set +10") end,
        { description = "brightness up", group = "media" }),

    awful.key({}, "XF86MonBrightnessDown", function() awful.util.spawn_with_shell("brightnessctl set -10") end,
        { description = "brightness down", group = "media" }),
})

-- General Awesome keys
awful.keyboard.append_global_keybindings({
    awful.key({ modkey }, "s", hotkeys_popup.show_help,
        { description = "show help", group = "awesome" }),

    awful.key({ modkey, "Shift" }, "r", awesome.restart,
        { description = "reload awesome", group = "awesome" }),
})


-- Tags related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({ modkey, "Control", "Shift" }, "h", awful.tag.viewprev,
        { description = "view previous", group = "tag" }),

    awful.key({ modkey, "Control", "Shift" }, "l", awful.tag.viewnext,
        { description = "view next", group = "tag" }),

    awful.key({ modkey, }, "Escape", awful.tag.history.restore,
        { description = "go back", group = "tag" }),
})

awful.keyboard.append_global_keybindings({
    awful.key {
        modifiers   = { modkey },
        keygroup    = "numrow",
        description = "only view tag",
        group       = "tag",
        on_press    = function(index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                tag:view_only()
            end
        end,
    },

    awful.key {
        modifiers   = { modkey, "Control" },
        keygroup    = "numrow",
        description = "toggle tag",
        group       = "tag",
        on_press    = function(index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end,
    },

    awful.key {
        modifiers   = { modkey, "Shift" },
        keygroup    = "numrow",
        description = "move focused client to tag",
        group       = "tag",
        on_press    = function(index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end,
    },

    awful.key {
        modifiers   = { modkey, "Control", "Shift" },
        keygroup    = "numrow",
        description = "toggle focused client on tag",
        group       = "tag",
        on_press    = function(index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:toggle_tag(tag)
                end
            end
        end,
    },

    awful.key {
        modifiers   = { modkey },
        keygroup    = "numpad",
        description = "select layout directly",
        group       = "layout",
        on_press    = function(index)
            local t = awful.screen.focused().selected_tag
            if t then
                t.layout = t.layouts[index] or t.layout
            end
        end,
    }
})

-- Focus related keybindings (vi)
awful.keyboard.append_global_keybindings({
    awful.key({ modkey }, "h", function()
        awful.client.focus.bydirection("left")
        if client.focus then client.focus:raise() end
    end, { description = "focus left", group = "focus" }),

    awful.key({ modkey }, "j", function()
        awful.client.focus.bydirection("down")
        if client.focus then client.focus:raise() end
    end, { description = "focus down", group = "focus" }),

    awful.key({ modkey }, "k", function()
        awful.client.focus.bydirection("up")
        if client.focus then client.focus:raise() end
    end, { description = "focus up", group = "focus" }),

    awful.key({ modkey }, "l", function()
        awful.client.focus.bydirection("right")
        if client.focus then client.focus:raise() end
    end, { description = "focus right", group = "focus" }),

    awful.key({ modkey, "Shift" }, "m",
        function()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                c:activate { raise = true, context = "key.unminimize" }
            end
        end,
        { description = "restore minimized", group = "client" }),
})

-- Layout related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({ modkey, "Control" }, "h", function()
        awful.client.swap.bydirection("left")
        if client.focus then client.focus:raise() end
    end, { description = "swap left", group = "layout" }),

    awful.key({ modkey, "Control" }, "j", function()
        awful.client.swap.bydirection("down")
        if client.focus then client.focus:raise() end
    end, { description = "swap down", group = "layout" }),

    awful.key({ modkey, "Control" }, "k", function()
        awful.client.swap.bydirection("up")
        if client.focus then client.focus:raise() end
    end, { description = "swap up", group = "layout" }),

    awful.key({ modkey, "Control" }, "l", function()
        awful.client.swap.bydirection("right")
        if client.focus then client.focus:raise() end
    end, { description = "swap right", group = "layout" }),

    awful.key({ modkey, "Shift" }, "l", function() awful.tag.incmwfact(0.05) end,
        { description = "increase master width factor", group = "layout" }),

    awful.key({ modkey, "Shift" }, "h", function() awful.tag.incmwfact(-0.05) end,
        { description = "decrease master width factor", group = "layout" }),
})



client.connect_signal("request::default_keybindings", function()
    -- Resizing and moving clients
    awful.keyboard.append_client_keybindings({
    })

    awful.keyboard.append_client_keybindings({
        awful.key({ modkey, "Shift" }, "q", function(c) c:kill() end,
            { description = "close", group = "client" }),

        awful.key({ modkey }, "f",
            function(c)
                c.fullscreen = not c.fullscreen
                c:raise()
            end,
            { description = "toggle fullscreen", group = "client" }),

        awful.key({ modkey }, "space", awful.client.floating.toggle,
            { description = "toggle floating", group = "client" }),

        awful.key({ modkey }, "t", function(c) c.ontop = not c.ontop end,
            { description = "toggle keep on top", group = "client" }),

        awful.key({ modkey }, "m",
            function(c)
                -- The client currently has the input focus, so it cannot be
                -- minimized, since minimized clients can't have the focus.
                c.minimized = true
            end,
            { description = "minimize", group = "client" }),
    })
end)
