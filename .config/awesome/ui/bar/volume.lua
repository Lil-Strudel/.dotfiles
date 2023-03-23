-------------------------------------------------
-- A purely pactl-based volume widget based on the original Volume widget
-- More details could be found here:
-- https://github.com/streetturtle/awesome-wm-widgets/tree/master/pactl-widget

-- @author Stefan Huber
-- @copyright 2023 Stefan Huber
-------------------------------------------------

local awful = require("awful")
local wibox = require("wibox")
local spawn = require("awful.spawn")
local gears = require("gears")
local beautiful = require("beautiful")
local gfs = gears.filesystem
local dpi = beautiful.xresources.apply_dpi

local volume_widget = {}

local base_path = gfs.get_configuration_dir()

local ICON_DIR = base_path .. 'ui/bar/resources/volume/'

function volume_widget.get_widget(widgets_args)
    local args = widgets_args or {}

    local icon_dir = args.icon_dir or ICON_DIR

    return wibox.widget {
        {
            widget = wibox.container.margin,
            margins = dpi(1),
            
        {
            id = "icon",
            resize = true,
            widget = wibox.widget.imagebox,
            stylesheet = "" ..
            "path { fill: " .. beautiful.fg_normal .. " }"
        },
    },
        valign = 'center',
        layout = wibox.container.place,
        set_volume_level = function(self, new_value)
            local volume_icon_name
            if self.is_muted then
                volume_icon_name = 'audio-volume-muted-symbolic'
            else
                local new_value_num = tonumber(new_value)
                if (new_value_num >= 0 and new_value_num < 33) then
                    volume_icon_name="audio-volume-low-symbolic"
                elseif (new_value_num < 66) then
                    volume_icon_name="audio-volume-medium-symbolic"
                else
                    volume_icon_name="audio-volume-high-symbolic"
                end
            end
            self:get_children_by_id('icon')[1]:set_image(icon_dir .. volume_icon_name .. '.svg')
        end,
        mute = function(self)
            self.is_muted = true
            self:get_children_by_id('icon')[1]:set_image(icon_dir .. 'audio-volume-muted-symbolic.svg')
        end,
        unmute = function(self)
            self.is_muted = false
        end
    }
end


local utils = {}

function utils.trim(str)
    return string.match(str, "^%s*(.-)%s*$")
end

function utils.split(string_to_split, separator)
    if separator == nil then separator = "%s" end
    local t = {}

    for str in string.gmatch(string_to_split, "([^".. separator .."]+)") do
        table.insert(t, str)
    end

    return t
end

function utils.popen_and_return(cmd)
    local handle = io.popen(cmd)
    local result = handle:read("*a")
    handle:close()

    return result
end

local pactl = {}


function pactl.volume_increase(device, step)
    spawn('pactl set-sink-volume ' .. device .. ' +' .. step .. '%', false)
end

function pactl.volume_decrease(device, step)
    spawn('pactl set-sink-volume ' .. device .. ' -' .. step .. '%', false)
end

function pactl.mute_toggle(device)
    spawn('pactl set-sink-mute ' .. device .. ' toggle', false)
end

function pactl.get_volume(device)
    local stdout = utils.popen_and_return('pactl get-sink-volume ' .. device)

    local volsum, volcnt = 0, 0
    for vol in string.gmatch(stdout, "(%d?%d?%d)%%") do
        vol = tonumber(vol)
        if vol ~= nil then
            volsum = volsum + vol
            volcnt = volcnt + 1
        end
    end

    if volcnt == 0 then
        return nil
    end

    return volsum / volcnt
end

function pactl.get_mute(device)
    local stdout = utils.popen_and_return('pactl get-sink-mute ' .. device)
    if string.find(stdout, "yes") then
        return true
    else
        return false
    end
end

