fzf-open-file-in-nvim-widget() {
  local file
  file=$(fd --type f --strip-cwd-prefix --hidden --follow . \
    --exclude ".git" \
    --exclude ".local/state" \
    --exclude "node_modules" \
    --exclude ".cache" \
    --exclude ".venv" \
    --exclude "target" \
    --exclude "build" \
    --exclude "dist" | \
      fzf --prompt="Open File> " \
      --preview 'bat -n --color=always {}')
  if [[ -n "$file" ]]; then
    BUFFER="nvim ${(q)file}"
    zle accept-line
  fi
  zle reset-prompt
}
zle -N fzf-open-file-in-nvim-widget
bindkey '^f' fzf-open-file-in-nvim-widget

fzf-cd-widget() {
  local dir
  dir=$(fd --type d --hidden --follow . "$HOME" \
    --exclude ".git" \
    --exclude ".local/state" \
    --exclude "node_modules" \
    --exclude ".cache" \
    --exclude ".npm" \
    --exclude ".cargo" \
    --exclude ".venv" \
    --exclude "venv" \
    --exclude "target" \
    --exclude "build" \
    --exclude "dist" | \
      fzf --prompt="Navigate> " \
      --preview 'eza --tree --level=1 --color=always {}')

  if [[ -n "$dir" ]]; then
    BUFFER="z ${(q)dir} && eza -a --icons --group-directories-first"
      zle accept-line
  fi
  
  zle reset-prompt
}
zle -N fzf-cd-widget
bindkey '^g' fzf-cd-widget

function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

git-commit() {
  git commit -m "$*"
}

git-commit-simple() {
  git add -A
  git commit -m "[auto] Minor change in the codebase."
}

tmp() {
    export CURRENT_TEMP_DIR=$(mktemp -d /tmp/tempXXXXXX)
    cd "$CURRENT_TEMP_DIR" || return
    echo "Workspace created: $CURRENT_TEMP_DIR"
}

untmp() {
    if [ -z "$CURRENT_TEMP_DIR" ]; then
        echo "Error: No temporary workspace is currently active."
        return 1
    fi
    
    local target="$CURRENT_TEMP_DIR"
    
    cd - > /dev/null 2>&1 || cd /tmp
    
    rm -rf "$target"
    unset CURRENT_TEMP_DIR
    echo "Workspace deleted: $target"
}

chpwd() {
  eza -a --icons --group-directories-first --git
}
