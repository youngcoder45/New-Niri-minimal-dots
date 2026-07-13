#!/bin/bash
# Battery info display

set -euo pipefail

BATTERY="/sys/class/power_supply/BAT0"

if [ ! -d "$BATTERY" ]; then
    notify-send "Battery Info" "No battery found"
    exit 1
fi

CAPACITY=$(cat "$BATTERY/capacity" 2>/dev/null || echo "N/A")
STATUS=$(cat "$BATTERY/status" 2>/dev/null || echo "Unknown")
ENERGY_NOW=$(cat "$BATTERY/energy_now" 2>/dev/null || echo "0")
POWER_NOW=$(cat "$BATTERY/power_now" 2>/dev/null || echo "0")
VOLTAGE=$(cat "$BATTERY/voltage_now" 2>/dev/null || echo "0")

ENERGY_WH=$(echo "scale=2; $ENERGY_NOW / 1000000" | bc 2>/dev/null || echo "N/A")
POWER_W=$(echo "scale=2; $POWER_NOW / 1000000" | bc 2>/dev/null || echo "N/A")
VOLTAGE_V=$(echo "scale=2; $VOLTAGE / 1000000" | bc 2>/dev/null || echo "N/A")

notify-send "Battery Information" \
    "Status: $STATUS\nCapacity: $CAPACITY%\nEnergy: ${ENERGY_WH}Wh\nPower: ${POWER_W}W\nVoltage: ${VOLTAGE_V}V"
