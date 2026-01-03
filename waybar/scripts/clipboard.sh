#!/bin/bash

# Clipboard manager script using cliphist

show_clipboard() {
    cliphist list | fuzzel --dmenu --prompt="Clipboard: " --width=60 | cliphist decode | wl-copy
}

clear_clipboard() {
    cliphist wipe
    notify-send "Clipboard" "History cleared"
}

case "$1" in
    --show)
        show_clipboard
        ;;
    --clear)
        clear_clipboard
        ;;
    *)
        echo "Usage: $0 {--show|--clear}"
        exit 1
        ;;
esac
