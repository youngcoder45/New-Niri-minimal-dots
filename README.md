<p align="center">
  <img src="Screenshots/landing.png" alt="Niri Minimal Dots" width="800">
</p>

<h1 align="center">Niri Minimal Dots!</h1>

<p align="center">
  A clean, minimal <a href="https://github.com/YaLTeR/niri">Niri</a> Wayland compositor configuration for Arch Linux with Catppuccin Mocha theme.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Niri-Wayland_compositor-5E9FD6?style=flat-square&logo=gnome-terminal&logoColor=white" alt="Niri">
  <img src="https://img.shields.io/badge/Arch_Linux-1793D1?style=flat-square&logo=archlinux&logoColor=white" alt="Arch Linux">
  <img src="https://img.shields.io/badge/License-MIT-green?style=flat-square" alt="MIT License">
</p>

---

## Preview

| Desktop | Tiled | Waybar |
|---------|-------|--------|
| ![Desktop](Screenshots/desktop.png) | ![Tiled](Screenshots/desktop-tiled.png) | ![Waybar](Screenshots/waybar.png) |

| Launcher | Workspaces | Zed |
|----------|------------|-----|
| ![Launcher](Screenshots/launcher.png) | ![Workspaces](Screenshots/workspaces.png) | ![Zed](Screenshots/zed.png) |

| Neovim | Power Menu | Wallpaper Picker |
|--------|------------|------------------|
| ![Neovim](Screenshots/neovim.png) | ![Power Menu](Screenshots/powermenu.png) | ![Wallpapers](Screenshots/wallpaperpicker.png) |

| btop | Cava |
|------|------|
| ![btop](Screenshots/btopbtm.png) | ![Cava](Screenshots/cava.png) |

---

## Features

- **Niri** — scrollable tiling Wayland compositor with blur and animations
- **Waybar** — modular status bar with player, clipboard, notifications, power modules
- **Fuzzel** — fast Wayland-native application launcher
- **Fish** — smart shell with Catppuccin Mocha syntax highlighting
- **Catppuccin Mocha** — cohesive color scheme across all components
- **Custom scripts** — clipboard history, notification history, power menu, wallpaper picker
- **gtklock** — styled lock screen
- **Minimal footprint** — no unnecessary bloat

---

## Applications Used

