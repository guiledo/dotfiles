export PATH="$HOME/bin:$HOME/.local/bin:usr/local/bin:$HOME/.cargo/bin:$PATH"
export DL="$HOME/Downloads/"
export DOCS="$HOME/Documents/"
export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml
export STARSHIP_CACHE=$HOME/.starship/cache
export EDITOR=nvim
export VISUAL=nvim

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

export FZF_ALT_C_COMMAND='fdfind --type d --strip-cwd-prefix --hidden --follow --exclude .git --exclude .local/state'
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200' --bind 'ctrl-/:change-preview-window(down|hidden|)'"

FZF_CTRL_T_COMMAND='' source <(fzf --zsh)
