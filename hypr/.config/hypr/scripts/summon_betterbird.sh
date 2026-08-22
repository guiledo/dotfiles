#!/bin/bash
if hyprctl clients -j | jq -e '.[] | select(.class | match("(?i)betterbird"))' > /dev/null; then
    hyprctl dispatch "hl.dsp.window.move({ workspace = \"3\", window = \"class:.*(?i)betterbird.*\", follow = false })"
    hyprctl dispatch "hl.dsp.focus({ workspace = \"3\" })"
    hyprctl dispatch "hl.dsp.focus({ window = \"class:.*(?i)betterbird.*\" })"
else
    hyprctl dispatch "hl.dsp.focus({ workspace = \"3\" })"
    hyprctl dispatch exec /home/runner/dotfiles/hypr/.config/hypr/scripts/betterbird.sh
fi