fish_vi_key_bindings

if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias code "vscodium --enable-features=UseOzonePlatform --ozone-platform=wayland"

alias mvi='mpv --config-dir=$HOME/.config/mvi'

# fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow

# Status Chars
set __fish_git_prompt_char_dirtystate '⚡'
set __fish_git_prompt_char_stagedstate '→'
set __fish_git_prompt_char_stashstate '↩'
set __fish_git_prompt_char_upstream_ahead '↑'
set __fish_git_prompt_char_upstream_behind '↓'

function fish_prompt
    set last_status $status
    set_color $fish_color_cwd
    printf '%s' (prompt_pwd)
    set_color normal
    printf '%s ' (__fish_git_prompt)
    set_color normal
end

export GOPATH=$HOME/go
export GOROOT=/usr/lib/go
export PATH="$PATH:$GOPATH"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:$GOROOT/bin"
export PATH="$PATH:$GOPATH/bin"
