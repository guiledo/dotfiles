export ZDOTDIR="$HOME"

# Path configuration
export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$HOME/.cargo/bin:$PATH"

# Environment Variables
export DL="$HOME/Downloads/"
export DOCS="$HOME/Documents/"
export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml
export STARSHIP_CACHE=$HOME/.starship/cache
export EDITOR=nvim
export VISUAL=nvim

# Mozilla/NVIDIA Fixes (Crash on Wake / Wayland stability)
export MOZ_DISABLE_RDD_SANDBOX=1
export MOZ_ENABLE_WAYLAND=1
export LIBVA_DRIVER_NAME=nvidia

# Homebrew
if [ -x "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Node/PNPM/FNM
export FNM_PATH="/home/runner/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
fi

export PNPM_HOME="/home/runner/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
