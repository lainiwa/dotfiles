
# zmodload zsh/zprof

# Mass rename
autoload -U zmv                                                                                  127:CNOTFOUND 1s
alias mmv='noglob zmv -W'

# # Connect to tmux automatically
# # if running in Simple Terminal or through Mosh
# # pstree -p -s $$ | grep tmux:
# if command -v tmux &>/dev/null &&
#     [[ -z "${TMUX}" && ${TERM} =~ st* || "$(ps -p $PPID -o comm=)" == 'mosh-server' ]]; then
#     tmux attach -t default || tmux new -s default
#     exit
# fi


# Set key bindings (Ctrl+V Key to see key code)
bindkey -e
bindkey "^[[1;5C"    forward-word # Ctrl+Right
bindkey "^[[1;5D"   backward-word # Ctrl+Left
bindkey ";2A"          up-history # Shift+Up
bindkey ";2B"        down-history # Shift+Down
bindkey "^[[5~"        up-history # PageUp
bindkey "^[[6~"      down-history # PageDown


# What characters are considered to be a part of a word
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
# Pager and editor
export PAGER=less
export EDITOR=vim
# Set a virtualenvwrapper path, if not already set (resolves tmux nesting issue)
export VIRTUALENVWRAPPER_PYTHON=${VIRTUALENVWRAPPER_PYTHON:-$(which python3)}
export VIRTUALENV_PYTHON="${VIRTUALENVWRAPPER_PYTHON}"
# Node Version Manager (NVM) direcory
export NVM_DIR="${HOME}/.nvm"


# Try to source:
for file (
    # NVM script and its completions
    "${NVM_DIR}/nvm.sh"
    "${NVM_DIR}/bash_completion"
    # zsh settings
    "${HOME}/.zsh/antibody.zsh"
    "${HOME}/.zsh/aliases.zsh"
    "${HOME}/.zsh/set_history.zsh"
    "${HOME}/.zsh/completions.zsh"
    # command-not-found functionality
    "${HOME}/.zsh/other/command-not-found.zsh"
    # python's virtualenvwrapper
    # "${HOME}/.local/bin/virtualenvwrapper_lazy.sh"
    # nix package manager
)
    [ -s "${file}" ] && source "${file}"


# Set some options
setopt interactive_comments extended_glob autocd complete_aliases


# Automatically list directory contents on `cd`.
auto-ls () { ls; }
[[ ${chpwd_functions[(r)auto-ls]} == auto-ls ]] || chpwd_functions=( auto-ls $chpwd_functions )


# Run manpage on Esc+h
autoload -Uz run-help
autoload -Uz run-help-git
autoload -Uz run-help-sudo
bindkey '^[h' run-help  # Esc+h



# Choose binary in $PATH with fzf
insert_binary_from_path() {
    cmd=$(print -rl -- ${(ko)commands} | fzf --height 40% --layout=reverse)
    LBUFFER="${LBUFFER}${cmd}"
    zle redisplay
}
zle -N insert_binary_from_path
bindkey '^[d' insert_binary_from_path  # Alt+d


# zprof