| Category | Application |
|----------|-------------|
| Compositor | [Niri](https://github.com/YaLTeR/niri) |
| Bar | [Waybar](https://github.com/Alexays/Waybar) |
| Launcher | [Fuzzel](https://codeberg.org/dnkl/fuzzel) |
| Terminal | [Alacritty](https://github.com/alacritty/alacritty) + [Kitty](https://sw.kovidgoyal.net/kitty/) |
| Shell | [Fish](https://fishshell.com/) |
| Prompt | [Starship](https://starship.rs/) |
| Notification Daemon | [Mako](https://github.com/emersion/mako) |
| Lock Screen | [Gtklock](https://github.com/jovanlanik/gtklock) |
| Power Menu | [Wlogout](https://github.com/nicoplv/wlogout) |
| Clipboard | [Cliphist](https://github.com/sentriz/cliphist) + [wl-clipboard](https://github.com/bugaevc/wl-clipboard) |
| Screenshot | [Flameshot](https://flameshot.org/) + [Swappy](https://github.com/jtheo/swappy) |
| Wallpaper | [Swaybg](https://github.com/swaywm/swaybg) |
| File Manager | [Nautilus](https://apps.gnome.org/Nautilus/) + [nnn](https://github.com/jarun/nnn) |
| Code Editor | [Neovim](https://neovim.io/) (LazyVim) + [VS Code](https://code.visualstudio.com/) + [Zed](https://zed.dev/) |
| Browser | [Brave](https://brave.com/) + [Firefox](https://www.mozilla.org/) |
| Media Player | [mpv](https://mpv.io/) + [VLC](https://www.videolan.org/) |
| System Monitor | [Bottom](https://github.com/ClementTsang/bottom) + [btop](https://github.com/aristocratos/btop) |
| Audio Visualizer | [Cava](https://github.com/kornerc/cava) |
| Git UI | [Lazygit](https://github.com/jesseduffield/lazygit) |
| System Info | [Fastfetch](https://github.com/fastfetch-cli/fastfetch) |
| Pomodoro | [Pomoru](https://github.com/animeai/pomoru) |
| Network | [NetworkManager](https://networkmanager.dev/) |
| Bluetooth | [BlueZ](https://www.bluez.org/) |
| Display Manager | [SDDM](https://github.com/sddm/sddm) |

---

## Installation

### Prerequisites

- Fresh Arch Linux installation
- Internet connection
- SDDM display manager

### Quick Start

```bash
# Clone the repository
git clone https://github.com/youngcoder45/New-Niri-minimal-dots.git ~/.config
cd ~/.config

# Run the installer
chmod +x install.sh
./install.sh

# Reboot
sudo reboot
```

### Manual Installation

```bash
# Install packages
sudo pacman -S --needed - < packages.txt

# Install yay (AUR helper)
git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin
cd /tmp/yay-bin && makepkg -si

# Install AUR packages
yay -S niri-git niri-settings-git niri-utils bibata-cursor-theme-bin brave-bin vesktop-bin sddm-sugar-candy-git pomoru

# Symlink configs
for dir in */; do
    case "$dir" in .git|Screenshots|wallpapers|local) continue;; esac
    ln -sfn "$(pwd)/$dir" "$HOME/.config/$dir"
done

# Set fish as default shell
chsh -s /usr/bin/fish

# Enable SDDM
sudo systemctl enable sddm
```

---

## Keybindings

### Applications

| Keybinding | Action |
|------------|--------|
| `Mod + Return` | Open terminal (Alacritty) |
| `Alt + Return` | Open terminal (Kitty) |
| `Mod + Space` | Application launcher (Fuzzel) |
| `Mod + B` | Open browser (Firefox) |
| `Mod + C` | Open code editor (VS Code) |
| `Mod + V` | Open Vesktop (Discord) |
| `Mod + E` | Open file manager (Nautilus) |
| `Mod + Z` | Open Zed editor |
| `Mod + L` | Lock screen (Gtklock) |
| `Mod + T` | Power menu (Wlogout) |
| `Print` | Screenshot (Flameshot) |

### Window Management

| Keybinding | Action |
|------------|--------|
| `Mod + Q` | Close window |
| `Mod + F` | Maximize column |
| `Mod + Shift + F` | Fullscreen window |
| `Mod + D` | Toggle floating |
| `Mod + Shift + V` | Switch focus floating/tiling |
| `Mod + W` | Toggle tabbed column |
| `Mod + R` | Cycle column width |
| `Mod + H/J/K/L` | Focus left/down/up/right |
| `Mod + Ctrl + H/J/K/L` | Move window left/down/up/right |

### Workspaces

| Keybinding | Action |
|------------|--------|
| `Mod + 1-9` | Switch to workspace 1-9 |
| `Mod + Ctrl + 1-9` | Move window to workspace 1-9 |
| `Mod + U/I` | Workspace down/up |
| `Mod + Ctrl + U/I` | Move window to workspace down/up |

### Monitors

| Keybinding | Action |
|------------|--------|
| `Mod + Shift + H/J/K/L` | Focus monitor left/down/up/right |
| `Mod + Shift + Ctrl + H/J/K/L` | Move window to monitor |

### Media Keys

| Keybinding | Action |
|------------|--------|
| `XF86AudioRaise/Lower` | Volume up/down |
| `XF86AudioMute` | Toggle mute |
| `XF86AudioMicMute` | Toggle mic mute |
| `XF86AudioPlay/Prev/Next` | Media controls |
| `XF86BrightnessUp/Down` | Brightness up/down |

### Screenshots

| Keybinding | Action |
|------------|--------|
| `Print` | Screenshot (Flameshot GUI) |
| `Ctrl + Print` | Screenshot (current output) |
| `Alt + Print` | Screenshot (current window) |

---

## Scripts

### Waybar Scripts (`waybar/scripts/`)

| Script | Description |
|--------|-------------|
| `powermenu.sh` | Fuzzel-based power menu |
| `clipboard.sh` | Cliphist clipboard manager |
| `bluetooth-control.sh` | Bluetooth device picker |
| `bluetooth.sh` | Bluetooth status display |
| `volume-control.sh` | Volume control with device selection |
| `network-control.sh` | Network manager with WiFi scanning |
| `notifications.sh` | Notification count display |
| `mediaplayer.sh` | Media player status |
| `launch-waybar.sh` | Waybar launcher |

### User Scripts (`local/bin/`)

| Script | Description |
|--------|-------------|
| `powermenu` | Fuzzel-based power menu (standalone) |
| `set-wallpaper` | Wallpaper picker with swaybg integration |
| `clipboard-history` | Cliphist clipboard manager with fuzzel |
| `notification-history` | Notification history viewer |
| `mako-history` | Mako notification history |

---

## Directory Structure

```
├── alacritty/          # Terminal configuration
│   └── alacritty.toml
├── btop/               # System monitor
│   └── btop.conf
├── bottom/             # System monitor (alternative)
│   └── bottom.toml
├── cava/               # Audio visualizer
│   ├── config
│   ├── shaders/
│   └── themes/
├── environment.d/      # Environment variables
│   ├── cursors.conf
│   └── unset-gtk-theme.conf
├── fastfetch/          # System info display
│   └── config.jsonc
├── fish/               # Shell configuration
│   ├── config.fish
│   └── conf.d/
├── flameshot/          # Screenshot tool
│   └── flameshot.ini
├── fuzzel/             # Application launcher
│   └── fuzzel.ini
├── godot/              # Game engine settings
│   └── editor_settings-4.5.tres
├── gtk-3.0/            # GTK3 theme settings
│   ├── settings.ini
│   ├── gtk.css
│   ├── colors.css
│   └── bookmarks
├── gtk-4.0/            # GTK4 theme settings
│   ├── settings.ini
│   ├── gtk.css
│   ├── gtk-dark.css
│   └── colors.css
├── kitty/              # Kitty terminal
│   ├── kitty.conf
│   ├── colors.conf
│   └── sessions/
├── lazygit/            # Git TUI
│   └── config.yml
├── local/bin/          # User scripts
│   ├── powermenu
│   ├── set-wallpaper
│   ├── clipboard-history
│   ├── notification-history
│   └── mako-history
├── mako/               # Notification daemon
│   └── config
├── mpv/                # Media player
│   ├── mpv.conf
│   ├── fonts/
│   ├── script-opts/
│   └── scripts/
├── niri/               # Window manager
│   ├── config.kdl
│   ├── basicsettings.kdl
│   ├── keybinds.kdl
│   ├── window_rules.kdl
│   ├── autostart.sh
│   └── index.theme
├── niri-lock/          # Lock screen
│   ├── config.ini
│   ├── lock.sh
│   └── style.css
├── nvim/               # LazyVim config
│   ├── init.lua
│   ├── lazy-lock.json
│   └── lua/
├── pomoru/             # Pomodoro timer
│   └── config.toml
├── qt6ct/              # Qt6 theme
│   └── qt6ct.conf
├── starship/           # Shell prompt
│   └── starship.toml
├── swappy/             # Screenshot annotation
│   └── config
├── tmux/               # Terminal multiplexer
│   └── tmux.conf
├── vlc/                # Media player
│   └── vlcrc
├── waybar/             # Status bar
│   ├── config.jsonc
│   ├── style.css
│   ├── modules/
│   └── scripts/
├── wlogout/            # Power menu
│   ├── layout
│   ├── style.css
│   └── icons/
├── zed/                # Zed editor
│   ├── settings.json
│   ├── snippets/
│   └── themes/
├── wallpapers/         # Wallpaper storage
├── Screenshots/        # Repository screenshots
├── packages.txt        # Package list
├── install.sh          # Installation script
├── LICENSE             # MIT License
└── README.md           # This file
```

---

## Themes

| Component | Theme |
|-----------|-------|
| GTK Theme | adw-gtk3-dark |
| Icon Theme | Papirus-Dark |
| Cursor Theme | Bibata-Modern-Classic |
| Fish Shell | Catppuccin Mocha |
| Waybar | Catppuccin Mocha |

---

## FAQ

### Q: How do I change the wallpaper?

Place images in `~/Pictures/wallpapers/`. Run `~/.local/bin/set-wallpaper` to pick a wallpaper interactively.

### Q: How do I change the color scheme?

Edit the color values in:
- `waybar/style.css` — Waybar styling
- `mako/config` — Notification colors
- `fish/conf.d/fish_frozen_theme.fish` — Fish syntax highlighting
- `niri-lock/style.css` — Lock screen colors

### Q: How do I add more Waybar modules?

Edit `waybar/config.jsonc` and add modules to `modules-left`, `modules-center`, or `modules-right`. Module definitions are in `waybar/modules/`.

### Q: How do I change the terminal font?

Edit `alacritty/alacritty.toml` for Alacritty or `kitty/kitty.conf` for Kitty.

---

## Troubleshooting

### Waybar not showing
```bash
killall waybar
~/.config/waybar/scripts/launch-waybar.sh
```

### No notifications
```bash
killall mako
mako &
```

### Wallpaper not changing
```bash
# Test manually
swaybg -i ~/Pictures/wallpapers/your-wallpaper.jpg -m fill &
```

### Lock screen not working
```bash
# Test gtklock manually
gtklock --config ~/.config/niri-lock/config.ini
```

---

## Credits

- [Niri](https://github.com/YaLTeR/niri) — Wayland compositor
- [Waybar](https://github.com/Alexays/Waybar) — Status bar
- [Fuzzel](https://codeberg.org/dnkl/fuzzel) — Application launcher
- [Catppuccin](https://github.com/catppuccin/catppuccin) — Color scheme
- [LazyVim](https://github.com/LazyVim/LazyVim) — Neovim config

---

## License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.

---

<p align="center">
  Made with ❤️ by <a href="https://github.com/youngcoder45">Aditya Verma</a>
</p>
