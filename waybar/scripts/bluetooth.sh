#!/bin/bash
# Bluetooth status for waybar

set -euo pipefail

if ! command -v bluetoothctl &>/dev/null; then
    echo '{"text":"󰂲","class":"disabled","tooltip":"bluetoothctl not found"}'
    exit 0
fi

POWER_STATE=$(bluetoothctl show | grep "Powered: yes" || true)

if [ -z "$POWER_STATE" ]; then
    echo '{"text":"󰂲","class":"disabled","tooltip":"Bluetooth OFF"}'
    exit 0
fi

CONNECTED=$(bluetoothctl devices | while read -r line; do
    MAC=$(echo "$line" | awk '{print $2}')
    if bluetoothctl info "$MAC" 2>/dev/null | grep -q "Connected: yes"; then
        echo "$line"
    fi
done | head -n1)

if [ -z "$CONNECTED" ]; then
    echo '{"text":"󰂯","class":"on","tooltip":"Bluetooth ON (No devices)"}'
else
    DEV_NAME=$(echo "$CONNECTED" | cut -d ' ' -f 3-)
    echo "{\"text\":\"󰂰\",\"class\":\"connected\",\"tooltip\":\"Connected: $DEV_NAME\"}"
fi
