#!/bin/bash
# Install custom AUR packages not included in base Omarchy

echo "Installing custom packages..."

packages=(
    "claude-code"
    "freecad"
    "brave-bin"
)

for pkg in "${packages[@]}"; do
    install_aur "$pkg"
done

echo "Packages complete."
