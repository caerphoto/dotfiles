fish_config theme choose "Rosé Pine Moon"
abbr --add gs git status
abbr --add gd "git diff --word-diff=color"
abbr --add gc git commit
abbr --add gblh "gbl | head -n5"
abbr --add gt "git log --date=format:'%a %e %b, %Y' --pretty=format:'%C(yellow)%h%C(reset) %s %C(cyan)%cd%C(reset) %C(blue)%an%C(reset) %C(green)%d%C(reset)' --graph"
abbr --add gh "git log --follow --shortstat -p --"
abbr --add gl "git log"
abbr --add gp "git push"
abbr --add bi bundle install
abbr --add be bundle exec
abbr --add nv nvim
abbr --add et "et -s size -I"
abbr --add lsd "exa -1d --all */"
abbr --add tinybin "cargo +nightly build -Z build-std=std,panic_abort -Z build-std-features=panic_immediate_abort --target x86_64-apple-darwin --release"
abbr --add y yazi

function ls
    command exa --all $argv
end

function ll
    command exa -lahg --git $argv
end

# Git branch list
function gbl
    set branches $(git for-each-ref --format='%(refname:short)' refs/heads/)
    for branch in $branches
        echo -e $(git show --format="%ci %cr" $branch | head -n 1) \\t$branch
    end | sort -r
end

function ssh
    set -lx TERM xterm-256color
    command ssh $argv
end

function wget
    curl --remote-name --fail --location $argv
end

function bssh
    set ssh_host ''
    switch $argv
        case mmdev
            set ssh_host 'ukbldapdbw03.uk.experian.local'
        case mmuat
            set ssh_host 'ukbluapdbw20.uk.experian.local'
        case mmstaging
            set ssh_host 'ukbluapdbw20.uk.experian.local'
        case mmprod
            set ssh_host 'ukfhpapdbw53.uk.experian.local'
        case smedev
            set ssh_host 'ukbldapdbw04.uk.experian.local'
        case smeuat
            set ssh_host 'ukbluapdbw19.uk.experian.local'
        case smestaging
            set ssh_host 'ukbluapdbw19.uk.experian.local'
        case smeprod
            set ssh_host 'ukfhpapdbw18.uk.experian.local'

        case dev
            set ssh_host 'ukbldapdbw04.uk.experian.local'
        case uat
            set ssh_host 'ukbluapdbw19.uk.experian.local'
        case staging
            set ssh_host 'ukbluapdbw19.uk.experian.local'
        case prod
            set ssh_host 'ukfhpapdbw18.uk.experian.local'
    end

    if test -z $ssh_host
        echo -e "Usage:\n  bssh <server>"
        echo -e "<server> must be one of:\n  mmdev\n  mmstaging\n  mmprod\n  smedev\n  smestaging\n  smeprod"
        return 1
    end

    # TERM needs to be set because Experian servers don't know about Alacritty
    TERM=xterm-256color ssh -i ~/.ssh/id_rsa deployer@$ssh_host
end

fish_vi_key_bindings insert

set -g fish_greeting

set -g __fish_git_prompt_showupstream auto
set -g __fish_git_prompt_showdirtystate 1
set -g __fish_git_prompt_showuntrackedfiles 1
set -g __fish_git_prompt_showstashstate 1
set -g __fish_git_prompt_showcolorhints 1
set -g __fish_git_prompt_use_informative_chars 1

set -g __fish_git_prompt_char_stateseparator " "
set -g __fish_git_prompt_char_upstream_prefix " "

set -g __fish_git_prompt_char_stashstate "☰"
set -g __fish_git_prompt_char_dirtystate "*"
set -g __fish_git_prompt_char_invalidstate "#"
set -g __fish_git_prompt_char_stagedstate "+"
set -g __fish_git_prompt_color_invalidstate yellow
set -g fish_key_bindings fish_vi_key_bindings

# Emulates vim's cursor shape behavior
# Set the normal and visual mode cursors to a block
set fish_cursor_default block
# Set the insert mode cursor to a line
set fish_cursor_insert line
# Set the replace mode cursors to an underscore
set fish_cursor_replace_one underscore
set fish_cursor_replace underscore
# Set the external cursor to a line. The external cursor appears when a command is started.
# The cursor shape takes the value of fish_cursor_default when fish_cursor_external is not specified.
set fish_cursor_external line
# The following variable can be used to configure cursor shape in
# visual mode, but due to fish_cursor_default, is redundant here
set fish_cursor_visual block

set --universal nvm_default_version v22.5.0

fish_add_path $HOME/.cargo/bin $HOME/bin

eval "$(rbenv init -)"
export PYENV_ROOT="$HOME/.pyenv"
export EDITOR=hx
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
