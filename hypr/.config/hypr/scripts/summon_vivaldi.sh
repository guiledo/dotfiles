#!/bin/bash
if hyprctl clients -j | jq -e '.[] | select(.class | match("(?i)vivaldi"))' > /dev/null; then
    hyprctl dispatch movetoworkspacesilent "2,class:.*(?i)vivaldi.*"
    hyprctl dispatch workspace 2
    hyprctl dispatch focuswindow "class:.*(?i)vivaldi.*"
else
    hyprctl dispatch workspace 2
    hyprctl dispatch exec vivaldi
fi