#!/usr/bin/env fish

# XDG Base Directory variables
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

# PATH
if not contains $HOME/.local/bin $PATH
    set -gx PATH $HOME/.local/bin $PATH
end

# ── eza aliases ────────────────────────────────────────────────
alias c='clear'
alias l='eza -lh --icons=auto'
alias ls='eza -1 --icons=auto'
alias ll='eza -lha --icons=auto --sort=name --group-directories-first'
alias ld='eza -lhD --icons=auto'
alias lt='eza --icons=auto --tree'

# ── Directory navigation ───────────────────────────────────────
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# ── Package management ─────────────────────────────────────────
alias up='yay -Syu'
alias un='yay -Rns'
alias pl='yay -Qs'
alias pa='yay -Ss'

# ── Editor ─────────────────────────────────────────────────────
alias vc='code'

abbr mkdir 'mkdir -p'

# Disable fish greeting if not already set
if not set -q fish_greeting
    set -g fish_greeting
end
