#!/bin/bash

# Network control script using nmcli and fuzzel

# Notify user
notify_status() {
    notify-send "Network Manager" "$1"
}

# WiFi Toggle
toggle_wifi() {
    STATE=$(nmcli radio wifi)
    if [ "$STATE" == "enabled" ]; then
        nmcli radio wifi off
        notify_status "WiFi Disabled"
    else
        nmcli radio wifi on
        notify_status "WiFi Enabled"
    fi
}

# Main Menu Function
main_menu() {
    # Get Current Status
    WIFI_STATUS=$(nmcli radio wifi)
    ETH_STATUS=$(nmcli -t -f TYPE,STATE dev status | grep '^ethernet:connected')

    STATUS_MSG=""

    if [ -n "$ETH_STATUS" ]; then
        ETH_CON=$(nmcli -t -f TYPE,CONNECTION dev status | grep '^ethernet' | cut -d: -f2 | head -n1)
        STATUS_MSG="Eth: $ETH_CON  "
    fi

    if [ "$WIFI_STATUS" == "enabled" ]; then
        WIFI_ICON="󰤨"
        WIFI_OPT="Disable WiFi"
        
        # Get current connection
        CURRENT_CON=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)
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

    # Options
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
            # Reload menu to show new state
            main_menu
            ;;
        "$OPT_EDITOR")
            nm-connection-editor &
            ;;
        "$OPT_NMTUI")
            alacritty -e nmtui &
            ;;
        "$OPT_SCAN")
            scan_menu
            ;;
        "$OPT_SAVED")
            saved_menu
            ;;
    esac
}

# Scan Menu Function
scan_menu() {
    notify_status "Scanning for networks..."
    
    # Rescan
    nmcli dev wifi rescan
    
    # Get list: BARS SSID SECURITY
    NETWORKS=$(nmcli -t -f BARS,SSID,SECURITY dev wifi list | awk -F: '!seen[$2]++ {print $1"  "$2" ("$3")"}')
    
    OPT_BACK="󰌍 Back"
    MENU="$OPT_BACK\n$NETWORKS"
    
    SEL_NET=$(echo -e "$MENU" | fuzzel --dmenu --prompt="Select Network: " --width 50)
    
    if [ -z "$SEL_NET" ]; then
        exit 0
    fi

    if [ "$SEL_NET" == "$OPT_BACK" ]; then
        main_menu
        return
    fi
    
    # Extract SSID
    SSID=$(echo "$SEL_NET" | sed -E 's/^[^ ]+  //' | sed -E 's/ \([^)]+\)$//')
    
    # Check if saved
    if nmcli connection show "$SSID" > /dev/null 2>&1; then
        notify_status "Connecting to known network: $SSID"
        if nmcli connection up "$SSID"; then
            notify_status "Connected to $SSID"
        else
            notify_status "Failed to connect to $SSID"
        fi
    else
        # New connection
        SEC=$(echo "$SEL_NET" | grep -o '([^)]*)')
        if [[ "$SEC" == *"--"* ]]; then
                # Open/No security
                notify_status "Connecting to open network: $SSID"
                nmcli dev wifi connect "$SSID"
        else
                # Needs password
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
    fi
}

# Saved Menu Function
saved_menu() {
    SAVED=$(nmcli -t -f NAME,TYPE connection show | grep "802-11-wireless" | cut -d: -f1 | sort)
    
    OPT_BACK="󰌍 Back"
    MENU="$OPT_BACK\n$SAVED"
    
    SEL_SAVED=$(echo -e "$MENU" | fuzzel --dmenu --prompt="Saved Networks: " --width 40)
    
    if [ -z "$SEL_SAVED" ]; then
        exit 0
    fi

    if [ "$SEL_SAVED" == "$OPT_BACK" ]; then
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

# Run Main Menu
main_menu
