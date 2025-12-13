#!/bin/bash
# Dotfiles installation script
# Installs modern shell configuration with machine type detection

set -e

echo "🚀 Modern Shell Configuration Installer"
echo "========================================"
echo ""

# Detect dotfiles location
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DOTFILES_DIR="$SCRIPT_DIR"

echo "Dotfiles directory: $DOTFILES_DIR"
echo ""

# Create necessary directories
echo "📁 Creating configuration directories..."
mkdir -p ~/.config/shell
mkdir -p ~/.local/share
mkdir -p ~/.zsh/cache

# Backup existing .zshrc if it exists
if [ -f ~/.zshrc ]; then
  BACKUP_FILE=~/.zshrc.backup-$(date +%Y%m%d-%H%M%S)
  echo "💾 Backing up existing .zshrc to $BACKUP_FILE"
  cp ~/.zshrc "$BACKUP_FILE"
fi

# Link .zshrc
echo "🔗 Linking .zshrc..."
ln -sf "$DOTFILES_DIR/zsh/.zshrc" ~/.zshrc

# Set machine type (optional)
echo ""
echo "Machine type detection:"
echo "  - Will auto-detect based on hostname/environment"
echo "  - To manually override, create: ~/.config/shell/machine-type"
echo "  - Options: prod, dev-server, gaming-server, dedicated-server, homelab, wsl, laptop-personal, laptop-pro"
echo ""

# Ask if user wants to set machine type manually
read -p "Set machine type manually? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo "Select machine type:"
  echo "1) laptop-personal"
  echo "2) laptop-pro (work laptop)"
  echo "3) wsl"
  echo "4) server (generic)"
  echo "5) prod (production server)"
  read -p "Choice (1-5): " -n 1 -r CHOICE
  echo

  case $CHOICE in
    1) echo "laptop-personal" > ~/.config/shell/machine-type ;;
    2) echo "laptop-pro" > ~/.config/shell/machine-type && touch ~/.config/shell/laptop-pro ;;
    3) echo "wsl" > ~/.config/shell/machine-type ;;
    4) echo "dev-server" > ~/.config/shell/machine-type ;;
    5) echo "prod" > ~/.config/shell/machine-type ;;
    *) echo "Invalid choice, will use auto-detection" ;;
  esac
fi

# Check if zsh is installed
if ! command -v zsh &> /dev/null; then
  echo "⚠️  zsh is not installed!"
  echo "Please install zsh first:"
  echo "  - macOS: brew install zsh"
  echo "  - Ubuntu/Debian: sudo apt install zsh"
  echo "  - RHEL/CentOS: sudo yum install zsh"
  exit 1
fi

# Check if git is installed (needed for zinit)
if ! command -v git &> /dev/null; then
  echo "⚠️  git is not installed!"
  echo "Please install git first"
  exit 1
fi

echo ""
echo "✅ Installation complete!"
echo ""
echo "Next steps:"
echo "1. Install Starship:"
echo "   - macOS: brew install starship"
echo "   - Linux: curl -sS https://starship.rs/install.sh | sh"
echo ""
echo "2. Install modern tools (optional but recommended):"
echo "   - fzf, zoxide, bat, eza, fd, ripgrep"
echo "   - macOS: brew install fzf zoxide bat eza fd ripgrep"
echo "   - Linux: See project README for installation instructions"
echo ""
echo "3. Set zsh as default shell (if not already):"
echo "   - chsh -s \$(which zsh)"
echo ""
echo "4. Start a new shell or run:"
echo "   - exec zsh"
echo ""
echo "On first startup, zinit will auto-install and download plugins."
echo "This may take a few seconds."
echo ""
