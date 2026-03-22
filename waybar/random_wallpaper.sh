#!/bin/bash
# Path to your wallpaper folder
WALL_DIR="$HOME/Desktop/wallpapers"

# 1. Pick a random image
SELECTED_WALL=$(find "$WALL_DIR" -type f | shuf -n 1)

# 2. Set it with swww (smooth transition)
swww img "$SELECTED_WALL" --transition-type random --transition-step 1

# 3. Run pywal to update colors
wal -i "$SELECTED_WALL"
