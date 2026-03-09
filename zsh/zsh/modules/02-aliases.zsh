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
alias nv='nvim '
alias zshrc='nvim $HOME/dotfiles/zsh/zshrc'

# Network
alias myip="ip a | grep 'inet ' && curl ifconfig.me"
alias ports='ss -tuln'

# Package Management
alias install='sudo paru -S'
alias purge='sudo paru -Rns'
alias update='sudo paru -Syu && sudo paru -c'

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
alias repo='git init -b main && gh repo create --private --source=. --remote=origin && git add . && git commit -m "First upload" && git push -u --all && gh browse'

# Stow/dotfiles
alias archpkg='$HOME/dotfiles/.ignore_stow/packages/install_packages.sh'
alias newpkg='$HOME/dotfiles/.ignore_stow/packages/backup_packages.sh'
alias syncdot='$HOME/dotfiles/.ignore_stow/git_push_dotfiles.sh'
