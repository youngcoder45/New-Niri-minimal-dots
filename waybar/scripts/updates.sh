#!/bin/bash
# Package update checker for waybar

set -euo pipefail

check_updates() {
    UPDATES=0

    if command -v checkupdates &>/dev/null; then
        PACMAN_UPDATES=$(checkupdates 2>/dev/null | wc -l || echo 0)
        UPDATES=$((UPDATES + PACMAN_UPDATES))
    fi

    if command -v yay &>/dev/null; then
        AUR_UPDATES=$(yay -Qua 2>/dev/null | wc -l || echo 0)
        UPDATES=$((UPDATES + AUR_UPDATES))
    fi

    if [ "$UPDATES" -eq 0 ]; then
        echo "{\"text\":\"\",\"class\":\"up-to-date\",\"tooltip\":\"System is up to date\"}"
    else
        echo "{\"text\":\"󰏗 $UPDATES\",\"class\":\"has-updates\",\"tooltip\":\"$UPDATES update(s) available\"}"
    fi
}

check_updates
