#!/bin/bash
# Media player info for waybar

set -euo pipefail

if ! command -v playerctl &>/dev/null; then
    echo "{\"text\":\"\",\"class\":\"stopped\",\"tooltip\":\"playerctl not found\"}"
    exit 0
fi

STATUS=$(playerctl status 2>/dev/null || true)
PLAYER=$(playerctl -l 2>/dev/null | head -n1 || true)

if [ -z "$STATUS" ] || [ "$STATUS" = "Stopped" ]; then
    echo "{\"text\":\"\",\"class\":\"stopped\",\"tooltip\":\"No media playing\"}"
    exit 0
fi

ARTIST=$(playerctl metadata artist 2>/dev/null || true)
TITLE=$(playerctl metadata title 2>/dev/null || true)

if [ -z "$ARTIST" ]; then
    TEXT="$TITLE"
else
    TEXT="$ARTIST - $TITLE"
fi

# Truncate if too long
if [ ${#TEXT} -gt 50 ]; then
    TEXT="${TEXT:0:47}..."
fi

# Escape special characters for JSON
TEXT=$(echo "$TEXT" | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/"/\&quot;/g')

if [ "$STATUS" = "Playing" ]; then
    ICON="󰐊"
    CLASS="playing"
else
    ICON="󰏤"
    CLASS="paused"
fi

echo "{\"text\":\"$ICON $TEXT\",\"class\":\"$CLASS\",\"tooltip\":\"$PLAYER: $STATUS\"}"
