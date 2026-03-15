# Dotfiles Security

This repository includes automated secret scanning to prevent sensitive information (API keys, passwords, private keys) from being pushed to GitHub.

## Security Measures

- **Secret Scanner Script**: `scripts/security/scan_secrets.sh` - Uses `git grep` with robust regex patterns to find potential secrets.
- **Git Hooks**:
    - `pre-commit`: Scans tracked files before every commit.
    - `pre-push`: Scans tracked files before every push.
- **GitHub Action**: `.github/workflows/secret-scanning.yml` - Runs Gitleaks on every push to the remote.
- **Enhanced Sync Script**:
    - `.ignore_stow/git_push_dotfiles.sh`
    This script explicitly runs the secret scanner before proceeding.

## Installation of Git Hooks

Ensure the git hooks are executable to activate the local protection:
```bash
chmod +x .git/hooks/pre-commit .git/hooks/pre-push
```
The hooks are configured to call `scripts/security/scan_secrets.sh` before every commit and push.

## How to handle false positives

If the scanner finds a false positive (a string that looks like a secret but isn't), you can:
1.  **Refine the regex** in `scripts/security/scan_secrets.sh`.
2.  **Add the file or directory** to the `EXCLUDE` list in `scripts/security/scan_secrets.sh`.
