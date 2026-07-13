if status is-interactive
    set -U fish_greeting

    # Locale
    set -gx LANG en_US.UTF-8
    set -gx LC_ALL en_US.UTF-8

    # Defaults
    set -gx TERMINAL alacritty
    set -gx EDITOR nvim
    set -gx VISUAL $EDITOR
    set -gx PAGER less

    # Paths
    fish_add_path -g $HOME/.local/bin $HOME/bin

    # Starship
    set -gx STARSHIP_CONFIG $HOME/.config/starship/starship.toml
    type -q starship; and starship init fish | source

    # zoxide
    type -q zoxide; and zoxide init fish | source

    # Abbreviations
    abbr -a -- c clear
    abbr -a -- .. 'cd ..'
    abbr -a -- ... 'cd ../..'
    abbr -a -- g git
    abbr -a -- ga 'git add'
    abbr -a -- gc 'git commit'
    abbr -a -- gp 'git push'
    abbr -a -- gs 'git status'
    abbr -a -- gl 'git log --oneline --decorate --graph'

    # Utilities
    function mkcd --description "mkdir and cd"
        test (count $argv) -ge 1; or begin
            echo "Usage: mkcd <dir>"
            return 1
        end
        mkdir -p -- $argv[1]; and cd -- $argv[1]
    end

    function extract --description "Extract archives"
        test (count $argv) -ge 1; or begin
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
                case '*.tar'
                    tar xf $f
                case '*.zip'
                    unzip $f
                case '*.7z'
                    7z x $f
                case '*.rar'
                    type -q unrar; and unrar x $f; or echo "unrar not installed"
                case '*.gz'
                    gunzip $f
                case '*'
                    echo "Don't know how to extract: $f"
            end
        end
    end

    function serve --description "Serve current dir over HTTP"
        set -l port 8000
        test (count $argv) -ge 1; and set port $argv[1]
        python -m http.server $port
    end

    function memtop --description "Top memory consumers"
        ps aux --sort=-%mem | head -11
    end

    function diskuse --description "Largest dirs (default: ~)"
        set -l target ~
        test (count $argv) -ge 1; and set target $argv[1]
        du -sh $target/* 2>/dev/null | sort -hr | head -10
    end

    # Startup display (once per session)
    if not set -q __fetch_ran
        set -g __fetch_ran 1

        if not set -q TMUX
            if set -q ALACRITTY_WINDOW_ID; or string match -qi '*alacritty*' $TERM
                type -q fastfetch; and fastfetch
            else if string match -qi 'foot*' $TERM
                type -q neofetch; and neofetch
            end
        end
    end
end
set -gx TERM xterm-256color
set -e GTK_THEME
