#!/bin/bash
if hyprctl clients -j | jq -e '.[] | select(.class | match("(?i)kitty"))' > /dev/null; then
    hyprctl dispatch "hl.dsp.window.move({ workspace = \"1\", window = \"class:kitty\", follow = false })"
    hyprctl dispatch "hl.dsp.focus({ workspace = \"1\" })"
    hyprctl dispatch focuswindow class:kitty
else
    hyprctl dispatch "hl.dsp.focus({ workspace = \"1\" })"
    hyprctl dispatch exec kitty
fi