#!/usr/bin/env bash
# stow-root.sh: Mapeia dinamicamente arquivos de .ignore_stow/root para o sistema.

# Caminho absoluto da origem nos seus dotfiles
SOURCE_DIR="$HOME/dotfiles/.ignore_stow/root"

if [[ ! -d "$SOURCE_DIR" ]]; then
    echo "Erro: Diretorio de origem $SOURCE_DIR nao encontrado."
    exit 1
fi

echo "--- Iniciando Sincronizacao de Arquivos de Sistema (Root) ---"

# 1. Encontra todos os arquivos dentro da pasta root (recursivamente)
# Usamos -type f para pegar apenas arquivos
find "$SOURCE_DIR" -type f | while read -r src_file; do
    
    # 2. Calcula o caminho relativo a partir da pasta 'root'
    # Ex: /home/runner/dotfiles/.ignore_stow/root/etc/modprobe.d/fix.conf -> /etc/modprobe.d/fix.conf
    target_file="${src_file#$SOURCE_DIR}"
    target_dir=$(dirname "$target_file")

    echo "Sincronizando: $target_file"

    # 3. Cria o diretorio pai no sistema se ele nao existir
    if [[ ! -d "$target_dir" ]]; then
        sudo mkdir -p "$target_dir"
    fi

    # 4. Cria o link simbolico forcado (-f) e informativo (-v)
    # Usamos sudo ln para ter permissao de escrita em /etc, /usr, etc.
    sudo ln -sfv "$src_file" "$target_file"
done

echo "--- Sincronizacao Concluida ---"
