
# https://github.com/zulu-zsh/zulu/blob/master/src/commands/init.zsh
# not all options (see git [TAB])

# additional completions
# compdef _gnu_generic tr lsb_release

# Suggestions descriptions.
builtin zstyle ':completion:*:corrections'  format ' %F{green}-- %d (errors: %e) --%f'
builtin zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
builtin zstyle ':completion:*:messages'     format ' %F{purple} -- %d --%f'
builtin zstyle ':completion:*:warnings'     format ' %F{red}-- no matches found --%f'
builtin zstyle ':completion:*'              format ' %F{yellow}-- %d --%f'

# Select completions with arrows
builtin zstyle ':completion:*' menu select

# Fuzzy match mistyped completions.
# builtin zstyle ':completion:*' completer _complete _match _approximate
# builtin zstyle ':completion:*:match:*' original only
# builtin zstyle ':completion:*:approximate:*' max-errors 1 numeric

# Increase the number of errors based on the length of the typed word.
# builtin zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'


# Do menu-driven completion.
# zstyle ':completion:*' menu select

# Color completion for some things.
# http://linuxshellaccount.blogspot.com/2008/12/color-completion-using-zsh-modules-on.html
# zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# zstyle ':completion:*' list-colors 'reply=( "=(#b)(*$VAR)(?)*=00=$color[green]=$color[bg-green]" )'
# zstyle ':completion:*:*:*:*:hosts' list-colors '=*=30;41'
# zstyle ':completion:*:*:*:*:users' list-colors '=*=$color[green]=$color[red]'
# zstyle ':completion:*' list-colors ''

# # formatting and messages
# # http://www.masterzen.fr/2009/04/19/in-love-with-zsh-part-one/
# zstyle ':completion:*' verbose yes
# zstyle ':completion:*:descriptions' format "$fg[yellow]%B--- %d%b"
# zstyle ':completion:*:messages' format '%d'
# zstyle ':completion:*:warnings' format "$fg[red]No matches for:$reset_color %d"
# zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
# zstyle ':completion:*' group-name ''

# Git aliases
builtin zstyle ':completion:*:*:git:*' user-commands


# Load existing git completions into an array
zstyle -a ':completion:*:*:git:*' user-commands _commands_arr
# Add user commands to array
_commands_arr=(
       big-picture:'visualize git repositories'
       filter-repo:'rewrite (or analyze) repository history'
               dsf:''
           foresta:'text-based git log graph viewer'
              info:'show information about repository a la svn-info'
          playback:'play back or step through, commit by commit, the history of any git-controlled file'
    remote-keybase:''
              town:'make software development teams who use git even more productive and happy'
    ${_commands_arr}
)
# Load the updated completions list back to work
zstyle ':completion:*:*:git:*' user-commands "${_commands_arr[@]}"
