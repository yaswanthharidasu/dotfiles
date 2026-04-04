#!/bin/bash
set -e

# ==============================================================================
# Homebrew - Package manager for macOS and Linux
# ==============================================================================
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Add brew to PATH based on OS
  if [ -d /home/linuxbrew/.linuxbrew ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc
  elif [ -d /opt/homebrew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
fi

# ==============================================================================
# Oh My Zsh - Zsh framework with plugins and themes
# ==============================================================================
# Install oh-my-zsh (non-interactive)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Download custom theme
curl -fsSL https://raw.githubusercontent.com/yaswanthharidasu/dotfiles/master/oh-my-zsh/my-af-magic.zsh-theme \
  -o ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/my-af-magic.zsh-theme

# Set plugins and theme in .zshrc
sed -i 's/^plugins=(.*/plugins=(git vi-mode tmux zsh-syntax-highlighting zsh-autosuggestions)/' ~/.zshrc
sed -i 's/^ZSH_THEME=.*/ZSH_THEME="my-af-magic"/' ~/.zshrc

# ==============================================================================
# Tmux - Terminal multiplexer
# ==============================================================================
brew install tmux

# Download tmux config
curl -fsSL https://raw.githubusercontent.com/yaswanthharidasu/dotfiles/master/tmux/tmux.conf \
  -o ~/.tmux.conf

# ==============================================================================
# Zoxide - Smart directory navigation (replaces cd)
# ==============================================================================
brew install zoxide fzf
echo 'eval "$(zoxide init zsh --cmd cd)"' >> ~/.zshrc

source ~/.zshrc
