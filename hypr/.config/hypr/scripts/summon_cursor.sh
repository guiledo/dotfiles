#!/bin/bash
if hyprctl clients -j | jq -e '.[] | select(.class | match("(?i)cursor"))' > /dev/null; then
    hyprctl dispatch movetoworkspacesilent "1,class:.*(?i)cursor.*"
    hyprctl dispatch workspace 1
    hyprctl dispatch focuswindow "class:.*(?i)cursor.*"
else
    hyprctl dispatch workspace 1
    hyprctl dispatch exec cursor
fi