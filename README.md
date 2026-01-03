# Niri Minimal Dotfiles

A highly configured, minimal, and aesthetic collection of dotfiles for the [Niri](https://github.com/YaLTeR/niri) scrollable tiling window manager. This setup focuses on a clean "Noctalia" dark theme, modular configuration, and a keyboard-centric workflow.

## Gallery

![Desktop Overview](Screenshots/image.png)
![Terminal Workflow](Screenshots/image2.png)
![Application Launcher](Screenshots/image3.png)
![System Monitor](Screenshots/image4.png)
![Editor](Screenshots/image5.png)
![Lock Screen](Screenshots/image6.png)

## Components

| Component | Tool | Config Location |
|-----------|------|-----------------|
| **Window Manager** | [Niri](https://github.com/YaLTeR/niri) | `niri/config.kdl` |
| **Status Bar** | [Waybar](https://github.com/Alexays/Waybar) | `waybar/` |
| **Terminal** | [Alacritty](https://github.com/alacritty/alacritty) | `alacritty/` |
| **Shell** | [Fish](https://fishshell.com/) | `fish/` |
| **Prompt** | [Starship](https://starship.rs/) | `prompt/starship.toml` |
| **Editor** | [Neovim](https://neovim.io/) (NvChad) | `nvim/` |
| **Launcher** | [Fuzzel](https://codeberg.org/dnkl/fuzzel) | `fuzzel/` |
| **System Info** | [Fastfetch](https://github.com/fastfetch-cli/fastfetch) | `fastfetch/` |
| **System Monitor** | [Btop](https://github.com/aristocratos/btop) | `btop/` |
| **Visualizer** | [Cava](https://github.com/karlstav/cava) | `cava/` |
| **Lock Screen** | [Swaylock](https://github.com/swaywm/swaylock) | `swaylock/` |
| **Logout Menu** | [Wlogout](https://github.com/ArtsyMacaw/wlogout) | `wlogout/` |
| **Multiplexer** | [Tmux](https://github.com/tmux/tmux) | `tmux/` |

## Features

*   **Modular Waybar:** The Waybar configuration is split into modules (`waybar/modules/`) for easy customization and maintenance.
*   **Custom Fish Shell:** A ZSH-style configuration for Fish with syntax highlighting, aliases, and a custom Starship prompt.
*   **NvChad Integration:** Neovim is configured using NvChad v2.5 for a blazing fast and beautiful development environment.
*   **Consistent Theming:** A unified "Noctalia" color scheme applied across Alacritty, Niri, and other tools.
*   **Visual Eye Candy:** Includes configured Cava shaders and Fastfetch logos.

## Installation

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/yourusername/new-niri-minimal.git
    cd new-niri-minimal
    ```

2.  **Backup your existing configurations:**
    ```bash
    mkdir ~/dotfiles_backup
    mv ~/.config/niri ~/dotfiles_backup/
    mv ~/.config/waybar ~/dotfiles_backup/
    # ... repeat for other tools
    ```

3.  **Symlink or Copy configurations:**
    ```bash
    cp -r niri ~/.config/
    cp -r waybar ~/.config/
    cp -r alacritty ~/.config/
    cp -r fish ~/.config/
    cp -r nvim ~/.config/
    # ... repeat for other tools
    ```

    *Note: Ensure you have the required fonts (FiraCode Nerd Font) installed.*

## Keybindings

Keybindings are defined in `niri/config.kdl`. Some common defaults include:

*   `Super + Enter`: Open Terminal
*   `Super + D`: Open Launcher (Fuzzel)
*   `Super + Q`: Close Window
*   `Super + Shift + E`: Power Menu (Wlogout)

## Credits

*   **Wallpaper:** [Link to wallpaper if known]
*   **NvChad:** [NvChad](https://nvchad.com/)
*   **Niri:** [YaLTeR/niri](https://github.com/YaLTeR/niri)
