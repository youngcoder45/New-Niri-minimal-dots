#!/bin/bash
# Weather display for waybar using wttr.in

set -euo pipefail

LOCATION="${WEATHER_LOCATION:-}"
CACHE_FILE="/tmp/waybar-weather-cache"
CACHE_TIME=1800

get_weather() {
    if [ -f "$CACHE_FILE" ]; then
        CACHE_AGE=$(($(date +%s) - $(stat -c %Y "$CACHE_FILE" 2>/dev/null || echo 0)))
        if [ "$CACHE_AGE" -lt "$CACHE_TIME" ]; then
            cat "$CACHE_FILE"
            return
        fi
    fi

    WEATHER=$(curl -sf "wttr.in/${LOCATION}?format=%c+%t" 2>/dev/null || true)

    if [ -n "$WEATHER" ]; then
        echo "$WEATHER" > "$CACHE_FILE"
        echo "$WEATHER"
    else
        echo "󰖐 N/A"
    fi
}

show_detailed() {
    alacritty -e sh -c "curl wttr.in/${LOCATION}; read" &
}

case "${1:-}" in
    --detailed)
        show_detailed
        ;;
    *)
        WEATHER_TEXT=$(get_weather)
        # Escape quotes for JSON
        WEATHER_TEXT="${WEATHER_TEXT//\"/\\\"}"
        echo "{\"text\":\"$WEATHER_TEXT\",\"tooltip\":\"Click for detailed weather\"}"
        ;;
esac
