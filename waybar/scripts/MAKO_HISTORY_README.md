# Mako Notification History with Fuzzel

## 🎯 What Changed

**NEW:** `mako-history.sh` - Better notification history display with fuzzel
**REMOVED:** `notification-control.sh` - Old script that wasn't showing history properly
**UPDATED:** `waybar/modules/notifications.jsonc` - Now uses the new script

## ✨ Features

The new `mako-history.sh` script provides:

- **📜 Notification History**: Shows all notifications from `makoctl history`
- **🔍 Better Formatting**: Clean display with app name, summary, and body
- **⚡ Quick Actions**:
  - Clear All Notifications (󰎟)
  - Dismiss Visible Notifications (󰂛)
  - Restore Last Notification (󰃢)
  - Toggle Do Not Disturb (󰂛)
- **📋 Copy to Clipboard**: Click any notification to copy it
- **🎨 Clean UI**: Proper separators and icons

## 🚀 Usage

### From Waybar
Click the notification icon in waybar to open the history panel

### From Terminal
```bash
~/.config/waybar/scripts/mako-history.sh
```

### From Keybind
Add to your niri config:
```kdl
bind "Mod+N" { spawn "~/.config/waybar/scripts/mako-history.sh"; }
```

## 🔧 How It Works

1. **Gets History**: Runs `makoctl history` and parses JSON
2. **Formats Display**: Extracts app name, summary, and body
3. **Shows in Fuzzel**: Clean dmenu-style interface
4. **Executes Actions**: Based on what you select

## 📋 Menu Options

```
󰎟  Clear All Notifications    → makoctl dismiss -a
󰂛  Dismiss Visible            → makoctl dismiss
󰃢  Restore Last               → makoctl restore
󰂛  Toggle Do Not Disturb      → makoctl mode -t dnd
─────────────────────────
📜 Notification History (N)
─────────────────────────
󰵅 App: Summary - Body         → Click to copy
󰵅 App: Summary - Body
...
```

## 🐛 Troubleshooting

### No notifications showing?
```bash
# Check if mako is running
pgrep mako

# Test makoctl directly
makoctl history

# Send a test notification
notify-send "Test" "This is a test notification"
```

### Script not working?
```bash
# Check dependencies
command -v makoctl
command -v fuzzel
command -v jq
command -v wl-copy

# Make executable
chmod +x ~/.config/waybar/scripts/mako-history.sh

# Test manually
~/.config/waybar/scripts/mako-history.sh
```

### Empty history?
Mako only keeps notifications that you've received. If you clear all history, the list will be empty until new notifications arrive.

## 📦 Dependencies

Required packages:
- `mako` - Notification daemon
- `fuzzel` - Application launcher / dmenu
- `python3` - For JSON parsing (usually pre-installed)
- `wl-clipboard` - Clipboard utilities (for copy feature)

**Note:** No need for `jq` - the script uses Python for JSON parsing!

Install on Arch:
```bash
sudo pacman -S mako fuzzel wl-clipboard python
```

## 🎨 Customization

### Change Fuzzel Appearance
Edit the fuzzel options in `mako-history.sh`:
```bash
fuzzel \
    --dmenu \
    --lines=20 \           # Number of lines to show
    --width=60 \           # Width in characters
    --prompt="Notifications: " \
    --line-height=25 \     # Line height in pixels
    --font="monospace:size=11"
```

### Change Icons
Edit the icon variables at the top of the script:
```bash
ICON_CLEAR="󰎟"
ICON_DISMISS="󰂛"
ICON_RESTORE="󰃢"
# etc.
```

### Add More Actions
Add new cases in the `execute_action()` function:
```bash
"Custom Action"*)
    # Your command here
    notify-send "Action" "Done!"
    ;;
```

## 🔄 Integration with Waybar

The notifications module in waybar now uses this script:

```jsonc
"on-click": "~/.config/waybar/scripts/mako-history.sh",
"on-click-right": "makoctl dismiss -a && notify-send -u low 'Notifications' 'All cleared'",
```

- **Left click**: Open notification history
- **Right click**: Clear all notifications

## ✅ Testing

Test all features:
```bash
# Send test notifications
notify-send "App 1" "Test notification 1"
notify-send "App 2" "Test notification 2"
notify-send -u critical "Important" "Critical notification"

# Open the history
~/.config/waybar/scripts/mako-history.sh

# Test dismiss
makoctl dismiss

# Test restore
makoctl restore

# Test clear all
makoctl dismiss -a

# Check history
makoctl history | jq
```

## 🎯 Tips

1. **Copy notifications**: Click any notification in the list to copy it to clipboard
2. **DND mode**: Use "Toggle Do Not Disturb" to silence notifications temporarily
3. **Recent first**: Notifications are shown with newest first
4. **Clean regularly**: Use "Clear All" to keep history manageable
5. **Keyboard nav**: Use arrow keys in fuzzel to navigate

---

**Enjoy your improved notification system!** 🚀
