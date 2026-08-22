#!/usr/bin/env bash
WORKSPACE=$1
CLASS=$2
EXEC_CMD=${3:-$CLASS}

if hyprctl clients -j | jq -e ".[] | select(.class | match(\"(?i)$CLASS\"))" > /dev/null; then
    hyprctl dispatch "hl.dsp.window.move({ workspace = \"$WORKSPACE\", window = \"class:.*(?i)$CLASS.*\", follow = false })"
    hyprctl dispatch "hl.dsp.focus({ workspace = \"$WORKSPACE\" })"
    hyprctl dispatch "hl.dsp.focus({ window = \"class:.*(?i)$CLASS.*\" })"
else
    hyprctl dispatch "hl.dsp.focus({ workspace = \"$WORKSPACE\" })"
    hyprctl dispatch "hl.dsp.exec_cmd(\"$EXEC_CMD\")"
fi
