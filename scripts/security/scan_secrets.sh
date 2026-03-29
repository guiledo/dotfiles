#!/usr/bin/env bash

# Secret Scanning Script for Dotfiles
# This script searches for common patterns that might indicate secrets or sensitive info using git grep.

# Define the colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Define the patterns to search for (using extended regex for git grep)
# Note: we use -E for extended regex in git grep
PATTERNS=(
    'AKIA[0-9A-Z]{16}'                                          # AWS Access Key ID
    'ghp_[a-zA-Z0-9]{36}'                                       # GitHub Personal Access Token
    'gho_[a-zA-Z0-9]{36}'                                       # GitHub OAuth Token
    'xox[bap]-[a-zA-Z0-9-]{10,}'                                # Slack Token
    'sk_live_[0-9a-zA-Z]{24}'                                   # Stripe API Key
    'AIza[0-9A-Za-z\-_]{35}'                                    # Google API Key
    '-----BEGIN [A-Z ]*PRIVATE KEY-----'                         # Generic Private Key
    '(password|passphrase|token|secret|api|auth|cred|ssh-)[^=]*[=:][^ \/\n]{12,}' # Potential secrets (excluding URLs)
)

# Files/Directories to exclude (relative to repo root)
EXCLUDE=(
    ':(exclude).git'
    ':(exclude)oh-my-zsh'
    ':(exclude)node_modules'
    ':(exclude).cache'
    ':(exclude)scripts/security/scan_secrets.sh'
    ':(exclude).ignore_stow/default-cursor'
    ':(exclude).ignore_stow/default-vscode'
    ':(exclude)*.png'
    ':(exclude)*.jpg'
    ':(exclude)*.jpeg'
    ':(exclude)*.gif'
    ':(exclude)*.svg'
    ':(exclude)*.ico'
    ':(exclude)*.lock'
    ':(exclude)*.json'
    ':(exclude)opencode/.config/opencode/skills/docx/scripts/comment.py'
    ':(exclude)opencode/.config/opencode/skills/docx/scripts/office/schemas/ISO-IEC29500-4_2016/sml.xsd'
    ':(exclude)opencode/.config/opencode/skills/docx/scripts/office/validate.py'
    ':(exclude)opencode/.config/opencode/skills/mcp-builder/reference/python_mcp_server.md'
    ':(exclude)opencode/.config/opencode/skills/pptx/scripts/office/schemas/ISO-IEC29500-4_2016/sml.xsd'
    ':(exclude)opencode/.config/opencode/skills/pptx/scripts/office/validate.py'
    ':(exclude)opencode/.config/opencode/skills/xlsx/scripts/office/schemas/ISO-IEC29500-4_2016/sml.xsd'
    ':(exclude)opencode/.config/opencode/skills/xlsx/scripts/office/validate.py'
)

echo -e "${YELLOW}Scanning tracked files for potential secrets...${NC}"

FOUND_SECRETS=0

for pattern in "${PATTERNS[@]}"; do
    # Use git grep to search only tracked files
    # -E: extended regex
    # -n: line numbers
    # -i: ignore case for some patterns if needed (but here we stay case sensitive for tokens)
    # -I: don't match in binary files
    MATCHES=$(git grep -EnI "$pattern" -- . "${EXCLUDE[@]}" 2>/dev/null)
    
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
    echo -e "${GREEN}No potential secrets found in tracked files.${NC}"
    exit 0
fi
