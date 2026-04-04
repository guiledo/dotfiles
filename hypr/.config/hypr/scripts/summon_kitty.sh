#!/bin/bash
if hyprctl clients -j | jq -e '.[] | select(.class | match("(?i)kitty"))' > /dev/null; then
    hyprctl dispatch movetoworkspacesilent "1,class:kitty"
    hyprctl dispatch workspace 1
    hyprctl dispatch focuswindow class:kitty
else
    hyprctl dispatch workspace 1
    hyprctl dispatch exec kitty
fi