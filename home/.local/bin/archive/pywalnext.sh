#!/bin/bash

# Set the wallpaper using wal
wal -i "/home/ashe/.local/share/wallpaper/" -q -n
# wal -i "/home/ashe/.local/share/wallpaper/" --iterative -q -n

# Wait for a short period of time
sleep 0.1

# Set the background color for Sway using wal
swaybg -i "$(< "${HOME}/.cache/wal/wal")" --mode=fill

# Wait for a short period of time
sleep 0.1

# Update Pywalfox
pywalfox update