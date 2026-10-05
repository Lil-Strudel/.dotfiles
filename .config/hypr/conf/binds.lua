local M = "SUPER"

local function bind(keys, action, desc, opts)
    opts = opts or {}
    opts.description = desc
    hl.bind(keys, action, opts)
end

local dirs = { h = "left", j = "down", k = "up", l = "right" }

bind(M .. " + Return",    hl.dsp.exec_cmd("ghostty"),                                 "Terminal")
bind(M .. " + Space",     hl.dsp.exec_cmd("hyprlauncher"),                            "Launcher")
bind(M .. " + b",         hl.dsp.exec_cmd("pkill -x -SIGUSR1 waybar"),                "Toggle bar")
bind("Print",             hl.dsp.exec_cmd('g=$(slurp) && grim -g "$g" - | wl-copy'), "Screenshot region")

bind(M .. " + q", hl.dsp.window.close(), "Close window")
bind(M .. " + f", hl.dsp.window.fullscreen(), "Toggle fullscreen")
bind(M .. " + v", hl.dsp.window.float({ action = "toggle" }), "Toggle floating")

for key, dir in pairs(dirs) do
    bind(M .. " + " .. key,             hl.dsp.focus({ direction = dir }),       "Focus " .. dir)
    bind(M .. " + SHIFT + " .. key,     hl.dsp.window.move({ direction = dir }), "Move window " .. dir)
end

bind(M .. " + c",             hl.dsp.layout("swapwithmaster"),   "Swap with master")
bind(M .. " + comma",         hl.dsp.layout("mfact -0.05"),      "Master narrower")
bind(M .. " + period",        hl.dsp.layout("mfact +0.05"),      "Master wider")
bind(M .. " + bracketleft",   hl.dsp.layout("cycleprev"),        "Focus previous window")
bind(M .. " + bracketright",  hl.dsp.layout("cyclenext"),        "Focus next window")
bind(M .. " + CTRL + h",      hl.dsp.layout("orientationprev"),  "Previous master orientation")
bind(M .. " + CTRL + l",      hl.dsp.layout("orientationnext"),  "Next master orientation")

hl.bind(M .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true, description = "Drag window" })
hl.bind(M .. " + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Resize window" })

for i = 1, 10 do
    local key = i % 10
    bind(M .. " + " .. key,         hl.dsp.focus({ workspace = i }),       "Workspace " .. i)
    bind(M .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }), "Move window to workspace " .. i)
end

bind(M .. " + Tab",        hl.dsp.focus({ workspace = "previous" }), "Previous workspace")
bind(M .. " + CTRL + j",   hl.dsp.focus({ workspace = "r+1" }),      "Next workspace")
bind(M .. " + CTRL + k",   hl.dsp.focus({ workspace = "r-1" }),      "Previous-numbered workspace")
bind(M .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }),      "Next existing workspace")
bind(M .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }),      "Previous existing workspace")

bind(M .. " + r", hl.dsp.submap("resize"), "Resize mode")
hl.define_submap("resize", function()
    local step = 50
    bind("h", hl.dsp.window.resize({ x = -step, y = 0, relative = true }), "Narrower", { repeating = true })
    bind("l", hl.dsp.window.resize({ x =  step, y = 0, relative = true }), "Wider",    { repeating = true })
    bind("k", hl.dsp.window.resize({ x = 0, y = -step, relative = true }), "Shorter",  { repeating = true })
    bind("j", hl.dsp.window.resize({ x = 0, y =  step, relative = true }), "Taller",   { repeating = true })
    bind("escape", hl.dsp.submap("reset"), "Leave resize mode")
    bind("Return", hl.dsp.submap("reset"), "Leave resize mode")
end)

local exit_cmd = "command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"
bind(M .. " + Escape", hl.dsp.submap("session"), "Session mode")
hl.define_submap("session", "reset", function()
    bind("l", hl.dsp.exec_cmd("loginctl lock-session"), "Lock")
    bind("r", hl.dsp.exec_cmd("hyprctl reload"),        "Reload config")
    bind("e", hl.dsp.exec_cmd(exit_cmd),                "Exit Hyprland")
    bind("catchall", hl.dsp.submap("reset"),            "Cancel")
end)

bind(M .. " + n",         hl.dsp.exec_cmd("makoctl dismiss"),                 "Dismiss notification")
bind(M .. " + SHIFT + n", hl.dsp.exec_cmd("makoctl dismiss --all"),           "Dismiss all notifications")
bind(M .. " + u",         hl.dsp.exec_cmd("makoctl restore"),                 "Restore last notification")
bind(M .. " + SHIFT + d", hl.dsp.exec_cmd("makoctl mode -t do-not-disturb && pkill -x -RTMIN+8 waybar"), "Toggle do not disturb")

local media = { locked = true, repeating = true }
bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), "Volume up",       media)
bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      "Volume down",     media)
bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     "Mute",            { locked = true })
bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   "Mute mic",        { locked = true })
bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  "Brightness up",   media)
bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  "Brightness down", media)
bind("XF86AudioPlay",         hl.dsp.exec_cmd("playerctl play-pause"),                           "Play/pause",      { locked = true })
bind("XF86AudioPause",        hl.dsp.exec_cmd("playerctl play-pause"),                           "Play/pause",      { locked = true })
bind("XF86AudioNext",         hl.dsp.exec_cmd("playerctl next"),                                 "Next track",      { locked = true })
bind("XF86AudioPrev",         hl.dsp.exec_cmd("playerctl previous"),                             "Previous track",  { locked = true })
