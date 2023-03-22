local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local base_path = gfs.get_configuration_dir()

local modkey = C.modkey or "Mod4"

local battery_widget = require("ui.bar.battery")

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
    local outline_color
    if tag.selected then
        outline_color = beautiful.fg_focus
    else
        outline_color = beautiful.fg_normal
    end

    local fill_color
    if #tag:clients() > 0 then
        fill_color = outline_color
    else
        fill_color = "#0000"
    end


    item:get_children_by_id("icon_role")[1].stylesheet = "" ..
    "rect { stroke: " .. outline_color .. " }" ..
    "circle { fill: " .. fill_color .. " }"
end


local gap = beautiful.useless_gap * 2

screen.connect_signal("request::desktop_decoration", function(s)
    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5" }, s, awful.layout.layouts[1])

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
    s.mytaglist = awful.widget.taglist {
        screen          = s,
        filter          = awful.widget.taglist.filter.all,
        buttons         = taglist_buttons,
        style           = {
            spacing = dpi(3),
        },
        widget_template = {
            {
                widget = wibox.container.margin,
                margins = dpi(4),
                {
                    id = 'icon_role',
                    image = base_path .. "ui/bar/resources/diamond.svg",
                    valign = 'center',
                    halign = 'center',
                    widget = wibox.widget.imagebox,
                }
            },
            widget = wibox.container.background,
            create_callback = function(self, c3, index, objects)
                update_tag(self, c3, index)
            end,
            update_callback = function(self, c3, index, objects)
                update_tag(self, c3, index)
            end
        },
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen          = s,
        filter          = awful.widget.tasklist.filter.currenttags,
        buttons         = {
            awful.button({}, 1, function(c)
                c:activate { context = "tasklist", action = "toggle_minimization" }
            end),
            awful.button({}, 3, function() awful.menu.client_list { theme = { width = 250 } } end),
            awful.button({}, 4, function() awful.client.focus.byidx(-1) end),
            awful.button({}, 5, function() awful.client.focus.byidx(1) end),
        },
        style           = {
            shape = gears.shape.circle,
        },
        layout          = {
            spacing = dpi(3),
            layout = wibox.layout.fixed.horizontal
        },
        widget_template = {
            widget = wibox.container.margin,
            margins = dpi(4),
            {
                {
                    {
                        id = "icon_role",
                        widget = wibox.widget.imagebox,
                    },
                    margins = dpi(0),
                    widget = wibox.container.margin
                },
                id = "background_role",
                widget = wibox.container.background
            }
        }
    }

    s.mybatterywidget = battery_widget()

    -- Create the "wibars"
    -- The reason I am using popups is because they automagically set their
    -- width based on the child widget
    s.leftpopup  = awful.popup {
        screen = s,
        placement = function(c, args)
            args.offset = {x = gap, y = gap}
            return awful.placement.top_left(c,args)
        end,
        maximum_height = dpi(25),
        bg = beautiful.bg_normal,
        widget = s.mytaglist,
    }

    s.leftpopup:struts({top = s.leftpopup.maximum_height + gap})

    s.leftsearchpopup  = awful.popup {
        screen = s,
        placement = function(c, args)
            return awful.placement.next_to(c, 
            {
                preferred_positions = "right",
                preferred_anchors = "middle",
                geometry =  s.leftpopup,
                offset = {x = gap}
            })
        end,
        maximum_height = dpi(25),
        bg = beautiful.bg_normal,
        widget = {
                widget = wibox.container.margin,
                margins = dpi(6),
                {
                    id = 'icon_role',
                    image = base_path .. "ui/bar/resources/search.svg",
                    valign = 'center',
                    halign = 'center',
                    widget = wibox.widget.imagebox,
                    stylesheet =  "svg { fill: " .. beautiful.fg_normal .. " }"                 }
        },
    }

    s.leftsearchpopup:struts({top = s.leftsearchpopup.maximum_height + gap})
   
    s.middlepopup  = awful.popup {
        screen = s,
        placement = function(c, args)
            args.offset = {y = gap}
            return awful.placement.top(c,args)
        end,
        maximum_height = dpi(25),
        bg = beautiful.bg_normal,
        widget = s.mytasklist 
    }

    s.middlepopup:struts({top = s.leftpopup.maximum_height + gap})

    s.rightpopup  = awful.popup {
        screen = s,
        placement = function(c, args)
            args.offset = {x = -gap, y = gap}
            return awful.placement.top_right(c,args)
        end,
        maximum_height = dpi(25),
        bg = beautiful.bg_normal,
        widget   = {
            widget = wibox.container.margin,
            margins = dpi(4),
            {
                layout = wibox.layout.fixed.horizontal,
                spacing = dpi(3),
                s.mybatterywidget,
                s.mylayoutbox,
            }
        }
    }

    s.rightpopup:struts({top = s.leftpopup.maximum_height + gap})
end)
