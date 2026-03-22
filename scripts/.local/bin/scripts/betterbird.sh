#!/bin/bash

# Se o betterbird NÃO estiver rodando, limpa os locks residuais de possíveis crashes
if ! pgrep -x "betterbird-bin" > /dev/null; then
    find "$HOME/.thunderbird" -name "parent.lock" -type f -delete 2>/dev/null
fi

# Força o uso do Wayland e previne os bugs de Socket e Vídeo (RDD) no NVIDIA/Suspend
export MOZ_ENABLE_WAYLAND=1
export MOZ_DISABLE_RDD_SANDBOX=1
export MOZ_DISABLE_SOCKET_PROCESS=1

# Inicia o Betterbird passando eventuais argumentos
exec /opt/betterbird/betterbird "$@"
