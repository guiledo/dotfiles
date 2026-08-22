#!/bin/bash
if hyprctl clients -j | jq -e '.[] | select(.class | match("(?i)cursor"))' > /dev/null; then
    hyprctl dispatch "hl.dsp.window.move({ workspace = \"1\", window = \"class:.*(?i)cursor.*\", follow = false })"
    hyprctl dispatch "hl.dsp.focus({ workspace = \"1\" })"
    hyprctl dispatch "hl.dsp.focus({ window = \"class:.*(?i)cursor.*\" })"
else
    hyprctl dispatch "hl.dsp.focus({ workspace = \"1\" })"
    hyprctl dispatch exec cursor
fi