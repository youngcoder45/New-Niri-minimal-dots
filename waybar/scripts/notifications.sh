#!/bin/bash
# Notification count for waybar (mako)

set -euo pipefail

if ! command -v makoctl &>/dev/null; then
    echo "{\"text\":\"󰍡\",\"class\":\"empty\",\"tooltip\":\"mako not found\"}"
    exit 0
fi

COUNT=$(makoctl list 2>/dev/null | jq -r '.data[0] | length' 2>/dev/null || echo "0")

if [ "$COUNT" -eq 0 ]; then
    echo "{\"text\":\"󰍡\",\"class\":\"empty\",\"tooltip\":\"No notifications\"}"
else
    echo "{\"text\":\"󰵅 $COUNT\",\"class\":\"has-notifications\",\"tooltip\":\"$COUNT notification(s)\"}"
fi
