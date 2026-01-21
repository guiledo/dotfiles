#!/bin/bash

# Define output files relative to the script location
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NATIVE_LIST="${SCRIPT_DIR}/pkglist_native.txt"
AUR_LIST="${SCRIPT_DIR}/pkglist_aur.txt"

echo "Generating package lists..."

# Backup Native Packages (Explicitly installed)
# -Q: Query
# -q: Quiet (print only names)
# -e: Explicitly installed
# -n: Native only
if pacman -Qqen > "$NATIVE_LIST"; then
    echo "Native package list saved to $NATIVE_LIST"
else
    echo "Error listing native packages."
fi

# Backup AUR Packages (Explicitly installed)
# -m: Foreign (AUR)
if pacman -Qqem > "$AUR_LIST"; then
    echo "AUR package list saved to $AUR_LIST"
else
    echo "Error listing AUR packages (or none installed)."
fi

echo "Backup complete."
