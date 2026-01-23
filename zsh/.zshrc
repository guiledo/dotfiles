# --------------------------------------------------------------------------------
# OH MY ZSH!
# --------------------------------------------------------------------------------

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-autosuggestions
  fast-syntax-highlighting
  you-should-use
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# --------------------------------------------------------------------------------
# USER CHANGES
# --------------------------------------------------------------------------------

# --- SHELL INTEGRATION, EXPORTS & PATH ---
export PATH="$HOME/bin:$HOME/.local/bin:usr/local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export STARSHIP_CONFIG=~/.config/starship/starship.toml
export STARSHIP_CACHE=~/.starship/cache
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
# Keep custom ALT+C behavior to change directory.
export FZF_ALT_C_COMMAND='fdfind --type d --strip-cwd-prefix --hidden --follow --exclude .git --exclude .local/state'
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200' --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# Disable the default CTRL-T binding from the fzf script so we can create our own.
FZF_CTRL_T_COMMAND='' source <(fzf --zsh)

# --- ZSH OPTIONS --- 
setopt extendedglob
setopt appendhistory
setopt sharehistory
setopt incappendhistory
setopt histignoredups
setopt histignorespace
SAVEHIST=2000
HISTSIZE=1000

# --- ALIASES ---
# File System
alias chmodx='chmod +x'
alias cat='bat'
alias count='ls -1 | wc -l'
alias l='eza --icons --group-directories-first'
alias la='eza -alF --icons --group-directories-first --git'
alias ll='eza -a --icons --group-directories-first'
alias mk='mkdir -p'
alias mkcd='func(){ mkdir -p "$1" && cd "$1" && eza -a --icons --group-directories-first; }; func'
alias tree='eza --tree --icons'
# Navigation
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
# Applications
alias open='xdg-open'
alias nv='nvim'
alias zshrc='nvim ~/.zshrc'
# Network
alias myip="ip a | grep 'inet ' && curl ifconfig.me"
alias ports='ss -tuln'
# Package Management
alias install='sudo paru -S'
alias purge='sudo paru -Rns'
alias update='sudo paru -Syu && sudo paru -c'
# alias update-all='$HOME/dotfiles/.ignore_stow/update-all.sh'
# Process Management
alias k='kill -9'
alias kp='pkill -9'
alias psg='ps aux | grep -i'
# Search
alias fd='fd -H -I '
alias rg='rg --one-file-system '
# Shell & System
alias cls='clear'
alias hist='history | less'
alias ff='fastfetch'
alias ncdu='ncdu -x'
alias reload='exec zsh'
alias sourcez='source ~/.zshrc'
alias sudo='sudo '
# Git
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
alias repo='git init && gh repo create --private --source=. --remote=origin && git add . && git commit -m "First upload" && git push -u --all && gh browse'
# Stow/dotfiles
alias archpkg='$HOME/dotfiles/.ignore_stow/packages/install_packages.sh'
alias newpkg='$HOME/dotfiles/.ignore_stow/packages/backup_packages.sh'
alias syncdot='$HOME/dotfiles/.ignore_stow/git_push_dotfiles.sh'

# --- FUNCTIONS ---
# Custom fzf widget and binding for CTRL-f to open a file in Neovim.
fzf-open-file-in-nvim-widget() {
  local file
  # Use fd and fzf to select a single file.
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
  # If a file was selected, place `nvim [file]` in the buffer and execute it.
  if [[ -n "$file" ]]; then
    BUFFER="nvim ${(q)file}"
    zle accept-line
  fi
  zle reset-prompt
}
# Create the widget for Zsh's line editor (ZLE).
zle -N fzf-open-file-in-nvim-widget
# Bind CTRL-f to our new widget.
bindkey '^f' fzf-open-file-in-nvim-widget

# Custom fzf widget and binding for CTRL-g to open a folder.
fzf-cd-widget() {
  local dir
  # Busca apenas diretórios (--type d) a partir do $HOME.
  # Flags de otimização:
  # --strip-cwd-prefix: remove o './' inicial para estética.
  # --hidden: inclui diretórios ocultos (configurações, etc).
  # --exclude .git: ignora a pasta versionada para reduzir ruído.
  dir=$(fd --type d --hidden --follow . "$HOME" \
    --exclude ".git" \
    --exclude ".local/state" \
    --exclude "node_module" \
    --exclude ".cache" \
    --exclude ".npm" \
    --exclude ".cargo" \
    --exclude ".venv" \
    --exclude "venv"
    --exclude "target"
    --exclude "build"
    --exclude "dist" | \
      fzf --prompt="Navigate> " \
      --preview 'eza --tree --level=1 --color=always {}')

  # Se um diretório foi selecionado, usa 'z' (zoxide) para navegar.
  if [[ -n "$dir" ]]; then
    BUFFER="z ${(q)dir} && eza -a --icons --group-directories-first"
      zle accept-line
  fi
 
  zle reset-prompt
}
# Registra o widget no ZLE (Zsh Line Editor)
zle -N fzf-cd-widget
# Define o atalho. Sugestão: ALT+c (padrão comum para CD) ou CTRL+g
bindkey '^g' fzf-cd-widget

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# Tmux auto-start
## if command -v tmux>/dev/null; then
## [[ ! $TERM =~ screen ]] && [ -z $TMUX ] && exec tmux new-session -A -s main
## fi

# Better Yazi Startup
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# Better Git Commit
git-commit() {
  git commit -m "$*"
}

# Simple Git Commit
git-commit-simple() {
  git add -A
  git commit -m "[auto] Minor change in the codebase."
}

# Creates a temp directory and saves the path
tmp() {
    export CURRENT_TEMP_DIR=$(mktemp -d /tmp/tempXXXXXX)
    cd "$CURRENT_TEMP_DIR" || return
    echo "Workspace created: $CURRENT_TEMP_DIR"
}

# Deletes the stored path
untmp() {
    if [ -z "$CURRENT_TEMP_DIR" ]; then
        echo "Error: No temporary workspace is currently active."
        return 1
    fi
    
    local target="$CURRENT_TEMP_DIR"
    
    # Move out of the directory before deleting it
    cd - > /dev/null 2>&1 || cd /tmp
    
    rm -rf "$target"
    unset CURRENT_TEMP_DIR
    echo "Workspace deleted: $target"
}

# Define the hook function - every time change directory, run eza (better ls)
chpwd() {
  eza -a --icons --group-directories-first --git
}

# --- MISC ---
# Oh-My-Zsh default and simple prompt in the absence of Starship
# prompt_context(){}

# fnm
FNM_PATH="/home/runner/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "`fnm env`"
fi
