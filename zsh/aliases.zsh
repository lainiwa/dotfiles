
if [[ "$(uname -s)" == "FreeBSD" ]]; then
    alias ls='ls -h -G'
else
    alias ls='ls -h --color=auto'
fi
alias ll='ls -l'
alias la='ls -A'
alias lal='ls -Al'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias mkdir='mkdir -pv'
alias tree='tree -C'
alias U='unbuffer '

alias -g H="| head"
alias -g T="| tail"
alias -g G="| grep"
alias -g L="| less"
alias -g LR="| less -R"
alias -g C='| column -t'
alias -g NE="2> /dev/null"
alias -g NUL="> /dev/null 2>&1"

# Set grc alias for available commands.
for cmd in $(cat /etc/grc.conf |grep '^# ' | cut -f 2 -d " ") ; do
    if (( $+commands[$cmd] )) &&  [ "$cmd" != "ls" ]; then
      alias $cmd="grc --colour=auto $cmd"
    fi
done
# unset cmds cmd  <-- written in grc.zsh (?)

mkcd() { mkdir -- "$1" && cd -P -- "$1" ; }

# example: echo $PATH TRN :
__rt__() { tr "$2" "$1" ; }
alias -g TRN='| __rt__ "\n" '
unset -f __rt__

# remove colors
alias -g NOC='| sed -r "s/\x1B\[[0-9;]*[JKmsu]//g"'