function pactl.get_sinks_and_sources()
    local default_sink = utils.trim(utils.popen_and_return('pactl get-default-sink'))
    local default_source = utils.trim(utils.popen_and_return('pactl get-default-source'))

    local sinks = {}
    local sources = {}

    local device
    local ports
    local key
    local value
    local in_section

    for line in utils.popen_and_return('pactl list'):gmatch('[^\r\n]*') do

        if string.match(line, '^%a+ #') then
            in_section = nil
        end

        local is_sink_line = string.match(line, '^Sink #')
        local is_source_line = string.match(line, '^Source #')

        if is_sink_line or is_source_line then
            in_section = "main"

            device = {
                id = line:match('#(%d+)'),
                is_default = false
            }
            if is_sink_line then
                table.insert(sinks, device)
            else
                table.insert(sources, device)
            end
        end

        -- Found a new subsection
        if in_section ~= nil and string.match(line, '^\t%a+:$') then
            in_section = utils.trim(line):lower()
            in_section = string.sub(in_section, 1, #in_section-1)

            if in_section == 'ports' then
                ports = {}
                device['ports'] = ports
            end
        end

        -- Found a key-value pair
        if string.match(line, "^\t*[^\t]+: ") then
            local t = utils.split(line, ':')
            key = utils.trim(t[1]):lower():gsub(' ', '_')
            value = utils.trim(t[2])
        end

        -- Key value pair on 1st level
        if in_section ~= nil and string.match(line, "^\t[^\t]+: ") then
            device[key] = value

            if key == "name" and (value == default_sink or value == default_source) then
                device['is_default'] = true
            end
        end

        -- Key value pair in ports section
        if in_section == "ports" and string.match(line, "^\t\t[^\t]+: ") then
            ports[key] = value
        end
    end

    return sinks, sources
end

function pactl.set_default(type, name)
    spawn('pactl set-default-' .. type .. ' "' .. name .. '"', false)
end

local volume = {}

local rows  = { layout = wibox.layout.fixed.vertical }

local popup = awful.popup{
    bg = beautiful.bg_normal,
    ontop = true,
    visible = false,
    shape = gears.shape.rounded_rect,
    border_width = 1,
    border_color = beautiful.bg_focus,
    maximum_width = 400,
    offset = { y = 5 },
    widget = {}
}

local function build_main_line(device)
    if device.active_port ~= nil and device.ports[device.active_port] ~= nil then
        return device.description .. ' · ' .. utils.split(device.ports[device.active_port], " ")[1]
    else
        return device.description
    end
end

local function build_rows(devices, on_checkbox_click, device_type)
    local device_rows  = { layout = wibox.layout.fixed.vertical }
    for _, device in pairs(devices) do

        local checkbox = wibox.widget {
            checked = device.is_default,
            color = beautiful.bg_normal,
            paddings = 2,
            shape = gears.shape.circle,
            forced_width = 20,
            forced_height = 20,
            check_color = beautiful.fg_urgent,
            widget = wibox.widget.checkbox
        }

        checkbox:connect_signal("button::press", function()
            pactl.set_default(device_type, device.name)
            on_checkbox_click()
        end)

        local row = wibox.widget {
            {
                {
                    {
                        checkbox,
                        valign = 'center',
                        layout = wibox.container.place,
                    },
                    {
                        {
                            text = build_main_line(device),
                            align = 'left',
                            widget = wibox.widget.textbox
                        },
                        left = 10,
                        layout = wibox.container.margin
                    },
                    spacing = 8,
                    layout = wibox.layout.align.horizontal
                },
                margins = 4,
                layout = wibox.container.margin
            },
            bg = beautiful.bg_normal,
            widget = wibox.container.background
        }

        row:connect_signal("mouse::enter", function(c) c:set_bg(beautiful.bg_focus) end)
        row:connect_signal("mouse::leave", function(c) c:set_bg(beautiful.bg_normal) end)

        local old_cursor, old_wibox
        row:connect_signal("mouse::enter", function()
            local wb = mouse.current_wibox
            old_cursor, old_wibox = wb.cursor, wb
            wb.cursor = "hand1"
        end)
        row:connect_signal("mouse::leave", function()
            if old_wibox then
                old_wibox.cursor = old_cursor
                old_wibox = nil
            end
        end)

        row:connect_signal("button::press", function()
            pactl.set_default(device_type, device.name)
            on_checkbox_click()
        end)

        table.insert(device_rows, row)
    end

    return device_rows
end

local function build_header_row(text)
    return wibox.widget{
        {
            markup = "<b>" .. text .. "</b>",
            align = 'center',
            widget = wibox.widget.textbox
        },
        bg = beautiful.bg_normal,
        widget = wibox.container.background
    }
end

local function rebuild_popup()
    for i = 0, #rows do
        rows[i]=nil
    end

    local sinks, sources = pactl.get_sinks_and_sources()
    table.insert(rows, build_header_row("SINKS"))
    table.insert(rows, build_rows(sinks, function() rebuild_popup() end, "sink"))
    table.insert(rows, build_header_row("SOURCES"))
    table.insert(rows, build_rows(sources, function() rebuild_popup() end, "source"))

    popup:setup(rows)
end

local function worker(user_args)

    local args = user_args or {}

    local mixer_cmd = args.mixer_cmd or 'pavucontrol'
    local widget_type = args.widget_type
    local refresh_rate = args.refresh_rate or 1
    local step = args.step or 5
    local device = args.device or '@DEFAULT_SINK@'
    local tooltip = args.tooltip or false

    volume.widget = volume_widget.get_widget(args)

    local function update_graphic(widget)
        local vol = pactl.get_volume(device)
        if vol ~= nil then
            widget:set_volume_level(vol)
        end

        if pactl.get_mute(device) then
            widget:mute()
        else
            widget:unmute()
        end
    end

    function volume:inc(s)
        pactl.volume_increase(device, s or step)
        update_graphic(volume.widget)
    end

    function volume:dec(s)
        pactl.volume_decrease(device, s or step)
        update_graphic(volume.widget)
    end

    function volume:toggle()
        pactl.mute_toggle(device)
        update_graphic(volume.widget)
    end

    function volume:popup()
        if popup.visible then
            popup.visible = not popup.visible
        else
            rebuild_popup()
            popup:move_next_to(mouse.current_widget_geometry)
        end
    end

    function volume:mixer()
        if mixer_cmd then
            spawn(mixer_cmd)
        end
    end

    volume.widget:buttons(
            awful.util.table.join(
                    awful.button({}, 1, function() volume:toggle() end),
                    awful.button({}, 2, function() volume:mixer() end),
                    awful.button({}, 3, function() volume:popup() end),
                    awful.button({}, 4, function() volume:inc() end),
                    awful.button({}, 5, function() volume:dec() end)
            )
    )

    gears.timer {
        timeout   = refresh_rate,
        call_now  = true,
        autostart = true,
        callback  = function()
            update_graphic(volume.widget)
        end
    }

    if tooltip then
        awful.tooltip {
            objects        = { volume.widget },
            timer_function = function()
                return pactl.get_volume(device) .. " %"
            end,
        }
    end

    return volume.widget
end


return setmetatable(volume, { __call = function(_, ...) return worker(...) end })
