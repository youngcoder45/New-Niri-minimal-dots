if status is-interactive
    # ── Environment Variables ──────────────────────────────────
    set -gx LC_ALL en_US.UTF-8
    set -gx LANG en_US.UTF-8
    set -gx PATH $PATH /opt/nvim/ $HOME/bin $HOME/.local/bin

    set -gx XCURSOR_THEME Bibata-Modern-Classic
    set -gx XCURSOR_SIZE 24

    set -U fish_greeting

    # ── Starship Prompt ────────────────────────────────────────
    set -gx STARSHIP_CONFIG $HOME/.config/prompt/starship.toml
    starship init fish | source

    # ── Catppuccin Mocha Colors ────────────────────────────────
    set fish_color_normal           cdd6f4
    set fish_color_command          74c7ec --bold
    set fish_color_keyword          cba6f7 --bold
    set fish_color_quote            a6e3a1
    set fish_color_redirection      fab387 --bold
    set fish_color_end              89b4fa --bold
    set fish_color_error            f38ba8 --bold
    set fish_color_param            f9e2af
    set fish_color_option           94e2d5
    set fish_color_comment          6c7086 --bold
    set fish_color_valid_path       --underline
    set fish_color_autosuggestion   6c7086
    set fish_color_user             f5c2e7
    set fish_color_host             89dceb
    set fish_color_cancel           f38ba8 --reverse
    set fish_color_search_match     --background=45475a
    set fish_color_selection        --background=585b70
    set fish_color_history_current  --bold
    set fish_color_operator         fab387 --bold
    set fish_color_escape           89dceb --bold
    set fish_color_cwd              89b4fa
    set fish_color_cwd_root         f38ba8
    set fish_color_match            --background=45475a

    set fish_pager_color_prefix             74c7ec --bold
    set fish_pager_color_completion         cdd6f4
    set fish_pager_color_description        6c7086
    set fish_pager_color_progress           1e1e2e --background=74c7ec
    set fish_pager_color_secondary_prefix   45475a
    set fish_pager_color_selected_prefix    1e1e2e --background=cba6f7
    set fish_pager_color_selected_completion cdd6f4 --background=45475a
    set fish_pager_color_selected_description f9e2af --background=45475a

    # ── History ────────────────────────────────────────────────
    set -g fish_history_size 10000
    set -U fish_history_max_entries 10000

    # ── Key Bindings ───────────────────────────────────────────
    function fish_user_key_bindings
        bind \cu backward-kill-line
        bind \e\[1\;5C forward-word
        bind \e\[1\;5D backward-word
        bind \e\[H beginning-of-line
        bind \e\[F end-of-line
        bind \e\[5~ history-search-backward
        bind \e\[6~ history-search-forward
        bind \e\[3~ delete-char
        bind \cf accept-autosuggestion
        bind \e\r 'commandline -i \n'
    end

    # ── Aliases ────────────────────────────────────────────────
    alias imlazy='sudo pacman -Syu && yay -Syu'

    # Navigation
    alias ..='cd ..'
    alias ...='cd ../..'
    alias ....='cd ../../..'
    alias .....='cd ../../../..'
    alias dl='cd ~/Downloads'
    alias doc='cd ~/Documents'
    alias dt='cd ~/Desktop'

    # Git
    alias g='git'

    # Grep with color
    alias grep='grep --color=auto'
    alias diff='diff --color=auto'
    alias ip='ip --color=auto'

    # ── Functions ──────────────────────────────────────────────
    function reload
        source ~/.config/fish/config.fish
        echo "Fish configuration reloaded!"
    end

    function mkcd
        mkdir -p $argv[1] && cd $argv[1]
    end

    function cd
        builtin cd $argv
        and ls
    end

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

    function serve --description "Start HTTP server on port (default 8000)"
        set port 8000
        if test (count $argv) -ge 1
            set port $argv[1]
        end
        echo "[*] Serving on http://localhost:$port"
        python3 -m http.server $port
    end

    function gitlog --description "Pretty git log"
        git log --oneline --graph --decorate --all
    end

    function sysinfo --description "Show system info"
        echo "─────────────────────────────────────────────"
        uname -a
        echo "─────────────────────────────────────────────"
    end

    function killp --description "Kill process by name"
        if test (count $argv) -eq 0
            echo "Usage: killp <process_name>"
            return 1
        end
        pkill -f $argv[1]
        echo "[+] Killed processes matching: $argv[1]"
    end

    # ── Abbreviations ──────────────────────────────────────────
    abbr -a c clear
    abbr -a cls clear
    abbr -a .. cd ..
    abbr -a ... cd ../..
    abbr -a .... cd ../../..
    abbr -a update 'yay -Syu'
    abbr -a vim nvim
    abbr -a vi nvim
    abbr -a g git
    abbr -a ga 'git add'
    abbr -a gc 'git commit'
    abbr -a gp 'git push'
    abbr -a gs 'git status'
    abbr -a gl 'git log --oneline'

    # ── External Tools ─────────────────────────────────────────
    if not set -q EDITOR
        set -x EDITOR nvim
    end
    set -x VISUAL $EDITOR
    set -x PAGER less
    set -x LESS '-R --use-color -Dd+r -Du+b'

    if command -v zoxide >/dev/null
        zoxide init fish | source
    end

    if command -v thefuck >/dev/null
        thefuck --alias | source
    end

    # Show fastfetch at startup
    fastfetch
end
