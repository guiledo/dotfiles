#!/usr/bin/env bash

if ! pgrep -f "betterbird-bin" > /dev/null; then
    find "$HOME/.thunderbird" \( -name "parent.lock" -o -name ".parentlock" -o -name "lock" \) -delete 2>/dev/null
fi

export MOZ_ENABLE_WAYLAND=1
export MOZ_DISABLE_RDD_SANDBOX=1
export MOZ_DISABLE_SOCKET_PROCESS=1

sleep 2

exec /opt/betterbird/betterbird "$@"
