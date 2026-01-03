#!/bin/bash

# Media player script for waybar

STATUS=$(playerctl status 2>/dev/null)
PLAYER=$(playerctl -l 2>/dev/null | head -n1)

if [ -z "$STATUS" ] || [ "$STATUS" = "Stopped" ]; then
    echo "{\"text\":\"\",\"class\":\"stopped\",\"tooltip\":\"No media playing\"}"
    exit 0
fi

ARTIST=$(playerctl metadata artist 2>/dev/null)
TITLE=$(playerctl metadata title 2>/dev/null)

if [ -z "$ARTIST" ]; then
    TEXT="$TITLE"
else
    TEXT="$ARTIST - $TITLE"
fi

# Truncate if too long
if [ ${#TEXT} -gt 50 ]; then
    TEXT="${TEXT:0:47}..."
fi

# Escape special characters for markup AFTER truncation
TEXT=$(echo "$TEXT" | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/"/\&quot;/g; s/'\''/\&apos;/g')

if [ "$STATUS" = "Playing" ]; then
    ICON="󰐊"
    CLASS="playing"
else
    ICON="󰏤"
    CLASS="paused"
fi

echo "{\"text\":\"$ICON $TEXT\",\"class\":\"$CLASS\",\"tooltip\":\"$PLAYER: $STATUS\"}"
