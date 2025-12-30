#!/bin/bash
# Use GNU Stow to symlink dotfiles

ensure_stow

echo "Installing dotfiles via stow..."

DOTFILES_DIR="$CONFIG_PATH/dotfiles"
TARGET_DIR="$HOME"

# List all stow packages (directories in dotfiles/)
packages=(
    "hypr"
    "nvim"
    "starship"
    "git"
    "waybar"
    "fastfetch"
    "btop"
    "bash"
)

for pkg in "${packages[@]}"; do
    if [ -d "$DOTFILES_DIR/$pkg" ]; then
        echo "  Stowing $pkg..."
        # --restow handles both new installs and updates
        # --adopt would move existing files into repo (useful for initial migration)
        stow -d "$DOTFILES_DIR" -t "$TARGET_DIR" --restow "$pkg" 2>/dev/null || {
            echo "    Warning: $pkg had conflicts, trying with --adopt..."
            stow -d "$DOTFILES_DIR" -t "$TARGET_DIR" --adopt --restow "$pkg"
        }
    fi
done

echo "Dotfiles complete."
