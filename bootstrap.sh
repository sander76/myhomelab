#!/usr/bin/env bash
set -euo pipefail

# Bootstrap script for myhomelab

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Use sudo only if not running as root
SUDO=""
if [[ $EUID -ne 0 ]]; then
  SUDO="sudo"
fi

$SUDO apt update && $SUDO apt upgrade -y

$SUDO apt install -y curl
curl https://mise.run/bash | sh


# Add mise to PATH only for this session
export PATH="$HOME/.local/bin:$PATH"

# Activate mise for only this session
eval "$(mise activate bash)"

# Symlink mise_config.toml as global config
echo "==> Installing tools from mise_config.toml as global config..."
mkdir -p "$HOME/.config/mise"
ln -sf "$SCRIPT_DIR/mise_config.toml" "$HOME/.config/mise/config.toml"
mise trust "$HOME/.config/mise/config.toml"
mise install
