#!/usr/bin/env bash
WORKSPACE=$1
CLASS=$2
EXEC_CMD=${3:-$CLASS}

if hyprctl clients -j | jq -e ".[] | select(.class | match(\"(?i)$CLASS\"))" > /dev/null; then
    hyprctl dispatch movetoworkspacesilent "$WORKSPACE,class:.*(?i)$CLASS.*"
    hyprctl dispatch workspace "$WORKSPACE"
    hyprctl dispatch focuswindow "class:.*(?i)$CLASS.*"
else
    hyprctl dispatch workspace "$WORKSPACE"
    hyprctl dispatch exec "$EXEC_CMD"
fi
