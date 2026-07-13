# Auto-run `ls -a` after successful directory changes via `cd` or `z` (zoxide / z)
# Loaded automatically by fish from ~/.config/fish/conf.d/

if not status is-interactive
    exit
end

# Avoid double-loading in the same session.
if set -q __auto_ls_after_dir_change_loaded
    exit
end
set -g __auto_ls_after_dir_change_loaded 1

function __auto_ls_after_dir_change_run_ls --description 'Run ls -a after directory change'
    command ls -a
end

# Wrap builtin cd.
# Keep a copy of the original function (if any) before overriding.
if not functions -q __auto_ls_after_dir_change_cd_orig
    functions -c cd __auto_ls_after_dir_change_cd_orig 2>/dev/null
end

function cd --wraps=cd --description 'cd, then ls -a'
    builtin cd $argv
    set -l cd_status $status
    if test $cd_status -eq 0
        __auto_ls_after_dir_change_run_ls
    end
    return $cd_status
end

# Wrap z / zi once they exist (e.g., defined by zoxide init in config.fish).
function __auto_ls_after_dir_change_wrap_z --on-event fish_prompt
    if set -q __auto_ls_after_dir_change_z_wrapped
        functions -e __auto_ls_after_dir_change_wrap_z
        return
    end

    if type -q z
        if functions -q z
            functions -c z __auto_ls_after_dir_change_z_orig
            function z --wraps=z --description 'z, then ls -a'
                __auto_ls_after_dir_change_z_orig $argv
                set -l z_status $status
                if test $z_status -eq 0
                    __auto_ls_after_dir_change_run_ls
                end
                return $z_status
            end
        else
            function z --wraps=z --description 'z, then ls -a'
                command z $argv
                set -l z_status $status
                if test $z_status -eq 0
                    __auto_ls_after_dir_change_run_ls
                end
                return $z_status
            end
        end
        set -g __auto_ls_after_dir_change_z_wrapped 1
    end

    if type -q zi
        if functions -q zi
            functions -c zi __auto_ls_after_dir_change_zi_orig
            function zi --wraps=zi --description 'zi, then ls -a'
                __auto_ls_after_dir_change_zi_orig $argv
                set -l zi_status $status
                if test $zi_status -eq 0
                    __auto_ls_after_dir_change_run_ls
                end
                return $zi_status
            end
        else
            function zi --wraps=zi --description 'zi, then ls -a'
                command zi $argv
                set -l zi_status $status
                if test $zi_status -eq 0
                    __auto_ls_after_dir_change_run_ls
                end
                return $zi_status
            end
        end
        set -g __auto_ls_after_dir_change_z_wrapped 1
    end

    if set -q __auto_ls_after_dir_change_z_wrapped
        functions -e __auto_ls_after_dir_change_wrap_z
    end
end
