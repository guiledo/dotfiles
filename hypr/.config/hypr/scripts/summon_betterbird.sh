#!/bin/bash
if hyprctl clients -j | jq -e '.[] | select(.class | match("(?i)betterbird"))' > /dev/null; then
    hyprctl dispatch movetoworkspacesilent "3,class:.*(?i)betterbird.*"
    hyprctl dispatch workspace 3
    hyprctl dispatch focuswindow "class:.*(?i)betterbird.*"
else
    hyprctl dispatch workspace 3
    hyprctl dispatch exec /home/runner/dotfiles/hypr/.config/hypr/scripts/betterbird.sh
fi