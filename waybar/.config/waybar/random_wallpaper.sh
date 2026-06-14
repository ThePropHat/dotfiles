#!/bin/bash
WALL_DIR="$HOME/bin/wallpapers"

SELECTED_WALL=$(find "$WALL_DIR" -type f | shuf -n 1)

awww img "$SELECTED_WALL" --transition-type random --transition-step 1

wal -i "$SELECTED_WALL"

qutebrowser ":config-source"
