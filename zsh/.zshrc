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

export HISTFILE="$ZDOTDIR/.zsh_history"

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
export HISTSIZE=100000000
export SAVEHIST=100000000
setopt extendedglob
setopt append_history
setopt share_history
setopt inc_append_history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt extended_history

# File System Aliases
alias chmodx='chmod +x'
alias cat='bat'
alias count='ls -1 | wc -l'
alias l='eza --icons --group-directories-first'
alias la='eza -alF --icons --group-directories-first --git'
alias ll='eza -a --icons --group-directories-first'
alias mkdir='mkdir -p'
alias mkcd='func(){ mkdir -p "$1" && cd "$1" && eza -a --icons --group-directories-first; }; func'
export EZA_IGNORE=$(grep -v '^#' ~/.ignore | sed '/^$/d' | tr '\n' '|' | sed 's/|$//' | sed 's|/||g')
alias tree="eza --tree --icons --git-ignore -I '$EZA_IGNORE'"
alias wallpaper=''

# Navigation Aliases
alias .='whoami && pwd'
alias ..='cd ..'
alias ...='cd ../..'
alias dev='cd $HOME/development'
alias devw='cd $HOME/development/work'
alias devp='cd $HOME/development/personal'
alias dot='cd $HOME/dotfiles/'
alias fzf='fzf -e'
alias hyprrc='nvim $HOME/.config/hypr/hyprland.conf'
alias kittyrc='nvim $HOME/.config/kitty/kitty.conf'
alias tmuxrc='nvim $HOME/.config/tmux/tmux.conf'
alias tools='nvim $HOME/dotfiles/.ignore_stow/tools.txt'

# Applications Aliases
alias open='xdg-open'
alias nv='nvim '
alias zshrc='nvim $HOME/.zshrc'

# Network Aliases
alias myip="$HOME/.local/bin/scripts/myip"
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
alias fd='fd -H'
alias rg='rg --max-columns 300 --one-file-system --hidden'

# Processes, Shell & System Aliases
alias cls='clear'
alias hist='history | less'
alias ff='fastfetch'
alias ncdu='ncdu -x'
alias oc='opencode'
alias virtual-machine="/usr/bin/python3 /usr/bin/virt-manager"

# Git Aliases
alias ga='git add .'
alias gamend='git commit --amend --no-edit'
alias gb='git branch -v'
alias gc='git-commit'
alias gc-="$HOME/.local/bin/scripts/git-minor-change"
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
alias git-repo="$HOME/.local/bin/scripts/git-repo-init"

# Stow/dotfiles Aliases
alias newpkg='$HOME/dotfiles/.ignore_stow/packages/backup_packages.sh'
alias syncdot='$HOME/dotfiles/.ignore_stow/git_push_dotfiles.sh'
alias stow-root='$HOME/dotfiles/scripts/.local/bin/scripts/stow-root.sh'

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
    BUFFER="z ${(q)dir}"
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
  "$HOME/.local/bin/scripts/refresh-ui"

  if [ -n "$ZSH_VERSION" ]; then
    source "${ZDOTDIR:-$HOME}/.zshrc"
  elif [ -n "$BASH_VERSION" ]; then
    source "$HOME/.bashrc"
  elif [ -n "$FISH_VERSION" ]; then
    source ~/.config/fish/config.fish
  else
    echo "Unsupported shell"
    return 1
  fi
}

# --------------------------------------------------------------------------------
# CURSOR MODE
# --------------------------------------------------------------------------------

# Change cursor shape for different vi modes
# 2 = Steady Block (Normal Mode)
# 5 = Blinking Beam (Insert Mode)
# 4 = Steady Underline (Replace Mode - Optional)
function zle-keymap-select {
  if [[ $KEYMAP == vicmd ]]; then
    echo -ne "\e[2 q"
  else
    echo -ne "\e[5 q"
  fi
}
zle -N zle-keymap-select

# Reset cursor to block on prompt init and when returning from command execution
function _set_cursor_on_prompt {
  # Default to Beam in Insert mode (main/viins) or Block in Normal mode (vicmd)
  # If you use vi-mode, you usually want to start in Insert mode.
  if [[ $KEYMAP == vicmd ]]; then
    echo -ne "\e[2 q"
  else
    echo -ne "\e[5 q"
  fi
}
precmd_functions+=(_set_cursor_on_prompt)

# Use vi mode in shell
bindkey -v
export KEYTIMEOUT=1


# Added by Antigravity CLI installer
export PATH="/home/runner/.local/bin:$PATH"
