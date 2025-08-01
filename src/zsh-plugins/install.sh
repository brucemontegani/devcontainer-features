#!/usr/bin/env bash
set -e

# Define remote user and Zsh custom plugin directory
ZSH_CUSTOM="${_REMOTE_USER_HOME}/.oh-my-zsh/custom"
ZSHRC="${_REMOTE_USER_HOME}/.zshrc"

install_plugin() {
  local repo_url="$1"
  local plugin_name="$2"
  local target_dir="$ZSH_CUSTOM/plugins/$plugin_name"

  if [ ! -d "$target_dir" ]; then
    echo "Installing $plugin_name..."
    git clone --depth=1 "$repo_url" "$target_dir"
  else
    echo "$plugin_name already installed. Skipping."
  fi
}

ensure_plugins_line() {
  if grep -q "^plugins=" "$ZSHRC"; then
    sed -i "s/^plugins=(/plugins=(zsh-autosuggestions zsh-syntax-highlighting /" "$ZSHRC"
  else
    echo "plugins=(zsh-autosuggestions zsh-syntax-highlighting)" >> "$ZSHRC"
  fi
}

# Create custom plugins directory if not exists
mkdir -p "$ZSH_CUSTOM/plugins"

# Install popular plugins
install_plugin https://github.com/zsh-users/zsh-autosuggestions zsh-autosuggestions
install_plugin https://github.com/zsh-users/zsh-syntax-highlighting zsh-syntax-highlighting

# Enable plugins in .zshrc
ensure_plugins_line

# Set correct ownership
chown -R "${_REMOTE_USER}:${_REMOTE_USER}" "$ZSH_CUSTOM"
chown "${_REMOTE_USER}:${_REMOTE_USER}" "$ZSHRC"

# Confirmation
echo "✅ Oh My Zsh plugins installed and enabled."
