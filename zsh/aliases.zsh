
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

for filepath in {~/.grc,/usr/share/grc}/conf.* ; do
    filename="$(basename $filepath)"
    cmd=${filename#*.}
    if (( $+commands[$cmd] )) &&  [ "$cmd" != "ls" ]; then
      alias $cmd="grc --colour=auto $cmd"
    fi
done

mkcd() { mkdir -- "$1" && cd -P -- "$1" ; }

# example: echo $PATH TRN :
__rt__() { tr "$2" "$1" ; }
alias -g TRN='| __rt__ "\n" '
