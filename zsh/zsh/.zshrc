# --------------------------------------------------------------------------------
# OH MY ZSH!
# --------------------------------------------------------------------------------

# Path to your Oh My Zsh installation.
export ZSH="$HOME/dotfiles/oh-my-zsh/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="robbyrussell"

# Which plugins would you like to load?
plugins=(
  git
  zsh-autosuggestions
  fast-syntax-highlighting
  you-should-use
)

source $ZSH/oh-my-zsh.sh

# --------------------------------------------------------------------------------
# CUSTOM
# --------------------------------------------------------------------------------

export HISTFILE="$ZDOTDIR/zsh_history"

# Tool Initializations
if command -v starship >/dev/null 2>&1; then eval "$(starship init zsh)"; fi
if command -v zoxide >/dev/null 2>&1; then eval "$(zoxide init zsh)"; fi
if [ -d "$FNM_PATH" ]; then eval "`fnm env`"; fi

# FZF Configuration
export FZF_ALT_C_COMMAND='fdfind --type d --strip-cwd-prefix --hidden --follow --exclude .git --exclude .local/state'
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200' --bind 'ctrl-/:change-preview-window(down|hidden|)'"
if command -v fzf >/dev/null 2>&1; then
  FZF_CTRL_T_COMMAND='' source <(fzf --zsh)
fi

# Options & History
setopt extendedglob
setopt appendhistory
setopt sharehistory
setopt incappendhistory
setopt histignoredups
setopt histignorespace
SAVEHIST=2000
HISTSIZE=1000

# File System Aliases
alias chmodx='chmod +x'
alias cat='bat'
alias count='ls -1 | wc -l'
alias l='eza --icons --group-directories-first'
alias la='eza -alF --icons --group-directories-first --git'
alias ll='eza -a --icons --group-directories-first'
alias mk='mkdir -p'
alias mkcd='func(){ mkdir -p "$1" && cd "$1" && eza -a --icons --group-directories-first; }; func'
alias tree='eza --tree --icons'

# Navigation Aliases
alias .='whoami && pwd'
alias ..='cd ..'
alias ...='cd ../..'
alias dev='cd $HOME/dev'
alias devw='cd $HOME/dev/work'
alias devp='cd $HOME/dev/personal'
alias dot='cd $HOME/dotfiles/'
alias fzf='fzf -e'
alias hyprrc='nvim $HOME/.config/hypr/hyprland.conf'
alias kittyrc='nvim $HOME/.config/kitty/kitty.conf'
alias tmuxrc='nvim $HOME/.config/tmux/tmux.conf'
alias tools='nvim $HOME/dotfiles/.ignore_stow/tools.txt'

# Applications Aliases
alias open='xdg-open'
alias nv='nvim '
alias zshrc='nvim $HOME/zsh/.zshrc'

# Network Aliases
alias myip="ip a | grep 'inet ' && curl ifconfig.me"
alias ports='ss -tuln'

# Package Management Aliases
alias install='sudo paru -S'
alias purge='sudo paru -Rns'
alias update='sudo paru -Syu && sudo paru -c'

# Process Management Aliases
alias k='kill -9'
alias kp='pkill -9'
alias psg='ps aux | grep -i'

# Search Aliases
alias fd='fd -H -I '
alias rg='rg --one-file-system '

# Shell & System Aliases
alias cls='clear'
alias hist='history | less'
alias ff='fastfetch'
alias ncdu='ncdu -x'

# Git Aliases
alias ga='git add .'
alias gamend='git commit --amend --no-edit'
alias gb='git branch -v'
alias gc='git-commit'
alias gc-='git-commit-simple'
alias gco='git checkout'
alias gco-='git checkout -'
alias gdiff='git diff'
alias gdstage='git diff --staged'
alias gf='git fetch'
alias gi='git init'
alias gl='git log --oneline --graph --decorete --all'
alias gll='git log --oneline --graph --decorete'
alias gp='git push'
alias gur='git pull --rebase'
alias gr='git reflog'
alias gs='git status -s'
alias gsw='git switch'
alias gu='git pull'
alias gunstage='git reset HEAD --'
alias repo='git init -b main && gh repo create --private --source=. --remote=origin && git add . && git commit -m "First upload" && git push -u --all && gh browse'

# Stow/dotfiles Aliases
alias archpkg='$HOME/dotfiles/.ignore_stow/packages/install_packages.sh'
alias newpkg='$HOME/dotfiles/.ignore_stow/packages/backup_packages.sh'
alias syncdot='$HOME/dotfiles/.ignore_stow/git_push_dotfiles.sh'

# Functions
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
  if command -v eza >/dev/null 2>&1; then
    eza -a --icons --group-directories-first --git
  fi
}

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

# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *) return ;;
esac
