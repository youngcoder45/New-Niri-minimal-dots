#!/bin/bash
# Waybar launcher with warning suppression

set -euo pipefail

export NO_AT_BRIDGE=1
export GDK_BACKEND=wayland

killall waybar 2>/dev/null || true

waybar 2>&1 | grep -v "dbind-WARNING" | grep -v "Unable to load.*cursor" | grep -v "Status Notifier Item" &
