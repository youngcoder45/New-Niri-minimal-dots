#!/bin/sh

# Cursor
export XCURSOR_THEME="Bibata-Modern-Classic"
export XCURSOR_SIZE=24
export XCURSOR_PATH="$HOME/.config/niri:$HOME/.icons:$HOME/.local/share/icons:/usr/share/icons"

# CRITICAL ENV (FIXED)
export XDG_CURRENT_DESKTOP=niri
export XDG_SESSION_DESKTOP=niri
export XDG_SESSION_TYPE=wayland
export GTK_USE_PORTAL=1

# Export to DBus (REQUIRED)
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP &

sh -c 'while ! busctl --user status org.gnome.Mutter.ScreenCast >/dev/null 2>&1; do sleep 0.2; done; pkill -f xdg-desktop-portal-gnome' &

# Wallpaper
swaybg -i "$HOME/Pictures/wallpapers/forest_dark_winter.jpg" -m fill &

# Notifications
mako &

# Clipboard
wl-paste --watch cliphist store &

# Bar
waybar &

# Polkit
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
