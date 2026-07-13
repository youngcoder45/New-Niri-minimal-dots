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

# Wallpaper (random, with fallback)
WALLPAPER_DIR="$HOME/Pictures/wallpapers"
FALLBACK="$WALLPAPER_DIR/rogue.jpg"
if [ -d "$WALLPAPER_DIR" ] && [ "$(ls -A "$WALLPAPER_DIR" 2>/dev/null)" ]; then
    WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -name '*.jpg' -o -name '*.png' -o -name '*.jpeg' -o -name '*.webp' \) | shuf -n 1)
    [ -z "$WALLPAPER" ] && WALLPAPER="$FALLBACK"
else
    WALLPAPER="$FALLBACK"
fi
swaybg -i "$WALLPAPER" -m fill &

# Notifications
mako &

# Clipboard
wl-paste --watch cliphist store &

# Bar
waybar &

# Polkit
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
