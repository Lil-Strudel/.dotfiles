local wallpaper = "~/.config/wallpapers/ticket-train.gif"

hl.on("hyprland.start", function()
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("find ~/.cache/awww -type f 2>/dev/null | grep -q . || { until awww query >/dev/null 2>&1; do sleep 0.1; done; awww img " .. wallpaper .. "; }")
    hl.exec_cmd("waybar")
end)
