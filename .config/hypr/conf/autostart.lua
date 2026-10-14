local wallpaper = "~/.config/wallpapers/ticket-train.gif"
local waybar = "pkill -x waybar; while pgrep -x waybar >/dev/null; do sleep 0.1; done; flock -n $XDG_RUNTIME_DIR/waybar.lock waybar"

hl.on("hyprland.start", function()
    hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme prefer-dark")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme Adwaita-dark")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("find ~/.cache/awww -type f 2>/dev/null | grep -q . || { until awww query >/dev/null 2>&1; do sleep 0.1; done; awww img " .. wallpaper .. "; }")
    hl.exec_cmd(waybar)
end)

hl.on("monitor.added",   function() hl.exec_cmd(waybar) end)
hl.on("monitor.removed", function() hl.exec_cmd(waybar) end)
