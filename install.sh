#!/bin/bash
# Master installation script for Erik's Omarchy customizations
set -eEo pipefail

export CONFIG_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export CONFIG_BIN="$CONFIG_PATH/bin"

source "$CONFIG_BIN/helpers.sh"

echo "========================================"
echo "  Installing Omarchy Customizations"
echo "========================================"
echo ""

# Install custom packages
source "$CONFIG_BIN/install-packages.sh"
echo ""

# Setup secrets
source "$CONFIG_BIN/install-secrets.sh"
echo ""

# Install dotfiles via stow
source "$CONFIG_BIN/install-dotfiles.sh"
echo ""

echo "========================================"
echo "  Installation complete!"
echo "========================================"
echo ""
echo "Next steps:"
echo "  1. Edit ~/.secrets and add your API keys"
echo "  2. Run: source ~/.bashrc"
echo "  3. Restart Hyprland to pick up new configs"
echo ""
