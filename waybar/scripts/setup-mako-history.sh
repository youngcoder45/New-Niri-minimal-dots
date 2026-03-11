#!/usr/bin/env bash

# Quick Install & Test for Mako History Script
# Run this to set everything up and test

set -e

echo "╔════════════════════════════════════════╗"
echo "║  Mako Notification History Setup       ║"
echo "╚════════════════════════════════════════╝"
echo ""

# Check dependencies
echo "📦 Checking dependencies..."
deps=("mako" "makoctl" "fuzzel" "python3" "wl-copy" "notify-send")
missing=()

for dep in "${deps[@]}"; do
    if command -v "$dep" &> /dev/null; then
        echo "  ✓ $dep"
    else
        echo "  ✗ $dep (missing)"
        missing+=("$dep")
    fi
done

if [ ${#missing[@]} -gt 0 ]; then
    echo ""
    echo "⚠️  Missing dependencies: ${missing[*]}"
    echo "Install with: sudo pacman -S mako fuzzel wl-clipboard"
    exit 1
fi

echo ""
echo "✓ All dependencies installed!"
echo ""

# Check if mako is running
echo "🔍 Checking if mako is running..."
if pgrep -x mako > /dev/null; then
    echo "  ✓ Mako is running"
else
    echo "  ✗ Mako is not running"
    echo "  Starting mako..."
    mako &
    sleep 1
    echo "  ✓ Mako started"
fi

echo ""

# Make script executable
SCRIPT_PATH="$HOME/.config/waybar/scripts/mako-history.sh"
if [ -f "$SCRIPT_PATH" ]; then
    chmod +x "$SCRIPT_PATH"
    echo "✓ Script is executable"
else
    echo "⚠️  Script not found at: $SCRIPT_PATH"
    echo "Make sure to copy it to your ~/.config/waybar/scripts/ directory"
    exit 1
fi

echo ""

# Send test notifications
echo "📨 Sending test notifications..."
notify-send "Test 1" "First test notification"
sleep 0.3
notify-send "Test 2" "Second test notification" "This is the body text"
sleep 0.3
notify-send -u critical "Important" "This is a critical notification"

echo "✓ Test notifications sent"
echo ""

# Show instructions
echo "╔════════════════════════════════════════╗"
echo "║  Setup Complete! 🎉                    ║"
echo "╚════════════════════════════════════════╝"
echo ""
echo "📋 How to use:"
echo ""
echo "1. Click the notification icon in Waybar"
echo "   → Opens notification history"
echo ""
echo "2. Right-click the notification icon"
echo "   → Clears all notifications"
echo ""
echo "3. Run from terminal:"
echo "   $SCRIPT_PATH"
echo ""
echo "4. Add keybind (optional):"
echo "   Edit ~/.config/niri/keybinds.kdl and add:"
echo "   bind \"Mod+N\" { spawn \"$SCRIPT_PATH\"; }"
echo ""
echo "📚 Features:"
echo "  • View notification history"
echo "  • Clear/dismiss notifications"
echo "  • Restore last notification"
echo "  • Toggle Do Not Disturb"
echo "  • Copy notifications to clipboard"
echo ""
echo "🧪 Test now:"
echo "  $SCRIPT_PATH"
echo ""
