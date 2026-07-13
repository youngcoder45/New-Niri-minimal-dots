#!/bin/bash
# ╔═══════════════════════════════════════════════════════════════╗
# ║  Niri Minimal Dots - Installation Script                     ║
# ║  Fresh Arch → Clone → Run → Working Desktop                  ║
# ╚═══════════════════════════════════════════════════════════════╝

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_DIR="$DOTFILES_DIR"

# ── Colors ─────────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log()   { echo -e "${GREEN}[+]${NC} $1"; }
warn()  { echo -e "${YELLOW}[!]${NC} $1"; }
error() { echo -e "${RED}[x]${NC} $1"; exit 1; }
info()  { echo -e "${BLUE}[i]${NC} $1"; }

# ── Preflight Checks ──────────────────────────────────────────
if ! command -v pacman &>/dev/null; then
    error "This script is designed for Arch Linux (pacman not found)"
fi

if [ "$(id -u)" -eq 0 ]; then
    error "Do not run this script as root"
fi

echo -e "${BLUE}"
echo "  ╔═══════════════════════════════════════╗"
echo "  ║     Niri Minimal Dots Installer       ║"
echo "  ╚═══════════════════════════════════════╝"
echo -e "${NC}"

# ── Install Packages ───────────────────────────────────────────
log "Installing packages from packages.txt..."
if [ -f "$DOTFILES_DIR/packages.txt" ]; then
    sudo pacman -S --needed --noconfirm - < "$DOTFILES_DIR/packages.txt"
else
    warn "packages.txt not found, skipping package installation"
fi

# ── Install yay (AUR helper) ──────────────────────────────────
if ! command -v yay &>/dev/null; then
    log "Installing yay (AUR helper)..."
    git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin
    (cd /tmp/yay-bin && makepkg -si --noconfirm)
    rm -rf /tmp/yay-bin
fi

# ── Install AUR packages ──────────────────────────────────────
log "Installing AUR packages..."
yay -S --needed --noconfirm \
    niri-git \
    niri-settings-git \
    niri-utils \
    bibata-cursor-theme-bin \
    brave-bin \
    vesktop-bin \
    sddm-sugar-candy-git \
    pomoru \
    2>/dev/null || warn "Some AUR packages may have failed"

# ── Create Directories ────────────────────────────────────────
log "Creating directories..."
mkdir -p "$HOME/.config"
mkdir -p "$HOME/Pictures/wallpapers"
mkdir -p "$HOME/Pictures/Screenshots"

# ── Symlink Configurations ────────────────────────────────────
log "Linking configurations to ~/.config/..."

link_config() {
    local src="$1"
    local dest="$HOME/.config/$2"
    local name="$2"

    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
        warn "Backing up existing $name → $name.bak"
        mv "$dest" "$dest.bak.$(date +%s)"
    fi

    ln -sfn "$src" "$dest"
    log "Linked $name"
}

# Link all config directories
for dir in "$CONFIG_DIR"/*/; do
    app_name=$(basename "$dir")

    # Skip directories that aren't configs
    case "$app_name" in
        .git|Screenshots|wallpapers|local) continue ;;
    esac

    link_config "$dir" "$app_name"
done

# Link local/bin scripts
if [ -d "$CONFIG_DIR/local/bin" ]; then
    mkdir -p "$HOME/.local/bin"
    for script in "$CONFIG_DIR/local/bin/"*; do
        [ -f "$script" ] || continue
        script_name=$(basename "$script")
        ln -sfn "$script" "$HOME/.local/bin/$script_name"
    done
    log "Linked local/bin scripts"
fi

# ── Set Fish as Default Shell ──────────────────────────────────
if [ "$SHELL" != "/usr/bin/fish" ]; then
    log "Setting fish as default shell..."
    chsh -s /usr/bin/fish
    info "Shell changed to fish. Will take effect on next login."
fi

# ── Enable Services ────────────────────────────────────────────
log "Enabling services..."
sudo systemctl enable sddm 2>/dev/null || true

# ── Fix Hardcoded Paths ───────────────────────────────────────
log "Fixing hardcoded paths..."
find "$CONFIG_DIR" -type f \( -name "*.css" -o -name "*.kdl" -o -name "*.toml" -o -name "*.ini" -o -name "*.sh" -o -name "*.jsonc" -o -name "*.json" -o -name "bookmarks" -o -name "*.conf" -o -name "layout" -o -name "flameshot.ini" \) \
    -exec sed -i "s|__HOME__|$HOME|g" {} \; 2>/dev/null || true

# ── Make Scripts Executable ────────────────────────────────────
log "Setting script permissions..."
find "$CONFIG_DIR" -name "*.sh" -exec chmod +x {} \; 2>/dev/null || true
find "$CONFIG_DIR/local/bin" -type f -exec chmod +x {} \; 2>/dev/null || true

# ── Done ───────────────────────────────────────────────────────
echo ""
echo -e "${GREEN}╔═══════════════════════════════════════════╗"
echo -e "║     Installation Complete!                ║"
echo -e "╚═══════════════════════════════════════════╝${NC}"
echo ""
echo -e "  ${YELLOW}Next steps:${NC}"
echo -e "  1. Reboot your system"
echo -e "  2. Add wallpapers to ~/Pictures/wallpapers/"
echo -e "  3. Enjoy your new desktop!"
echo ""
echo -e "  ${BLUE}Note:${NC} If using SDDM, restart it with:"
echo -e "  sudo systemctl restart sddm"
echo ""
