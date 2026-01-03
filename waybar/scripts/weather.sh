#!/bin/bash

# Weather script for waybar using wttr.in

LOCATION="${WEATHER_LOCATION:-}"  # Set your location or leave empty for auto-detect
CACHE_FILE="/tmp/waybar-weather-cache"
CACHE_TIME=1800  # 30 minutes

get_weather() {
    if [ -f "$CACHE_FILE" ]; then
        CACHE_AGE=$(($(date +%s) - $(stat -c %Y "$CACHE_FILE")))
        if [ $CACHE_AGE -lt $CACHE_TIME ]; then
            cat "$CACHE_FILE"
            return
        fi
    fi

    # Get weather data
    WEATHER=$(curl -sf "wttr.in/${LOCATION}?format=%c+%t" 2>/dev/null)
    
    if [ $? -eq 0 ] && [ -n "$WEATHER" ]; then
        echo "$WEATHER" > "$CACHE_FILE"
        echo "$WEATHER"
    else
        echo "󰖐 N/A"
    fi
}

show_detailed() {
    alacritty -e sh -c "curl wttr.in/${LOCATION}; read"
}

case "$1" in
    --detailed)
        show_detailed
        ;;
    *)
        WEATHER_TEXT=$(get_weather)
        echo "{\"text\":\"$WEATHER_TEXT\",\"tooltip\":\"Click for detailed weather\"}"
        ;;
esac
