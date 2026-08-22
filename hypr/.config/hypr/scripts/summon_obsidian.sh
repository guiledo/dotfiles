#!/bin/bash
if hyprctl clients -j | jq -e '.[] | select(.class | match("(?i)obsidian"))' > /dev/null; then
    hyprctl dispatch "hl.dsp.window.move({ workspace = \"4\", window = \"class:.*(?i)obsidian.*\", follow = false })"
    hyprctl dispatch "hl.dsp.focus({ workspace = \"4\" })"
    hyprctl dispatch "hl.dsp.focus({ window = \"class:.*(?i)obsidian.*\" })"
else
    hyprctl dispatch "hl.dsp.focus({ workspace = \"4\" })"
    hyprctl dispatch "hl.dsp.exec_cmd(\"$HOME/.local/bin/Obsidian-1.11.5.AppImage\")"
fi