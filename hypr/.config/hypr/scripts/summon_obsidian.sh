#!/bin/bash
if hyprctl clients -j | jq -e '.[] | select(.class | match("(?i)obsidian"))' > /dev/null; then
    hyprctl dispatch movetoworkspacesilent "4,class:.*(?i)obsidian.*"
    hyprctl dispatch workspace 4
    hyprctl dispatch focuswindow "class:.*(?i)obsidian.*"
else
    hyprctl dispatch workspace 4
    hyprctl dispatch exec "$HOME/.local/bin/Obsidian-1.11.5.AppImage"
fi