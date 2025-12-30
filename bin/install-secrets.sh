#!/bin/bash
# Setup secrets file and configure bashrc

SECRETS_FILE="$HOME/.secrets"
TEMPLATE_FILE="$CONFIG_PATH/.secrets.template"

# Create secrets file from template if it doesn't exist
if [ ! -f "$SECRETS_FILE" ]; then
    echo "Creating ~/.secrets from template..."
    cp "$TEMPLATE_FILE" "$SECRETS_FILE"
    chmod 600 "$SECRETS_FILE"
    echo ""
    echo "  IMPORTANT: Edit ~/.secrets and add your API keys!"
    echo ""
else
    echo "  ~/.secrets already exists, skipping..."
fi

# Ensure .bashrc sources .bashrc.local
if ! grep -q "bashrc.local" "$HOME/.bashrc" 2>/dev/null; then
    echo "Adding .bashrc.local source to .bashrc..."
    echo '' >> "$HOME/.bashrc"
    echo '# Load custom configurations' >> "$HOME/.bashrc"
    echo '[[ -f ~/.bashrc.local ]] && source ~/.bashrc.local' >> "$HOME/.bashrc"
else
    echo "  .bashrc already sources .bashrc.local"
fi

echo "Secrets setup complete."
