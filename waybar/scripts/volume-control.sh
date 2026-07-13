#!/bin/bash
# Volume control using wpctl + fuzzel

set -euo pipefail

VOL_INFO=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null || true)
VOL_LEVEL=$(echo "$VOL_INFO" | awk '{print int($2 * 100)}')
MUTE_STATUS=$(echo "$VOL_INFO" | grep -c "MUTED" || true)

if [ "$MUTE_STATUS" -gt 0 ]; then
    ICON="󰝟"
    STATUS="Muted"
else
    ICON="󰕾"
    STATUS="${VOL_LEVEL}%"
fi

SINKS=$(pactl list sinks short 2>/dev/null | cut -f1,2 || true)

OPT_MUTE="󰝟 Toggle Mute"
OPT_VOL_100=" Set Volume 100%"
OPT_VOL_50=" Set Volume 50%"
OPT_VOL_0=" Set Volume 0%"
OPT_SETTINGS="󰆓 Open Audio Settings"

MENU="$OPT_MUTE\n$OPT_VOL_100\n$OPT_VOL_50\n$OPT_VOL_0\n$OPT_SETTINGS"

if [ -n "$SINKS" ]; then
    MENU="$MENU\n──────────────────\n$SINKS"
fi

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
        SINK_ID=$(echo "$CHOICE" | awk '{print $1}')
        if [[ "$SINK_ID" =~ ^[0-9]+$ ]]; then
            wpctl set-default "$SINK_ID"
            notify-send "Audio" "Switched output to sink $SINK_ID"
        fi
        ;;
esac
