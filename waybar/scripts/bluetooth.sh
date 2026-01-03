#!/bin/bash

# Bluetooth status script for waybar

get_status() {
    if bluetoothctl show 2>/dev/null | grep -q "Powered: yes"; then
        # Get connected devices
        devices=$(bluetoothctl devices Connected 2>/dev/null | wc -l)
        
        if [ "$devices" -gt 0 ]; then
            device_name=$(bluetoothctl devices Connected 2>/dev/null | head -n1 | cut -d' ' -f3-)
            echo "{\"text\":\"󰂯\",\"class\":\"connected\",\"tooltip\":\"Connected: $device_name\"}"
        else
            echo "{\"text\":\"󰂯\",\"class\":\"on\",\"tooltip\":\"Bluetooth On\"}"
        fi
    else
        echo "{\"text\":\"󰂲\",\"class\":\"off\",\"tooltip\":\"Bluetooth Off\"}"
    fi
}

toggle() {
    if bluetoothctl show 2>/dev/null | grep -q "Powered: yes"; then
        bluetoothctl power off
    else
        bluetoothctl power on
    fi
}

case "$1" in
    --toggle)
        toggle
        ;;
    *)
        get_status
        ;;
esac
