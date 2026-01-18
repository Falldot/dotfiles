if not status --is-interactive
    fnm env --use-on-cd | source
end

function fnm_use --description 'Change node version'
    set -l _fnm_candidate_files .nvmrc .node-version
    test "$FNM_RESOLVE_ENGINES" = true; and set -a _fnm_candidate_files package.json

    set -l search_dir $PWD
    set -l found_file ""

    if test "$FNM_VERSION_FILE_STRATEGY" = "recursive"
        while test -n "$search_dir"
            for file in $_fnm_candidate_files
                if test -f "$search_dir/$file"
                    set found_file "$search_dir/$file"
                    break
                end
            end

            if test -n "$found_file"
                break
            end

            if test "$search_dir" = "/"
                break
            end

            set search_dir (path dirname "$search_dir")
        end
    else
        for file in $_fnm_candidate_files
            if test -f "$search_dir/$file"
                set found_file "$search_dir/$file"
                break
            end
        end
    end

    if test -n "$found_file"
        set -l mod_time (path mtime "$found_file")

        if not set -q _fnm_active_state
            or test "$_fnm_active_state[1]" != "$found_file"
            or test "$mod_time" -gt "$_fnm_active_state[2]"
            
            command fnm use --silent-if-unchanged
            
            # Cache state: [1]=Path [2]=Mtime
            set -g _fnm_active_state "$found_file" "$mod_time"
        end
    else if set -q _fnm_active_state
        command fnm use --silent-if-unchanged system
        set -e _fnm_active_state
    end
end

function _fnm_autoload_on_cd --on-variable PWD
    status --is-command-substitution; and return
    fnm_use
end

function _fnm_autoload_on_prompt --on-event fish_prompt
    functions -e _fnm_autoload_on_prompt
    fnm_use
end

