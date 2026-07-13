#!/usr/bin/env bash

# Kill previous locks (prevents crash loop)
pkill gtklock 2>/dev/null

# Start gtklock cleanly
gtklock \
  --config "$HOME/.config/niri-lock/config.ini"
