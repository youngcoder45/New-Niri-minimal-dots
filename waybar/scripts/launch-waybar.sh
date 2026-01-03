#!/bin/bash

# Suppress GTK accessibility and cursor warnings
export NO_AT_BRIDGE=1
export GDK_BACKEND=wayland

# Kill any existing waybar instances
killall waybar 2>/dev/null

# Launch waybar and filter out non-critical warnings
waybar 2>&1 | grep -v "dbind-WARNING" | grep -v "Unable to load.*cursor" | grep -v "Status Notifier Item" &
