
if [[ "$(uname -s)" == "FreeBSD" ]]; then
    alias ls='ls -h -G'
else
    alias ls='ls -h --color=auto'
fi
alias ll='ls -l'
alias la='ls -A'
alias lal='ls -Al'
if hash grc 2>/dev/null 1>&2; then
    for cmd in configure diff make gcc ld netstat ping ping6 traceroute traceroute6 head tail dig mount ps mtr df ifconfig; do
        alias $cmd="__grc_color__ $cmd"
    done
fi
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
alias -g C='| column -t'
alias -g NE="2> /dev/null"
alias -g NUL="> /dev/null 2>&1"

mkcd() { mkdir -- "$1" && cd -P -- "$1" ; }

# example: echo $PATH TRN :
__rt__() { tr "$2" "$1" ; }
alias -g TRN='| __rt__ "\n" '

__grc_color__() {
    if hash "$1" 2>/dev/null 1>&2 ; then
        grc --colour=auto $@
    else
        $@
    fi
}
