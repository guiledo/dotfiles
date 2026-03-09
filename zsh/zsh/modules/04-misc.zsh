reload() {
  pkill -HUP kanshi
  pkill -9 -x waybar ; nohup waybar >/dev/null 2>&1 &

  if [ -n "$ZSH_VERSION" ]; then
    source "${ZDOTDIR:-$HOME}/.zshrc"

  elif [ -n "$BASH_VERSION" ]; then
    source "$HOME/.bashrc"

  elif [ -n "$FISH_VERSION" ]; then
    commandline -f repaint
    source ~/.config/fish/config.fish

  else
    echo "Unsupported shell"
    return 1
  fi
}

FNM_PATH="/home/runner/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "`fnm env`"
fi

export PNPM_HOME="/home/runner/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
