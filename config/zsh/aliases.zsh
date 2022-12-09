
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
    alias lal='ls -alg'
    alias tree='exa --tree'
    alias lt='tree'

# Substitute ls with lsd
elif (( ${+commands[lsd]} )); then
    alias ls='lsd --icon=never'
    alias ll='ls -l'
    alias la='ls -A'
    alias lal='ls -Al'
    alias tree='lsd --tree'
    alias lt='tree'

# Colorize and humanify `ls`
else
    if [[ ${OSTYPE} == linux* ]]; then
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
(( ${+commands[bat]}    )) && alias cat=bat
# Shorter fd-find
(( ${+commands[fdfind]} )) && alias fd=fdfind
# Shorter netsurf
(( ${+commands[netsurf-gtk3]} )) && alias netsurf=netsurf-gtk3
# "Pronounceable" passwords are insecure
(( ${+commands[pwgen]}  )) && alias pwgen='pwgen --secure'
# Scale image to full window in sxiv (mode: fit)
(( ${+commands[sxiv]}   )) && alias sxiv='sxiv -sf'
# Drop "ng" if no old generation tool present
(( ${+commands[ntopng]}    && ! ${+commands[ntop]}   )) && alias ntop=ntopng
(( ${+commands[iptraf-ng]} && ! ${+commands[iptraf]} )) && alias iptraf=iptraf-ng
# Make Russian default target language for translate-shell
(( ${+commands[trans]}  )) && alias trans='LANG=ru_RU.UTF-8 trans'

# Colorize `grep`s
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
# alias diff='diff --color=auto'

# More verbose commands
alias mkdir='mkdir -pv'
# alias cp='cp -v'
# alias mv='mv -v'
# alias rm='rm -v'

# Shortcut for sending json data via curl
alias jcurl='curl --header "content-type: application/json"'

# R is for Ranger
alias r='ranger'
# Tmux attach alias
alias t='tmux attach || tmux'
# Fix terminal; when fucked up with binary
alias fix='reset; stty sane; tput rs1; clear; echo -e "\033c"'
# Enter temporary directory
alias tmp='cd $(mktemp -d)'

# Systemd --user aliases
alias sys='systemctl'
alias jor='journalctl'
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

# gj - git worktree jump
gj() {
    if [[ -z "${1}" ]]; then
        cd "$(git worktree list |fzf --height 40% --reverse |awk '{print $1}')"
    else
        cd "${1}"
    fi
}
_gj() {
    IFS=$'\n' compadd $(git worktree list |awk '{print $1}')
}
compdef _gj gj

# Imitate no redirection
if (( ${+commands[unbuffer]} )); then
    alias U='unbuffer'
fi


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
alias -g LR='| less --raw-control-chars'  # colors support
alias -g LS='| less --chop-long-lines'    # don't wrap long lines

# Split to columns
alias -g COL='| column -t'
# Today's files
alias -g TOD='*(.m0)'
# Remove colors
alias -g NOC='| sed -r "s/\x1B\[[0-9;]*[JKmsu]//g"'

if (( ${+commands[xclip]} )); then
    alias -g C='| xclip -in -selection primary -filter | xclip -in -selection clipboard'
elif (( ${+commands[pbcopy]} && ${+commands[perl]} )); then
    alias -g C='|perl -pe "chomp if eof" |pbcopy -pboard general'
fi

# Colorize certain word
alias -g COL='| (){ grep --color -E "$1|$";}'

# Alias for altering some symbol with newline
# Example: echo $PATH TRN :
alias -g TRN='| (){ tr -- "$1" "\n";}'


# Set grc alias for available commands.
[[ -f /etc/grc.conf           ]] && grc_conf='/etc/grc.conf'
[[ -f /usr/local/etc/grc.conf ]] && grc_conf='/usr/local/etc/grc.conf'
grc_ignore=(ls systemctl)
if [[ -n ${grc_conf} ]]; then
    grep '^# ' "${grc_conf}" | cut -f 2 -d ' ' |
    while read -r cmd; do
        if (( ${+commands[$cmd]} )) && ! (($grc_ignore[(Ie)$cmd])); then
            eval "$cmd() { grc --colour=auto $cmd \"\$@\" }"
        fi
    done
fi
unset grc_ignore
unset grc_conf


# I'm not a robot
alias du='du -h'
alias df='df -h'
alias free='free --human'


# Create directory and cd to it
mkcd() { [[ $# == 1 ]] && \mkdir -pv -- "$1" && cd -P -- "$1" ; }
compdef _directories mkcd
# Create new file with all base directories
new() { [[ $# == 1 ]] && \mkdir -pv -- "${1:h}" && touch -- "$1" ; }
compdef _directories new
# Create new file with all base directories and open it in editor
nev() { [[ $# == 1 ]] && new "$1" && ${EDITOR:-vim} -- "$1" ; }
compdef _directories nev
# Follow links when opening in sublime
# subl() { ${commands[subl]} -- "$(readlink -f "$1")"; }

# Restore old `cal` bahavior: highlight current day
cal() { if [ -t 1 ] ; then ncal -bM "$@"; else /usr/bin/cal -M "$@"; fi }

# Wrap into a readline
if (( ${+commands[rlwrap]} )); then
    (( ${+commands[csi]}  )) && csi()  {rlwrap csi  "$@"; }  # scheme interpreter
    (( ${+commands[make]} )) && make() {rlwrap make "$@"; }  # for interactive menus, e.g. `make menuconfig`
fi


# Suffix aliases
alias -s json='jq <'
alias -s {cs,ts,html}=${EDITOR}
