#!/bin/bash
# Network control using nmcli + fuzzel

set -euo pipefail

notify_status() {
    notify-send "Network Manager" "$1"
}

toggle_wifi() {
    STATE=$(nmcli radio wifi)
    if [ "$STATE" = "enabled" ]; then
        nmcli radio wifi off
        notify_status "WiFi Disabled"
    else
        nmcli radio wifi on
        notify_status "WiFi Enabled"
    fi
}

scan_menu() {
    notify_status "Scanning for networks..."
    nmcli dev wifi rescan 2>/dev/null

    NETWORKS=$(nmcli -t -f BARS,SSID,SECURITY dev wifi list 2>/dev/null | awk -F: '!seen[$2]++ {print $1"  "$2" ("$3")"}')

    OPT_BACK="󰌍 Back"
    MENU="$OPT_BACK\n$NETWORKS"

    SEL_NET=$(echo -e "$MENU" | fuzzel --dmenu --prompt="Select Network: " --width 50)

    if [ -z "$SEL_NET" ] || [ "$SEL_NET" = "$OPT_BACK" ]; then
        main_menu
        return
    fi

    SSID=$(echo "$SEL_NET" | sed -E 's/^[^ ]+  //' | sed -E 's/ \([^)]+\)$//')

    if nmcli connection show "$SSID" &>/dev/null; then
        notify_status "Connecting to known network: $SSID"
        if nmcli connection up "$SSID"; then
            notify_status "Connected to $SSID"
        else
            notify_status "Failed to connect to $SSID"
        fi
    else
        PASS=$(echo "" | fuzzel --dmenu --prompt="Password for $SSID: " --password --width 40)
        if [ -n "$PASS" ]; then
            notify_status "Connecting to $SSID..."
            if nmcli dev wifi connect "$SSID" password "$PASS"; then
                notify_status "Connected to $SSID"
            else
                notify_status "Connection failed"
            fi
        fi
    fi
}

saved_menu() {
    SAVED=$(nmcli -t -f NAME,TYPE connection show 2>/dev/null | grep "802-11-wireless" | cut -d: -f1 | sort)

    OPT_BACK="󰌍 Back"
    MENU="$OPT_BACK\n$SAVED"

    SEL_SAVED=$(echo -e "$MENU" | fuzzel --dmenu --prompt="Saved Networks: " --width 40)

    if [ -z "$SEL_SAVED" ] || [ "$SEL_SAVED" = "$OPT_BACK" ]; then
        main_menu
        return
    fi

    notify_status "Connecting to $SEL_SAVED..."
    if nmcli connection up "$SEL_SAVED"; then
        notify_status "Connected to $SEL_SAVED"
    else
        notify_status "Failed to connect"
    fi
}

main_menu() {
    WIFI_STATUS=$(nmcli radio wifi)
    ETH_STATUS=$(nmcli -t -f TYPE,STATE dev status 2>/dev/null | grep '^ethernet:connected' || true)

    STATUS_MSG=""

    if [ -n "$ETH_STATUS" ]; then
        ETH_CON=$(nmcli -t -f TYPE,CONNECTION dev status 2>/dev/null | grep '^ethernet' | cut -d: -f2 | head -n1)
        STATUS_MSG="Eth: $ETH_CON  "
    fi

    if [ "$WIFI_STATUS" = "enabled" ]; then
        WIFI_ICON="󰤨"
        WIFI_OPT="Disable WiFi"
        CURRENT_CON=$(nmcli -t -f active,ssid dev wifi 2>/dev/null | grep '^yes' | cut -d: -f2 || true)
        if [ -n "$CURRENT_CON" ]; then
            STATUS_MSG="${STATUS_MSG}WiFi: $CURRENT_CON"
        else
            STATUS_MSG="${STATUS_MSG}WiFi: On (Disconnected)"
        fi
    else
        WIFI_ICON="󰤭"
        WIFI_OPT="Enable WiFi"
        STATUS_MSG="${STATUS_MSG}WiFi: Off"
    fi

    OPT_TOGGLE="$WIFI_ICON $WIFI_OPT"
    OPT_SCAN="󰂰 Scan for Networks"
    OPT_SAVED="󰯂 Saved Connections"
    OPT_EDITOR="󰒓 Connection Editor"
    OPT_NMTUI="󰐝 Open NMTUI"

    MENU="$OPT_TOGGLE\n$OPT_SCAN\n$OPT_SAVED\n$OPT_EDITOR\n$OPT_NMTUI"

    CHOICE=$(echo -e "$MENU" | fuzzel --dmenu --prompt="Network ($STATUS_MSG): " --width 40)

    if [ -z "$CHOICE" ]; then
        exit 0
    fi

    case "$CHOICE" in
        "$OPT_TOGGLE")
            toggle_wifi
            main_menu
            ;;
        "$OPT_SCAN")
            scan_menu
            ;;
        "$OPT_SAVED")
            saved_menu
            ;;
        "$OPT_EDITOR")
            nm-connection-editor &
            ;;
        "$OPT_NMTUI")
            alacritty -e nmtui &
            ;;
    esac
}

main_menu
