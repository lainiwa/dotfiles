

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

# Ignoring output
alias -g NE='2> /dev/null'
alias -g NUL='&> /dev/null'

alias gl='git log --oneline --graph --decorate --all'

alias r='ranger'

alias mkdir='mkdir -pv'
alias U='unbuffer '

alias -g H='| head'
alias -g T='| tail'

alias -g G='| grep -i'
alias -g GV='| grep -iv'  # negative grep
alias -g S='| sed'

alias -g L='| less'
alias -g LR='| less -R'  # less with colors support

alias -g C='| column -t'

alias -g TOD='*(.m0)'  # today's files

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
mkcd() { [[ $# == 1 ]] && mkdir --parents -- "$1" && cd -P -- "$1" ; }
compdef _directories mkcd

new() { [[ $# == 1 ]] && mkdir --parents -- "${1:h}" && touch "$1" ; }
compdef _directories new

alias tmp='cd $(mktemp -d)'

# Alias for altering some symbol with newline
# Example: echo $PATH TRN :
__rt__() { tr -- "$2" "$1" ; }
alias -g TRN='| __rt__ "\n" '


# Remove colors
alias -g NOC='| sed -r "s/\x1B\[[0-9;]*[JKmsu]//g"'


# `npm-exec <binary name>` to run locally installed nodejs binary
alias npm-exec='PATH=$(npm bin):$PATH'
