
# Mass file move, copy, and linking
autoload zmv
alias zmv='noglob zmv'
alias zcp='noglob zmv -C'
alias zln='noglob zmv -L'
alias zsy='noglob zmv -Ls'

# Substitute ls with exa
if (( ${+commands[exa]} )); then
    alias ls='exa --color=auto --header --git'
    alias ll='ls -l'
    alias la='ls -a'
    alias lal='ls -al'
    alias tree='exa --tree'
    alias lt='tree'

# Colorize and humanify `ls`
else
    if [[ ${OSTYPE} == *linux* ]]; then
        alias ls='ls -h --color=auto'
    else
        alias ls='ls -h -G'
    fi
    alias ll='ls -l'
    alias la='ls -A'
    alias lal='ls -Al'
    alias tree='tree -C'
    alias lt='tree'
fi

# Substitute cat with bat
if (( ${+commands[bat]} )); then
    alias cat=bat
fi

# Colorize `grep`s
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# More verbose commands
alias mkdir='mkdir -pv'
alias cp='cp -v'
alias mv='mv -v'
alias rm='rm -v'

# R is for Ranger
alias r='ranger'
# Tmux attach alias
alias t='tmux attach || tmux'
# Fix terminal; when fucked up with binary
alias fix='reset; stty sane; tput rs1; clear; echo -e "\033c"'
# Enter temporary directory
alias tmp='cd $(mktemp -d)'

# Systemd --user aliases
alias sysu='systemctl --user'
alias joru='journalctl --user'

# `npm-exec <binary name>` to run locally installed nodejs binary
alias npm-exec='PATH=$(npm bin):$PATH'

# gl - a more verbose git log
if (( ${+commands[git-foresta]} )); then
    gl() { git-foresta --style=10 "$@" | less -RSX; }
    compdef _git gl=git-log
else
    alias gl="git log --oneline --graph --decorate --all --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"
fi

# Imitate no redirection
alias U='unbuffer'


# Ignoring output
alias -g NE='2> /dev/null'
alias -g NUL='&> /dev/null'

# Head and shoulders
alias -g H='| head'
alias -g T='| tail'

# Per-line tools
alias -g G='| grep --ignore-case'
alias -g GV='| grep --ignore-case --invert-match'  # negative grep
alias -g S='| sed'

# Redirect to less
alias -g L='| less'
alias -g LR='| less --RAW-CONTROL-CHARS'  # colors support

# Split to columns
alias -g C='| column -t'
# Today's files
alias -g TOD='*(.m0)'

# Remove colors
alias -g NOC='| sed -r "s/\x1B\[[0-9;]*[JKmsu]//g"'

# Colorize certain word
__COL__() { grep --color -E "$1|$" ; }
alias -g COL='| __COL__'

# Alias for altering some symbol with newline
# Example: echo $PATH TRN :
__rt__() { tr -- "$2" "$1" ; }
alias -g TRN='| __rt__ "\n" '


# Set grc alias for available commands.
[[ -f /etc/grc.conf ]] && grc_conf='/etc/grc.conf'
[[ -f /usr/local/etc/grc.conf ]] && grc_conf='/usr/local/etc/grc.conf'
if [[ ! -z "${grc_conf}" ]]; then
    grep '^# ' "${grc_conf}" | cut -f 2 -d ' ' |
    while read -r cmd; do
        if (( $+commands[$cmd] )) &&  [[ "ls systemctl" != *"$cmd"* ]]; then
            eval "$cmd() { grc --colour=auto $cmd \"\$@\" }"
        fi
    done
fi


# Create directory and cd to it
mkcd() { [[ $# == 1 ]] && mkdir -p -- "$1" && cd -P -- "$1" ; }
compdef _directories mkcd
# Create new file with all base directories
new() { [[ $# == 1 ]] && mkdir -p -- "${1:h}" && touch "$1" ; }
compdef _directories new
# Create new file with all base directories and open it in editor
nev() { [[ $# == 1 ]] && new "$1" && ${EDITOR:-vim} "$1" ; }
compdef _directories nev
