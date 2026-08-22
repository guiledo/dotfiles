#!/bin/bash
if hyprctl clients -j | jq -e '.[] | select(.class | match("(?i)vivaldi"))' > /dev/null; then
    hyprctl dispatch "hl.dsp.window.move({ workspace = \"2\", window = \"class:.*(?i)vivaldi.*\", follow = false })"
    hyprctl dispatch "hl.dsp.focus({ workspace = \"2\" })"
    hyprctl dispatch "hl.dsp.focus({ window = \"class:.*(?i)vivaldi.*\" })"
else
    hyprctl dispatch "hl.dsp.focus({ workspace = \"2\" })"
    hyprctl dispatch "hl.dsp.exec_cmd(\"vivaldi --ozone-platform=wayland --enable-features=UseOzonePlatform --use-gl=desktop --use-cmd-decoder=validating\")"
fi