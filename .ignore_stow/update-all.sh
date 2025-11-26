#!/usr/bin/env zsh
set -euo pipefail; set -o pipefail

# --- Configuration ---
LOG_FILE="$HOME/update-all.log"
BIN_DIR="$HOME/.local/bin"

# --- Logging ---
log() {
  echo "$@" | tee -a "$LOG_FILE"
}

# --- Check Dependencies ---
check_dependencies() {
  local dependencies=("curl" "git" "jq" "dpkg-query")
  log "[INIT] Verificando dependências..."
  for cmd in "${dependencies[@]}"; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
      log "  ERRO: Dependência '$cmd' não encontrada. Por favor, instale-a."
      exit 1
    fi
  done
  log "[INIT] Todas as dependências estão presentes."
}


# --- Helper Functions ---
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

load_nvm() {
  # Esta função foi intencionalmente deixada vazia após a migração para o FNM.
  :
}

# --- Update Functions ---

update_apt() {
  log "[APT] Atualizando pacotes..."
  if command_exists pop-upgrade; then
    if sudo pop-upgrade release upgrade; then
      log "[POP-OS] OK"
    else
      log "[POP-OS] FAILED — fallback para apt"
      sudo apt update && sudo apt full-upgrade -y && sudo apt autoremove -y
    fi
  else
    sudo apt update && sudo apt full-upgrade -y && sudo apt autoremove -y
  fi
  log "[APT] Concluído."
}

update_flatpak() {
  log "[FLATPAK] Atualizando apps Flatpak..."
  if command_exists flatpak; then
    flatpak update -y && log "[FLATPAK] OK" || log "[FLATPAK] FAILED"
  else
    log "[FLATPAK] não instalado"
  fi
}

update_rust() {
  log "[RUSTUP] Atualizando toolchains..."
  if command_exists rustup; then
    rustup update && log "[RUSTUP] OK" || log "[RUSTUP] FAILED"
  else
    log "[RUSTUP] não instalado"
  fi

  log "[CARGO] Atualizando bins instalados..."
  if command_exists cargo; then
    if ! command_exists cargo-install-update; then
      log "[CARGO] Instalando 'cargo-update'..."
      cargo install cargo-update
    fi
    cargo install-update -a && log "[CARGO] OK" || log "[CARGO] FAILED"
  else
    log "[CARGO] não instalado"
  fi
}

update_fnm() {
  log "[FNM] Atualizando fnm..."
  # O script de instalação do FNM também lida com a atualização
            if curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell > /tmp/fnm-update.log 2>&1; then
        log "[FNM] OK"
        # Carregar o ambiente FNM imediatamente após a instalação/atualização para que fnm --version funcione
        eval "$(fnm env)"
        log "[FNM] Versão instalada: $(fnm --version)"
      else
        log "[FNM] FAILED. Verifique o log em /tmp/fnm-update.log"
      fi
    }

update_node() {
  log "[FNM/NPM] Verificando e configurando ambiente fnm..."
  if ! command -v fnm >/dev/null 2>&1; then
    log "[FNM] ERRO: fnm não está instalado. Por favor, instale-o primeiro."
    return 1
  fi

  # ESSENCIAL: Garante que o ambiente do fnm está carregado neste script
  eval "$(fnm env)"

  log "[NODE] Instalando ou verificando a última versão LTS estável do Node.js..."
  if ! fnm install --lts; then
    log "[NODE] ERRO: Falha ao instalar a última versão LTS do Node.js."
    return 1
  fi
  log "[NODE] Versão LTS instalada/verificada com sucesso."

  log "[NODE] Obtendo o número da última versão LTS instalada para definir como padrão..."
  log "[DEBUG] Saída de 'fnm ls': $(fnm ls)"
  local lts_version
  # Extrai o número da versão LTS da linha que contém 'lts-latest'
  lts_version=$(fnm ls | grep 'lts-latest' | awk '{print $2}')
  if [[ -z "$lts_version" ]]; then
    log "[NODE] ERRO: Não foi possível obter o número da versão LTS instalada. Abortando."
    return 1
  fi

  log "[NODE] Definindo e ativando a versão LTS ($lts_version) do Node.js..."
  if ! fnm default "$lts_version"; then
    log "[NODE] ERRO: Falha ao definir a versão LTS ($lts_version) do Node.js como padrão."
    return 1
  fi
  if ! fnm use "$lts_version"; then
    log "[NODE] ERRO: Falha ao ativar a versão LTS ($lts_version) do Node.js."
    return 1
  fi
  log "[NODE] Versão LTS ($lts_version) ativada com sucesso: $(fnm current)"

  if command_exists npm; then
    log "[NPM] Atualizando pacotes globais..."
    npm update -g
    log "[NPM] Atualização de pacotes globais concluída."
  else
    log "[NPM] ERRO: npm não foi encontrado mesmo após a configuração do fnm."
  fi
}

