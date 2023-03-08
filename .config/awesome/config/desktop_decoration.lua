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
        item:get_children_by_id("tag")[1].markup = "<span foreground='" .. beautiful.fg .. "'>ur mom</span>"
    elseif #tag:clients() > 0 then
        item:get_children_by_id("tag")[1].markup = "<span foreground='" .. beautiful.fg .. "'>has stuff</span>"
    else
        item:get_children_by_id("tag")[1].markup = "<span foreground='" .. beautiful.fg .. "'>empty</span>"
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

    s.mytaglist = awful.widget.taglist {
        screen          = s,
        filter          = awful.widget.taglist.filter.all,
        style           = {
            shape = gears.shape.powerline
        },
        layout          = {
            spacing        = -12,
            spacing_widget = {
                color  = "#dddddd",
                shape  = gears.shape.powerline,
                widget = wibox.widget.separator,
            },
            layout         = wibox.layout.fixed.horizontal
        },
        widget_template = {
            {
                {
                    {
                        {
                            {
                                id     = "index_role",
                                widget = wibox.widget.textbox,
                            },
                            margins = 4,
                            widget  = wibox.container.margin,
                        },
                        bg     = "#dddddd",
                        shape  = gears.shape.circle,
                        widget = wibox.container.background,
                    },
                    {
                        {
                            id     = "icon_role",
                            widget = wibox.widget.imagebox,
                        },
                        margins = 2,
                        widget  = wibox.container.margin,
                    },
                    {
                        id     = "text_role",
                        widget = wibox.widget.textbox,
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                left   = 18,
                right  = 18,
                widget = wibox.container.margin
            },
            id              = "background_role",
            widget          = wibox.container.background,
            -- Add support for hover colors and an index label
            create_callback = function(self, c3, index, objects) --luacheck: no unused args
                self:get_children_by_id("index_role")[1].markup = "<b> " .. c3.index .. " </b>"
                self:connect_signal("mouse::enter", function()
                    if self.bg ~= "#ff0000" then
                        self.backup     = self.bg
                        self.has_backup = true
                    end
                    self.bg = "#ff0000"
                end)
                self:connect_signal("mouse::leave", function()
                    if self.has_backup then self.bg = self.backup end
                end)
            end,
            update_callback = function(self, c3, index, objects) --luacheck: no unused args
                self:get_children_by_id("index_role")[1].markup = "<b> " .. c3.index .. " </b>"
            end,
        },
        buttons         = taglist_buttons
    }

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
        margins  = dpi(5),
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
