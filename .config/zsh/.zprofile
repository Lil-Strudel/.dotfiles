export XDG_DATA_DIRS=$HOME/.local/share/flatpak/exports/share:${XDG_DATA_DIRS:-/usr/local/share:/usr/share}
[[ -z $WAYLAND_DISPLAY && $XDG_VTNR == 1 ]] && exec start-hyprland
