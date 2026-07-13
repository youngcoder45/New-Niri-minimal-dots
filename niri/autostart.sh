#!/bin/sh

# Niri autostart applications

# Random wallpaper from ~/Pictures/wallpapers/
WALLPAPER_DIR="$HOME/Pictures/wallpapers"
if [ -d "$WALLPAPER_DIR" ]; then
    WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -name '*.jpg' -o -name '*.png' -o -name '*.webp' \) 2>/dev/null | shuf -n1)
    if [ -n "$WALLPAPER" ]; then
        swaybg -i "$WALLPAPER" -m fill &
    fi
fi

# Notification daemon
mako &

# Clipboard history
wl-paste --watch cliphist store &

# Status bar
waybar &

# Polkit agent (needed for mounts, permissions)
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
