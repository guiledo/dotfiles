#!/bin/bash
if hyprctl clients -j | jq -e '.[] | select(.class | match("(?i)zapzap|(?i)betterbird"))' > /dev/null; then
    if hyprctl clients -j | jq -e '.[] | select(.class | match("(?i)zapzap"))' > /dev/null; then
        hyprctl dispatch movetoworkspacesilent "3,class:.*(?i)zapzap.*"
    fi
    if hyprctl clients -j | jq -e '.[] | select(.class | match("(?i)betterbird"))' > /dev/null; then
        hyprctl dispatch movetoworkspacesilent "3,class:.*(?i)betterbird.*"
    fi
    hyprctl dispatch workspace 3
    if hyprctl clients -j | jq -e '.[] | select(.class | match("(?i)zapzap"))' > /dev/null; then
        hyprctl dispatch focuswindow "class:.*(?i)zapzap.*"
    else
        hyprctl dispatch focuswindow "class:.*(?i)betterbird.*"
    fi
else
    hyprctl dispatch workspace 3
    hyprctl dispatch exec "[workspace 3 silent; groupset] zapzap"
    hyprctl dispatch exec "[workspace 3 silent; groupset] bash -c 'sleep 2 && /home/runner/.local/bin/scripts/betterbird.sh'"
fi