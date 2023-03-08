local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local modkey = C.modkey or "Mod4"

-- {{{ Wibar

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- Create a textclock widget
mytextclock = wibox.widget.textclock()


local taglist_buttons = {
            awful.button({}, 1, function(t) t:view_only() end),
            awful.button({ modkey }, 1, function(t)
                if client.focus then
                    client.focus:move_to_tag(t)
                end
            end),
            awful.button({}, 3, awful.tag.viewtoggle),
            awful.button({ modkey }, 3, function(t)
                if client.focus then
                    client.focus:toggle_tag(t)
                end
            end),
            awful.button({}, 4, function(t) awful.tag.viewprev(t.screen) end),
            awful.button({}, 5, function(t) awful.tag.viewnext(t.screen) end),
        }


local function update_tag(item, tag, index)
	if tag.selected then
		item:get_children_by_id("tag")[1].markup = "<span foreground='"..beautiful.fg.."'>ur mom</span>"
	elseif #tag:clients() > 0 then 
		item:get_children_by_id("tag")[1].markup = "<span foreground='"..beautiful.fg.."'>has stuff</span>"
	else
		item:get_children_by_id("tag")[1].markup = "<span foreground='"..beautiful.fg.."'>empty</span>"
	end
end


screen.connect_signal("request::desktop_decoration", function(s)
    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox {
        screen  = s,
        buttons = {
            awful.button({}, 1, function() awful.layout.inc(1) end),
            awful.button({}, 3, function() awful.layout.inc(-1) end),
            awful.button({}, 4, function() awful.layout.inc(-1) end),
            awful.button({}, 5, function() awful.layout.inc(1) end),
        }
    }

    -- Create a taglist widget
    


    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = {
            awful.button({}, 1, function(c)
                c:activate { context = "tasklist", action = "toggle_minimization" }
            end),
            awful.button({}, 3, function() awful.menu.client_list { theme = { width = 250 } } end),
            awful.button({}, 4, function() awful.client.focus.byidx(-1) end),
            awful.button({}, 5, function() awful.client.focus.byidx(1) end),
        }
    }

    function round_wibox_shape(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, 5)
    end

    -- Create the wibox
    s.mywibox = awful.wibar {
        position = "top",
        screen   = s,
        bg       = "#0000",
	margins = dpi(5),
        widget   = {
            expand = "none",
            layout = wibox.layout.align.horizontal,
            {
                widget = wibox.container.background,
                bg = "#ff0000",
                shape = round_wibox_shape,
                {
			layout = wibox.layout.fixed.horizontal,
			s.mytaglist,
			s.mypromptbox,
                }
            },
            {
                widget = wibox.container.background,
                bg = "#ff0000",
                shape = round_wibox_shape,
                {
                        layout = wibox.layout.fixed.horizontal,
                        s.mytasklist,
                }
            },
            {
                widget = wibox.container.background,
                bg = "#ff0000",
                shape = round_wibox_shape,
                {
                        layout = wibox.layout.fixed.horizontal,
                        mykeyboardlayout,
                        wibox.widget.systray(),
                        mytextclock,
                        s.mylayoutbox,
                },
            }
        }
    }
end)

-- }}}
