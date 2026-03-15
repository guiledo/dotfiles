#!/usr/bin/env bash

# Secret Scanning Script for Dotfiles
# This script searches for common patterns that might indicate secrets or sensitive info.

# Define the colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Define the patterns to search for
PATTERNS=(
    # AWS Access Key ID
    'AKIA[0-9A-Z]{16}'
    # AWS Secret Access Key
    '[^a-zA-Z0-9/+=][a-zA-Z0-9/+=]{40}[^a-zA-Z0-9/+=]'
    # GitHub Personal Access Token
    'ghp_[a-zA-Z0-9]{36}'
    # GitHub OAuth Token
    'gho_[a-zA-Z0-9]{36}'
    # Slack Token
    'xox[bap]-[a-zA-Z0-9-]{10,}'
    # Stripe API Key
    'sk_live_[0-9a-zA-Z]{24}'
    # Google API Key
    'AIza[0-9A-Za-z\\-_]{35}'
    # Generic Private Key
    '-----BEGIN [A-Z ]*PRIVATE KEY-----'
    # Potential passwords/secrets in config files
    '(password|passphrase|token|secret|key|api|auth|cred|ident|account|user|private|ssh-)[^=]*[=:][^ \n]{8,}'
)

# Files to exclude (like this script itself)
EXCLUDE_PATTERNS=(
    'scripts/security/scan_secrets.sh'
    '*.png'
    '*.jpg'
    '*.jpeg'
    '*.gif'
    '*.svg'
    '*.ico'
    '*.woff'
    '*.woff2'
    '*.ttf'
    '*.otf'
    '*.lock'
    '*.json'
)

# Directories to exclude
EXCLUDE_DIRS=(
    '.git'
    'oh-my-zsh'
    'node_modules'
    '.cache'
)

# Build the exclude arguments for grep
EXCLUDE_ARGS=()
for pattern in "${EXCLUDE_PATTERNS[@]}"; do
    EXCLUDE_ARGS+=(--exclude="$pattern")
done

for dir in "${EXCLUDE_DIRS[@]}"; do
    EXCLUDE_ARGS+=(--exclude-dir="$dir")
done

echo -e "${YELLOW}Scanning for potential secrets...${NC}"

FOUND_SECRETS=0

for pattern in "${PATTERNS[@]}"; do
    # Search for the pattern in all files, excluding some
    # Use -E for extended regex
    # Use -r for recursive
    # Use -n for line numbers
    # Use -I to skip binary files
    MATCHES=$(grep -rEnI "${EXCLUDE_ARGS[@]}" "$pattern" . 2>/dev/null)
    
    if [[ -n "$MATCHES" ]]; then
        echo -e "${RED}Found potential secret for pattern: $pattern${NC}"
        echo "$MATCHES"
        FOUND_SECRETS=1
    fi
done

if [[ $FOUND_SECRETS -eq 1 ]]; then
    echo -e "${RED}ERROR: Potential secrets found! Please review before pushing.${NC}"
    exit 1
else
    echo -e "${GREEN}No potential secrets found.${NC}"
    exit 0
fi
