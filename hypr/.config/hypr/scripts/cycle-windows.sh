#!/bin/bash

DIR=$1

# Get the length of the 'grouped' array for the active window
IS_GROUPED=$(hyprctl activewindow -j | jq '.grouped | length')

if [ -n "$IS_GROUPED" ] && [ "$IS_GROUPED" -gt 0 ]; then
    # We are inside a group (stack), cycle the group
    if [ "$DIR" == "prev" ]; then
        hyprctl dispatch changegroupactive b
    else
        hyprctl dispatch changegroupactive f
    fi
else
    # We are not in a group, cycle all regular windows in the workspace
    if [ "$DIR" == "prev" ]; then
        hyprctl dispatch cyclenext prev
    else
        hyprctl dispatch cyclenext
    fi
    hyprctl dispatch bringactivetotop
fi
