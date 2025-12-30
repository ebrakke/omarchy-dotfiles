#!/bin/bash
# Use GNU Stow to symlink dotfiles

ensure_stow

echo "Installing dotfiles via stow..."

DOTFILES_DIR="$CONFIG_PATH/dotfiles"
TARGET_DIR="$HOME"
BACKUP_DIR="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"

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

# Function to backup and remove conflicting files
backup_conflicts() {
    local pkg="$1"
    local pkg_dir="$DOTFILES_DIR/$pkg"

    # Find all files in the stow package and check for conflicts
    find "$pkg_dir" -type f | while read -r src_file; do
        # Get the relative path from the package directory
        rel_path="${src_file#$pkg_dir/}"
        target_file="$TARGET_DIR/$rel_path"

        # If target exists and is NOT a symlink, back it up
        if [ -e "$target_file" ] && [ ! -L "$target_file" ]; then
            mkdir -p "$BACKUP_DIR/$(dirname "$rel_path")"
            echo "    Backing up: $rel_path"
            mv "$target_file" "$BACKUP_DIR/$rel_path"
        fi
    done
}

for pkg in "${packages[@]}"; do
    if [ -d "$DOTFILES_DIR/$pkg" ]; then
        echo "  Stowing $pkg..."

        # First try normal stow
        if ! stow -d "$DOTFILES_DIR" -t "$TARGET_DIR" --restow "$pkg" 2>/dev/null; then
            echo "    Conflicts detected, backing up existing files..."
            backup_conflicts "$pkg"

            # Try again after backup
            stow -d "$DOTFILES_DIR" -t "$TARGET_DIR" --restow "$pkg"
        fi
    fi
done

if [ -d "$BACKUP_DIR" ]; then
    echo ""
    echo "  Backup created at: $BACKUP_DIR"
fi

echo "Dotfiles complete."
