#!/bin/bash
# Shared helper functions for installation scripts

# Check if a package is installed
is_installed() {
    pacman -Qi "$1" &>/dev/null
}

# Idempotent AUR install using yay
install_aur() {
    local pkg="$1"
    if is_installed "$pkg"; then
        echo "  $pkg already installed, skipping..."
        return 0
    fi
    echo "  Installing $pkg..."
    yay -S --noconfirm --needed "$pkg"
}

# Ensure stow is available
ensure_stow() {
    if ! command -v stow &>/dev/null; then
        echo "Installing stow..."
        sudo pacman -S --noconfirm --needed stow
    fi
}