update_neovim() {
  log "[NEOVIM] Atualizando NeoVim (AppImage)..."
  local nvim_appimage_url="https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage"
  local temp_appimage="/tmp/nvim.appimage"

  if curl -L -o "$temp_appimage" "$nvim_appimage_url"; then
    chmod u+x "$temp_appimage"
    mv -f "$temp_appimage" "$BIN_DIR/nvim"
    log "[NEOVIM] OK"
  else
    log "[NEOVIM] FAILED: Download do AppImage falhou."
    return 1
  fi

  log "[LAZYVIM] Atualizando LazyVim..."
  if command_exists nvim; then
    nvim --headless "+Lazy! update" +qa >/dev/null 2>&1
    log "[LAZYVIM] OK"
  else
    log "[LAZYVIM] nvim não encontrado"
  fi
}

update_lazygit() {
  log "[LAZYGIT] Atualizando LazyGit..."
  local lazygit_api_url="https://api.github.com/repos/jesseduffield/lazygit/releases/latest"
  
  # Extrai a versão mais recente usando jq
  local latest_version
  latest_version=$(curl -s "$lazygit_api_url" | jq -r '.tag_name' | sed 's/v//')
  
  if [[ -z "$latest_version" ]]; then
    log "[LAZYGIT] FAILED: Não foi possível obter a versão mais recente."
    return 1
  fi

  local current_version=""
  if command_exists lazygit; then
    current_version=$(lazygit --version | grep -Po 'version=\K[0-9\.]+')
  fi

  if [[ "$current_version" != "$latest_version" ]]; then
    log "[LAZYGIT] Nova versão encontrada ($latest_version). Atualizando..."
    local download_url="https://github.com/jesseduffield/lazygit/releases/download/v${latest_version}/lazygit_${latest_version}_Linux_x86_64.tar.gz"
    local temp_tar="/tmp/lazygit.tar.gz"

    if curl -Lo "$temp_tar" "$download_url"; then
      tar -xzf "$temp_tar" -C /tmp lazygit
      install -Dm755 /tmp/lazygit "$BIN_DIR/lazygit"
      rm -f /tmp/lazygit "$temp_tar"
      log "[LAZYGIT] OK: Atualizado para a versão $latest_version"
    else
      log "[LAZYGIT] FAILED: Download da nova versão falhou."
      return 1
    fi
  else
    log "[LAZYGIT] OK: Já está na versão mais recente ($current_version)."
  fi
}

update_homebrew() {
  log "[HOMEBREW] Atualizando Homebrew e pacotes..."

  # Tenta carregar o ambiente do Homebrew. O Homebrew no Linux geralmente
  # não está no PATH padrão de scripts não-interativos.
  local brew_executable="/home/linuxbrew/.linuxbrew/bin/brew"
  if [[ -x "$brew_executable" ]]; then
    log "[HOMEBREW] Executável do Homebrew encontrado. Configurando ambiente..."
    eval "$($brew_executable shellenv)"
  fi

  if command_exists brew; then
    log "[HOMEBREW] Iniciando atualização..."
    brew update && brew upgrade && log "[HOMEBREW] OK" || log "[HOMEBREW] FAILED"
  else
    log "[HOMEBREW] não instalado ou não encontrado no PATH."
    log "[HOMEBREW] Dica: Verifique se o caminho em '$brew_executable' está correto para sua instalação."
  fi
}

# --- Cleanup Functions ---

cleanup_docker() {
  log "[DOCKER] Limpando sistema Docker..."
  if command_exists docker; then
    docker system prune -af && log "[DOCKER] OK" || log "[DOCKER] FAILED"
  else
    log "[DOCKER] não instalado"
  fi
}

cleanup_old_kernels() {
  log "[KERNELS] Limpando kernels antigos..."
  local current_kernel
  current_kernel=$(uname -r)
  
  # Lista todos os pacotes de kernel instalados, ordena por versão, e mantém os 2 mais recentes.
  local old_kernels
  old_kernels=$(dpkg-query -W -f='${Package}\n' 'linux-image-[0-9]*' | sort -V | head -n -2)

  # Garante que o kernel atual nunca seja removido
  old_kernels=$(echo "$old_kernels" | grep -v "$current_kernel")

  if [ -n "$old_kernels" ]; then
    log "[KERNELS] Removendo os seguintes kernels antigos:"
    log "$old_kernels"
    echo "$old_kernels" | xargs -r sudo apt-get -y purge
    log "[KERNELS] Limpeza concluída."
  else
    log "[KERNELS] Nenhum kernel antigo para remover."
  fi
}


# --- Main Execution ---
main() {
  # Garante que o diretório de binários e o arquivo de log existem
  mkdir -p "$BIN_DIR"
  touch "$LOG_FILE"

  log "=== RUN at $(date) ==="
  
  check_dependencies
  
  log "\n--- INICIANDO ATUALIZAÇÕES ---"
  update_apt
  update_flatpak
  update_rust
  update_fnm
  # Garante que o ambiente do fnm está carregado para as próximas funções
  # e para que 'fnm' seja encontrado no PATH.
  eval "$(fnm env)"
  if ! command -v fnm >/dev/null 2>&1; then
    log "[ERRO] FNM não foi encontrado no PATH após 'eval \"\$(fnm env)\"'. Abortando."
    exit 1
  fi
  update_node
  update_neovim
  update_lazygit
  update_homebrew
  
  log "\n--- INICIANDO LIMPEZA ---"
  cleanup_docker
  cleanup_old_kernels

  log "\n=== FIM ==="
}

main "$@"
