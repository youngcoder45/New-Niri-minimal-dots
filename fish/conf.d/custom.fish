#!/usr/bin/env fish

# This file is sourced by fish on startup. It has been made conservative
# so it doesn't override settings in your `config.fish`.

# ensure that the XDG variables are set if not already defined
if not set -q XDG_CONFIG_HOME
    set -gx XDG_CONFIG_HOME "$HOME/.config"
end

if not set -q XDG_DATA_HOME
    set -gx XDG_DATA_HOME "$HOME/.local/share"
end

if not set -q XDG_DATA_DIRS
    set -gx XDG_DATA_DIRS "$XDG_DATA_HOME:/usr/local/share:/usr/share"
end

if not set -q XDG_STATE_HOME
    set -gx XDG_STATE_HOME "$HOME/.local/state"
end

if not set -q XDG_CACHE_HOME
    set -gx XDG_CACHE_HOME "$HOME/.cache"
end

if not set -q XDG_DESKTOP_DIR
    set -gx XDG_DESKTOP_DIR "$HOME/Desktop"
end

if not set -q XDG_DOWNLOAD_DIR
    set -gx XDG_DOWNLOAD_DIR "$HOME/Downloads"
end

if not set -q XDG_TEMPLATES_DIR
    set -gx XDG_TEMPLATES_DIR "$HOME/Templates"
end

if not set -q XDG_PUBLICSHARE_DIR
    set -gx XDG_PUBLICSHARE_DIR "$HOME/Public"
end

if not set -q XDG_DOCUMENTS_DIR
    set -gx XDG_DOCUMENTS_DIR "$HOME/Documents"
end

if not set -q XDG_MUSIC_DIR
    set -gx XDG_MUSIC_DIR "$HOME/Music"
end

if not set -q XDG_PICTURES_DIR
    set -gx XDG_PICTURES_DIR "$HOME/Pictures"
end

if not set -q XDG_VIDEOS_DIR
    set -gx XDG_VIDEOS_DIR "$HOME/Videos"
end

if not set -q LESSHISTFILE
    set -gx LESSHISTFILE "/tmp/less-hist"
end

if not set -q PARALLEL_HOME
    set -gx PARALLEL_HOME "$XDG_CONFIG_HOME/parallel"
end

if not set -q HYPRLAND_CONFIG
    set -gx HYPRLAND_CONFIG "$XDG_DATA_HOME/hypr/hyprland.conf"
end

# Prepend $HOME/.local/bin to PATH only if not already present
if not contains $HOME/.local/bin $PATH
    set -gx PATH $HOME/.local/bin $PATH
end


if type -q starship
    starship init fish | source
    if not set -q STARSHIP_CACHE
        set -gx STARSHIP_CACHE $XDG_CACHE_HOME/starship
    end
    if not set -q STARSHIP_CONFIG
        set -gx STARSHIP_CONFIG $XDG_CONFIG_HOME/prompt/starship.toml
    end
end


if type -q duf
    function df -d "Run duf with last argument if valid, else run duf"
        if set -q argv[-1] && test -e $argv[-1]
            duf $argv[-1]
        else
            duf
        end
    end
end

# NOTE: binds Alt+n to inserting the nth command from history in edit buffer
# e.g. Alt+4 is same as pressing Up arrow key 4 times
# really helpful if you get used to it
if functions -q bind_M_n_history
    bind_M_n_history
end


# example integration with bat : <cltr+f>
# bind -M insert \ce '$EDITOR $(fzf --preview="bat --color=always --plain {}")'

set fish_pager_color_prefix cyan
set fish_color_autosuggestion brblack

# List Directory
alias c='clear'
alias l='eza -lh --icons=auto'
alias ls='eza -1 --icons=auto'
alias ll='eza -lha --icons=auto --sort=name --group-directories-first'
alias ld='eza -lhD --icons=auto'
alias lt='eza --icons=auto --tree'
alias in='hyde-shell pm remove'
alias un='hyde-shell pm remove'
alias up='hyde-shell pm upgrade'
alias pl='hyde-shell pm search installed'
alias pa='hyde-shell pm search all'
alias g='git'

# Directory navigation shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

alias vc='code'

abbr mkdir 'mkdir -p'

# Do not override user greeting if already set in config.fish
if not set -q fish_greeting
    set -g fish_greeting
end
