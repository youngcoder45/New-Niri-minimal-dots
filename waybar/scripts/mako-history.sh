#!/usr/bin/env bash

# Fuzzel Mako Notification History & Control Center
# Shows notification history and allows actions

set -euo pipefail

# Icons
ICON_CLEAR="󰎟"
ICON_DISMISS="󰂛"
ICON_RESTORE="󰃢"
ICON_EMPTY="󰂚"
ICON_NOTIF="󰵅"
ICON_DND="󰂛"

# Colors
SEPARATOR="─────────────────────────────────────"

# Parse and format notifications from makoctl history
format_notifications() {
    # Get history and parse it
    makoctl history 2>/dev/null | python3 << 'EOF'
import sys
import re

# Read all input
text = sys.stdin.read()

# Parse notifications using regex
# Format: "Notification N: Summary"
notifications = []
current_notif = {}

for line in text.split('\n'):
    line = line.strip()
    
    if line.startswith('Notification '):
        # Save previous notification
        if current_notif:
            notifications.append(current_notif)
        
        # Start new notification
        match = re.match(r'Notification \d+: (.+)', line)
        if match:
            current_notif = {'summary': match.group(1), 'app': 'Unknown'}
    
    elif line.startswith('App name: '):
        current_notif['app'] = line.replace('App name: ', '')

# Add last notification
if current_notif:
    notifications.append(current_notif)

# Print formatted notifications
for notif in notifications[:20]:  # Limit to 20 most recent
    app = notif.get('app', 'Unknown')
    summary = notif.get('summary', 'No summary')
    
    # Truncate long text
    if len(summary) > 60:
        summary = summary[:57] + '...'
    if len(app) > 20:
        app = app[:17] + '...'
    
    print(f"󰵅 {app}: {summary}")
EOF
}

# Build fuzzel menu
build_menu() {
    # Action buttons at top
    echo "$ICON_CLEAR  Clear All Notifications"
    echo "$ICON_DISMISS  Dismiss Visible Notifications"
    echo "$ICON_RESTORE  Restore Last Notification"
    echo "$ICON_DND  Toggle Do Not Disturb"
    echo "$SEPARATOR"
    
    # Get formatted notifications
    local notifications
    notifications=$(format_notifications)
    
    if [ -z "$notifications" ]; then
        echo "$ICON_EMPTY  No notification history"
    else
        # Count and show
        local count
        count=$(echo "$notifications" | wc -l)
        echo "📜 Notification History ($count)"
        echo "$SEPARATOR"
        echo "$notifications"
    fi
}

# Show fuzzel menu and get selection
show_menu() {
    local menu="$1"
    
    echo "$menu" | fuzzel \
        --dmenu \
        --lines=20 \
        --width=60 \
        --prompt="Notifications: " \
        --line-height=25 \
        --font="monospace:size=11" 2>/dev/null || true
}

# Execute action based on selection
execute_action() {
    local selection="$1"
    
    case "$selection" in
        "$ICON_CLEAR"*)
            makoctl dismiss -a
            notify-send -u low "Notifications" "All notifications cleared"
            ;;
        "$ICON_DISMISS"*)
            makoctl dismiss
            notify-send -u low "Notifications" "Visible notifications dismissed"
            ;;
        "$ICON_RESTORE"*)
            makoctl restore
            notify-send -u low "Notifications" "Last notification restored"
            ;;
        "$ICON_DND"*)
            makoctl mode -t dnd
            sleep 0.2
            if makoctl mode 2>/dev/null | grep -q "do-not-disturb"; then
                notify-send -u low "Do Not Disturb" "Enabled 🔕"
            else
                notify-send -u low "Do Not Disturb" "Disabled 🔔"
            fi
            ;;
        "$SEPARATOR"|"$ICON_EMPTY"*|"📜"*)
            # Do nothing for separators or headers
            :
            ;;
        "󰵅 "*)
            # Selected a notification - copy to clipboard
            local text="${selection#󰵅 }"
            echo "$text" | wl-copy 2>/dev/null || echo "$text" | xclip -selection clipboard 2>/dev/null || true
            notify-send -u low "Copied" "Notification copied to clipboard"
            ;;
        *)
            # Unknown selection
            :
            ;;
    esac
}

# Main function
main() {
    # Check if makoctl is available
    if ! command -v makoctl &> /dev/null; then
        notify-send -u critical "Error" "makoctl not found. Is mako installed?"
        exit 1
    fi
    
    # Check if fuzzel is available
    if ! command -v fuzzel &> /dev/null; then
        notify-send -u critical "Error" "fuzzel not found"
        exit 1
    fi
    
    # Build menu
    local menu
    menu=$(build_menu)
    
    # Show menu and get selection
    local selection
    selection=$(show_menu "$menu")
    
    # Execute action if something was selected
    if [ -n "$selection" ]; then
        execute_action "$selection"
    fi
}

# Run main function
main
