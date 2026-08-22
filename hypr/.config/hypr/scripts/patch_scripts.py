import os
import re
import glob

for filename in glob.glob("summon_*.sh"):
    with open(filename, "r") as f:
        content = f.read()

    # movetoworkspacesilent "X,Y"
    content = re.sub(
        r'hyprctl dispatch movetoworkspacesilent "([^",]+),([^"]+)"',
        r'hyprctl dispatch "hl.dsp.window.move({ workspace = \"\1\", window = \"\2\", follow = false })"',
        content
    )
    
    # workspace "X"
    content = re.sub(
        r'hyprctl dispatch workspace "([^"]+)"',
        r'hyprctl dispatch "hl.dsp.focus({ workspace = \"\1\" })"',
        content
    )
    
    # workspace X (without quotes)
    content = re.sub(
        r'hyprctl dispatch workspace ([^\s"]+)',
        r'hyprctl dispatch "hl.dsp.focus({ workspace = \"\1\" })"',
        content
    )
    
    # focuswindow "X"
    content = re.sub(
        r'hyprctl dispatch focuswindow "([^"]+)"',
        r'hyprctl dispatch "hl.dsp.focus({ window = \"\1\" })"',
        content
    )
    
    # exec "X"
    content = re.sub(
        r'hyprctl dispatch exec "([^"]+)"',
        r'hyprctl dispatch "hl.dsp.exec_cmd(\\"\1\\")"',
        content
    )
    
    with open(filename, "w") as f:
        f.write(content)
