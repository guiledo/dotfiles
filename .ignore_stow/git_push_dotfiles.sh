#!/usr/bin/env bash

# Este script sincroniza (comita e envia) o diretório dotfiles.

# Change to your dotfiles directory
cd $HOME/dotfiles || exit

# Scan for secrets before doing anything
echo "Running secret scan..."
./scripts/security/scan_secrets.sh
if [ $? -ne 0 ]; then
    echo " Sync aborted: Secrets detected!"
    exit 1
fi

# Add all changes
git add -A

# Check if there is anything to commit
if ! git diff-index --quiet HEAD --; then
    # Commit changes with a timestamp
    echo "Committing new changes..."
    git commit -m "auto-sync: [$(date)]"
fi

# Push to your remote (Assumes your main branch is 'main')
echo "Attempting git push to origin main..."
git push origin main

# Verifica o status do push e exibe a mensagem de sucesso/falha
if [ $? -eq 0 ]; then
    echo " Sync successful at $(date)"
else
    # Se o push falhar (ex: credenciais, rede, ou upstream desatualizado),
    # o script notifica o usuário, mas não interrompe.
    echo " WARNING: Git push failed at $(date). Check credentials or network."
fi


