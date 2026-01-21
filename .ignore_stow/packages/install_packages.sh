#!/bin/bash

# Define input files relative to the script location
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NATIVE_LIST="${SCRIPT_DIR}/pkglist_native.txt"
AUR_LIST="${SCRIPT_DIR}/pkglist_aur.txt"

# Helper function for printing status
log() {
    echo -e "\n\033[1;34m::\033[0m \033[1m$1\033[0m"
}

log "Starting package restoration..."

# 1. Update system and install prerequisites
log "Updating system and ensuring base-devel/git are installed..."
sudo pacman -Syu --needed base-devel git

# 2. Check/Install Paru (AUR Helper)
if ! command -v paru &> /dev/null; then
    log "Paru not found. Installing paru-bin..."
    
    # Create a temp directory for building paru
    BUILD_DIR=$(mktemp -d)
    git clone https://aur.archlinux.org/paru-bin.git "$BUILD_DIR"
    
    cd "$BUILD_DIR" || exit
    makepkg -si --noconfirm
    
    cd "$SCRIPT_DIR" || exit
    rm -rf "$BUILD_DIR"
    log "Paru installed successfully."
else
    log "Paru is already installed."
fi

# 3. Install Native Packages
if [ -f "$NATIVE_LIST" ]; then
    log "Installing native packages from list..."
    # --needed skips already installed packages
    sudo pacman -S --needed - < "$NATIVE_LIST"
else
    echo "Warning: $NATIVE_LIST not found."
fi

# 4. Install AUR Packages
if [ -f "$AUR_LIST" ]; then
    log "Installing AUR packages from list..."
    # remove debug packages from list if present (optional safety)
    # GREP_INVERT_MATCH="-v"
    
    # Reading into array to avoid issues with piping if paru asks for sudo
    # However, standard input redirection works for paru/pacman usually.
    # We use 'paru -S --needed -' similar to pacman.
    paru -S --needed - < "$AUR_LIST"
else
    echo "Warning: $AUR_LIST not found."
fi

log "Restoration complete!"
