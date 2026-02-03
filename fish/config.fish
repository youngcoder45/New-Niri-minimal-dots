if status is-interactive
    # ┌─────────────────────────────────────────────────────────────────┐
    # │  Fish Shell Configuration - ZSH Style Converted                 │
    # │  Professional setup with comprehensive features                 │
    # └─────────────────────────────────────────────────────────────────┘

    # ─────────────────────────────────────────────────────────────────
    # ENVIRONMENT VARIABLES - Core Setup
    # ─────────────────────────────────────────────────────────────────
    
    # Locale settings
    set -gx LC_ALL en_US.UTF-8
    set -gx LANG en_US.UTF-8
    
    # Path configurations
    set -gx PATH $PATH /opt/nvim/ $HOME/bin $HOME/.local/bin
    
    # Terminal configuration
    set -gx TERMINAL kitty
    
    # Cursor theme configuration
    set -gx XCURSOR_THEME Bibata-Modern-Classic
    set -gx XCURSOR_SIZE 24
    
    # Disable fish greeting
    set -U fish_greeting

    # ─────────────────────────────────────────────────────────────────
    # STARSHIP PROMPT - Modern & Aesthetic
    # ─────────────────────────────────────────────────────────────────
    
    # Use starship config from the prompt folder
    set -gx STARSHIP_CONFIG $HOME/.config/prompt/starship.toml

    # Initialize Starship prompt (uses STARSHIP_CONFIG)
    starship init fish | source

    # ─────────────────────────────────────────────────────────────────
    # COLORS & SYNTAX HIGHLIGHTING - ZSH Style Enhanced
    # ─────────────────────────────────────────────────────────────────
    
    # Enhanced Fish colors matching ZSH syntax highlighting
    set fish_color_normal           cdd6f4          # Default text
    set fish_color_command          74c7ec --bold   # Commands (cyan, bold)
    set fish_color_keyword          cba6f7 --bold   # Keywords (purple, bold)
    set fish_color_quote            a6e3a1          # Strings (green)
    set fish_color_redirection      fab387 --bold   # Redirections (orange, bold)
    set fish_color_end              89b4fa --bold   # Command terminators (blue, bold)
    set fish_color_error            f38ba8 --bold   # Errors (red, bold)
    set fish_color_param            f9e2af          # Parameters (yellow)
    set fish_color_option           94e2d5          # Options (teal)
    set fish_color_comment          6c7086 --bold   # Comments (overlay0, bold)
    set fish_color_valid_path       --underline     # Valid paths
    set fish_color_autosuggestion   6c7086          # Auto-suggestions (overlay0)
    set fish_color_user             f5c2e7          # Username (pink)
    set fish_color_host             89dceb          # Hostname (sky)
    set fish_color_cancel           f38ba8 --reverse # Cancel (red, reverse)
    set fish_color_search_match     --background=45475a # Search match
    set fish_color_selection        --background=585b70 # Selection
    set fish_color_history_current  --bold
    set fish_color_operator         fab387 --bold   # Operators (orange, bold)
    set fish_color_escape           89dceb --bold   # Escape sequences (sky, bold)
    set fish_color_cwd              89b4fa          # Current directory (blue)
    set fish_color_cwd_root         f38ba8          # Root directory (red)
    set fish_color_match            --background=45475a

    # Pager colors (autocomplete menu) - Enhanced
    set fish_pager_color_prefix             74c7ec --bold      # Prefix (cyan, bold)
    set fish_pager_color_completion         cdd6f4             # Completion text
    set fish_pager_color_description        6c7086             # Description text
    set fish_pager_color_progress           1e1e2e --background=74c7ec # Progress bar
    set fish_pager_color_secondary_prefix   45475a             # Secondary prefix
    set fish_pager_color_selected_prefix    1e1e2e --background=cba6f7 # Selected prefix
    set fish_pager_color_selected_completion cdd6f4 --background=45475a # Selected completion
    set fish_pager_color_selected_description f9e2af --background=45475a # Selected description

    # ─────────────────────────────────────────────────────────────────
    # HISTORY CONFIGURATION - Enhanced Memory
    # ─────────────────────────────────────────────────────────────────
    
    # History settings (Fish handles this differently than ZSH)
    set -g fish_history_size 10000
    set -U fish_history_max_entries 10000
    
    # ─────────────────────────────────────────────────────────────────
    # KEY BINDINGS - ZSH Style Navigation
    # ─────────────────────────────────────────────────────────────────
    
    # Emacs-style key bindings (default in Fish)
    function fish_user_key_bindings
        # Ctrl+U - backward kill line
        bind \cu backward-kill-line
        
        # Ctrl+Left/Right - word navigation
        bind \e\[1\;5C forward-word
        bind \e\[1\;5D backward-word
        
        # Home/End keys
        bind \e\[H beginning-of-line
        bind \e\[F end-of-line
        
        # Page Up/Down for history search
        bind \e\[5~ history-search-backward
        bind \e\[6~ history-search-forward
        
        # Delete key
        bind \e\[3~ delete-char
        
        # Accept autosuggestion with Ctrl+F
        bind \cf accept-autosuggestion
        
        # Alt+Enter for multiline editing
        bind \e\r 'commandline -i \n'
    end

    # ─────────────────────────────────────────────────────────────────
    # ALIASES - ZSH Style Comprehensive Set
    # ─────────────────────────────────────────────────────────────────
    
    # System update alias (Arch-style)
    alias imlazy='sudo pacman -Syu && yay -Sy && sudo update-grub'
    
    # Smart ls function with fallback
    function ls
        if command -v lsd >/dev/null
            lsd --color=auto $argv
        else
            command ls --color=auto $argv
        end
    end
    
    # Enhanced ls aliases with fallback
    function ll
        if command -v lsd >/dev/null
            lsd -l $argv
        else
            command ls -l --color=auto $argv
        end
    end
    
    function la
        if command -v lsd >/dev/null
            lsd -A $argv
        else
            command ls -A --color=auto $argv
        end
    end
    
    function lah
        if command -v lsd >/dev/null
            lsd -lah $argv
        else
            command ls -lah --color=auto $argv
        end
    end
    
    function l
        if command -v lsd >/dev/null
            lsd -CF $argv
        else
            command ls -CF --color=auto $argv
        end
    end
    
    # Navigation shortcuts
    alias ..='cd ..'
    alias ...='cd ../..'
    alias ....='cd ../../..'
    alias .....='cd ../../../..'
    
    # Directory shortcuts
    alias dl='cd ~/Downloads'
    alias doc='cd ~/Documents'
    alias dt='cd ~/Desktop'
    
    # Git shortcut
    alias g='git'
    
    # Grep with color
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias diff='diff --color=auto'
    alias ip='ip --color=auto'
    
    # Kitty specific aliases
    alias icat='kitty +kitten icat'
    
    # System backup
    alias backup='sudo /usr/local/bin/system-backup.sh'
    
    # Package installer
    alias installer='~/Scripts/packages.sh'

    # ─────────────────────────────────────────────────────────────────
    # FUNCTIONS - Enhanced Utilities
    # ─────────────────────────────────────────────────────────────────
    
    # Reload fish configuration
    function reload
        source ~/.config/fish/config.fish
        echo "Fish configuration reloaded!"
    end
    
    # Create directory and change to it
    function mkcd
        mkdir -p $argv[1] && cd $argv[1]
    end
    
    # Enhanced cd with automatic ls
    function cd
        builtin cd $argv
        and ls
    end
    
    # Extract function for various archive formats
    function extract
        if test -f $argv[1]
            switch $argv[1]
                case '*.tar.bz2'
                    tar xjf $argv[1]
                case '*.tar.gz'
                    tar xzf $argv[1]
                case '*.bz2'
                    bunzip2 $argv[1]
                case '*.rar'
                    unrar x $argv[1]
                case '*.gz'
                    gunzip $argv[1]
                case '*.tar'
                    tar xf $argv[1]
                case '*.tbz2'
                    tar xjf $argv[1]
                case '*.tgz'
                    tar xzf $argv[1]
                case '*.zip'
                    unzip $argv[1]
                case '*.Z'
                    uncompress $argv[1]
                case '*.7z'
                    7z x $argv[1]
                case '*'
                    echo "'$argv[1]' cannot be extracted via extract()"
            end
        else
            echo "'$argv[1]' is not a valid file"
        end
    end
    
    # Abbreviations (faster than aliases; expand on space)
    abbr -e -- c 2>/dev/null; abbr -a c clear
    abbr -e -- cls 2>/dev/null; abbr -a cls clear
    abbr -e -- ..  cd ..
    abbr -e -- ... cd ../..
    abbr -e -- .... cd ../../..
    abbr -e -- update 'paru -Syu || yay -Syu || sudo pacman -Syu'
    abbr -e -- ls 'ls --color=auto -A'
    abbr -e -- ll 'ls -lh --color=auto -A'
    abbr -e -- la 'ls -lah --color=auto -A'
    abbr -e -- grep 'grep --color=auto'
    abbr -e -- diff 'diff --color=auto'
    abbr -e -- cat 'bat --color=auto' 2>/dev/null || abbr -a cat cat
    abbr -e -- vim nvim
    abbr -e -- vi nvim
    abbr -e -- sudo 'sudo '
    abbr -e -- g git
    abbr -e -- ga 'git add'
    abbr -e -- gc 'git commit'
    abbr -e -- gp 'git push'
    abbr -e -- gs 'git status'
    abbr -e -- gl 'git log --oneline'

    # ─────────────────────────────────────────────────────────────────
    # SAFE PATH ADJUSTMENTS
    # ─────────────────────────────────────────────────────────────────
    
    if not contains /usr/local/bin $fish_user_paths
        set -U fish_user_paths /usr/local/bin $fish_user_paths
    end

    # ─────────────────────────────────────────────────────────────────
    # ENVIRONMENT VARIABLES
    # ─────────────────────────────────────────────────────────────────
    
    if not set -q EDITOR
        set -x EDITOR nvim
    else
        set -x EDITOR $EDITOR
    end
    set -x VISUAL $EDITOR
    
    if not set -q PAGER
        set -x PAGER less
    end
    
    set -x LESS '-R --use-color -Dd+r -Du+b'
    umask 022

    # Fix locale: set LC_TELEPHONE to available en_GB locale
    set -x LC_TELEPHONE en_GB.UTF-8

    # ─────────────────────────────────────────────────────────────────
    # UTILITY FUNCTIONS
    # ─────────────────────────────────────────────────────────────────

    # Directory navigation - show all files including hidden
    function cd
        builtin cd $argv
        and ls -A
    end

    # Create directory and cd into it
    function mkcd
        if test (count $argv) -eq 0
            echo "Usage: mkcd <dir>"
            return 1
        end
        mkdir -p $argv[1]; and cd $argv[1]
    end

    # Extract many archive formats
    function extract --description "Extract archives"
        if test (count $argv) -eq 0
            echo "Usage: extract <archive> [archive2 ...]"
            return 1
        end
        for f in $argv
            switch $f
                case '*.tar.gz' '*.tgz'
                    tar xzf $f
                case '*.tar.bz2' '*.tbz2'
                    tar xjf $f
                case '*.tar.xz' '*.txz'
                    tar xJf $f
                case '*.zip'
                    unzip $f
                case '*.rar'
                    if type -q unrar
                        unrar x $f
                    else
                        echo "[!] unrar not installed"
                    end
                case '*'
                    echo "[x] Don't know how to extract: $f"
            end
        end
    end

    # Simple static file server
    function serve --description "Start HTTP server on port (default 8000)"
        set port 8000
        if test (count $argv) -ge 1
            set port $argv[1]
        end
        echo "[*] Serving on http://localhost:$port"
        python -m http.server $port
    end

    # Git shortcuts
    function gitlog --description "Pretty git log"
        git log --oneline --graph --decorate --all
    end

    # System info
    function sysinfo --description "Show system info"
        echo "─────────────────────────────────────────────"
        uname -a
        echo "─────────────────────────────────────────────"
    end

    # Kill process by name
    function killp --description "Kill process by name"
        if test (count $argv) -eq 0
            echo "Usage: killp <process_name>"
            return 1
        end
        pkill -f $argv[1]
        echo "[+] Killed processes matching: $argv[1]"
    end

    # Memory monitoring - top 10 memory-hungry processes
    function memtop --description "Show top memory consumers"
        echo "─────────────────────────────────────────────"
        echo "Top 10 Memory Consumers:"
        echo "─────────────────────────────────────────────"
        ps aux --sort=-%mem | head -11
        echo ""
        free -h | grep Mem
    end

    # Show disk usage by largest directories
    function diskuse --description "Show largest directories"
        echo "Largest directories in home:"
        du -sh ~/* 2>/dev/null | sort -hr | head -10
    end

    # ─────────────────────────────────────────────────────────────────
    # STARTUP DISPLAY - Enhanced Terminal Experience  
    # ─────────────────────────────────────────────────────────────────
    
    # Show fastfetch in Kitty terminals (clean startup)
    if test "$TERM" = "xterm-kitty"
        fastfetch --file $HOME/.config/fastfetch/arch.txt
    end

    # ─────────────────────────────────────────────────────────────────
    # EXTERNAL TOOLS INTEGRATION - ZSH Style Features
    # ─────────────────────────────────────────────────────────────────
    
    # NVM (Node Version Manager) integration
    if test -d ~/.config/nvm
        set -gx NVM_DIR ~/.config/nvm
        # Fish NVM integration (install with fisher if needed)
    end
    
    # Zoxide integration (better cd replacement)
    if command -v zoxide >/dev/null
        zoxide init fish | source
    end
    
    # TheFuck integration
    if command -v thefuck >/dev/null
        thefuck --alias | source
    end
    
    # Python environment tools
    if test -f ~/Scripts/py_env_tools.sh
        echo "Python env tools available at ~/Scripts/py_env_tools.sh"
    end

    # ─────────────────────────────────────────────────────────────────
    # COMPLETION ENHANCEMENTS - Professional Grade
    # ─────────────────────────────────────────────────────────────────
    
    # Enable case-insensitive completions
    set -g fish_complete_case_insensitive 1
    
    # Enhanced path completion
    set -g fish_complete_path_ambiguous_dirs false
    
    # Git completion enhancements
    set -g __fish_git_prompt_show_informative_status 1
    set -g __fish_git_prompt_showdirtystate 1
    set -g __fish_git_prompt_showuntrackedfiles 1
    set -g __fish_git_prompt_showupstream auto

    # Run fastfetch at startup
    fastfetch --file $HOME/.config/fastfetch/arch.txt

end

# ─────────────────────────────────────────────────────────────────
# GLOBAL ALIASES & EXPORTS - System Wide Configuration
# ─────────────────────────────────────────────────────────────────
function ls
    command ls -a --color=auto $argv
end


# Export locale settings globally
set -gx LC_ALL en_US.UTF-8
# =============================================================================
#
# Utility functions for zoxide.
#

# pwd based on the value of _ZO_RESOLVE_SYMLINKS.
function __zoxide_pwd
    builtin pwd -L
end

# A copy of fish's internal cd function. This makes it possible to use
# `alias cd=z` without causing an infinite loop.
if ! builtin functions --query __zoxide_cd_internal
    string replace --regex -- '^function cd\s' 'function __zoxide_cd_internal ' <$__fish_data_dir/functions/cd.fish | source
end

# cd + custom logic based on the value of _ZO_ECHO.
function __zoxide_cd
    if set -q __zoxide_loop
        builtin echo "zoxide: infinite loop detected"
        builtin echo "Avoid aliasing `cd` to `z` directly, use `zoxide init --cmd=cd fish` instead"
        return 1
    end
    __zoxide_loop=1 __zoxide_cd_internal $argv
end

# =============================================================================
#
# Hook configuration for zoxide.
#

# Initialize hook to add new entries to the database.
function __zoxide_hook --on-variable PWD
    test -z "$fish_private_mode"
    and command zoxide add -- (__zoxide_pwd)
end

# =============================================================================
#
# When using zoxide with --no-cmd, alias these internal functions as desired.
#

# Jump to a directory using only keywords.
function __zoxide_z
    set -l argc (builtin count $argv)
    if test $argc -eq 0
        __zoxide_cd $HOME
    else if test "$argv" = -
        __zoxide_cd -
    else if test $argc -eq 1 -a -d $argv[1]
        __zoxide_cd $argv[1]
    else if test $argc -eq 2 -a $argv[1] = --
        __zoxide_cd -- $argv[2]
    else
        set -l result (command zoxide query --exclude (__zoxide_pwd) -- $argv)
        and __zoxide_cd $result
    end
end

# Completions.
function __zoxide_z_complete
    set -l tokens (builtin commandline --current-process --tokenize)
    set -l curr_tokens (builtin commandline --cut-at-cursor --current-process --tokenize)

    if test (builtin count $tokens) -le 2 -a (builtin count $curr_tokens) -eq 1
        # If there are < 2 arguments, use `cd` completions.
        complete --do-complete "'' "(builtin commandline --cut-at-cursor --current-token) | string match --regex -- '.*/$'
    else if test (builtin count $tokens) -eq (builtin count $curr_tokens)
        # If the last argument is empty, use interactive selection.
        set -l query $tokens[2..-1]
        set -l result (command zoxide query --exclude (__zoxide_pwd) --interactive -- $query)
        and __zoxide_cd $result
        and builtin commandline --function cancel-commandline repaint
    end
end
complete --command __zoxide_z --no-files --arguments '(__zoxide_z_complete)'

# Jump to a directory using interactive search.
function __zoxide_zi
    set -l result (command zoxide query --interactive -- $argv)
    and __zoxide_cd $result
end

# =============================================================================
#
# Commands for zoxide. Disable these using --no-cmd.
#

abbr --erase z &>/dev/null
alias z=__zoxide_z

abbr --erase zi &>/dev/null
alias zi=__zoxide_zi

# =============================================================================
#
# To initialize zoxide, add this to your configuration (usually
# ~/.config/fish/config.fish):
#
#   zoxide init fish | source
