
# https://github.com/zulu-zsh/zulu/blob/master/src/commands/init.zsh
# not all options (see git [TAB])

# Suggestions descriptions.
builtin zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
builtin zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
builtin zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
builtin zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
builtin zstyle ':completion:*' format ' %F{yellow}-- %d --%f'

# Fuzzy match mistyped completions.
# builtin zstyle ':completion:*' completer _complete _match _approximate
# builtin zstyle ':completion:*:match:*' original only
# builtin zstyle ':completion:*:approximate:*' max-errors 1 numeric

# Increase the number of errors based on the length of the typed word.
# builtin zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'

# https://www.topbug.net/blog/2017/08/08/enable-auto-completion-for-pip-in-zsh/
#compctl -K _pip_completion pip3
#eval "$(pip completion --zsh)"
