#!/bin/bash

# Volume control script using wpctl and fuzzel

# Get current volume and mute status
VOL_INFO=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
VOL_LEVEL=$(echo "$VOL_INFO" | awk '{print $2 * 100}' | cut -d'.' -f1)
MUTE_STATUS=$(echo "$VOL_INFO" | grep "MUTED")

if [ -n "$MUTE_STATUS" ]; then
    ICON="󰝟"
    STATUS="Muted"
else
    ICON="󰕾"
    STATUS="${VOL_LEVEL}%"
fi

# Get list of sinks for output selection
# We use pactl for easier parsing if available, otherwise we skip sink selection or try wpctl
# Assuming Pipewire, pactl usually works via pipewire-pulse
SINKS=$(pactl list sinks short 2>/dev/null | cut -f1,2)

# Options
OPT_MUTE="󰝟 Toggle Mute"
OPT_VOL_100=" Set Volume 100%"
OPT_VOL_50=" Set Volume 50%"
OPT_VOL_0=" Set Volume 0%"
OPT_SETTINGS="󰆓 Open Audio Settings"

# Build menu
MENU="$OPT_MUTE\n$OPT_VOL_100\n$OPT_VOL_50\n$OPT_VOL_0\n$OPT_SETTINGS"

if [ -n "$SINKS" ]; then
    MENU="$MENU\n──────────────────\n$SINKS"
fi

# Show Fuzzel
CHOICE=$(echo -e "$MENU" | fuzzel --dmenu --prompt="Volume ($STATUS): " --width 40)

if [ -z "$CHOICE" ]; then
    exit 0
fi

case "$CHOICE" in
    "$OPT_MUTE")
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        ;;
    "$OPT_VOL_100")
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 1.0
        ;;
    "$OPT_VOL_50")
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.5
        ;;
    "$OPT_VOL_0")
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.0
        ;;
    "$OPT_SETTINGS")
        pavucontrol &
        ;;
    *)
        # Handle sink selection
        # CHOICE format: "ID name"
        SINK_ID=$(echo "$CHOICE" | awk '{print $1}')
        if [[ "$SINK_ID" =~ ^[0-9]+$ ]]; then
            wpctl set-default "$SINK_ID"
            notify-send "Audio" "Switched output to sink $SINK_ID"
        fi
        ;;
esac
