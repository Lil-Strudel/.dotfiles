#!/usr/bin/env bash
# Waybar WireGuard toggle for the two NetworkManager tunnels.
# No arg  -> print status JSON (for Waybar's exec)
# home    -> toggle home tunnel (drops mgmt first)
# mgmt    -> toggle mgmt tunnel (drops home first)
# off     -> both down

HOME_CON=home-laptop
MGMT_CON=mgmt-laptop

active() { nmcli -t -f NAME,STATE connection show --active 2>/dev/null | grep -q "^$1:activated$"; }
refresh() { pkill -RTMIN+8 waybar 2>/dev/null; }

case "$1" in
  home)
    if active "$HOME_CON"; then nmcli con down "$HOME_CON"
    else nmcli con down "$MGMT_CON" 2>/dev/null; nmcli con up "$HOME_CON"; fi
    refresh; exit 0 ;;
  mgmt)
    if active "$MGMT_CON"; then nmcli con down "$MGMT_CON"
    else nmcli con down "$HOME_CON" 2>/dev/null; nmcli con up "$MGMT_CON"; fi
    refresh; exit 0 ;;
  off)
    nmcli con down "$HOME_CON" 2>/dev/null; nmcli con down "$MGMT_CON" 2>/dev/null
    refresh; exit 0 ;;
esac

if active "$HOME_CON"; then
  echo '{"text":"󰖂 home","class":"home","tooltip":"WireGuard: home tunnel up (left-click to disconnect)"}'
elif active "$MGMT_CON"; then
  echo '{"text":"󰖂 mgmt","class":"mgmt","tooltip":"WireGuard: management tunnel up (right-click to disconnect)"}'
else
  echo '{"text":"󰖂","class":"off","tooltip":"WireGuard: off\nleft-click: home  right-click: mgmt"}'
fi
