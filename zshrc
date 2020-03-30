
# zmodload zsh/zprof

# Mass rename
autoload -U zmv                                                                                  127:CNOTFOUND 1s
alias mmv='noglob zmv -W'



# What characters are considered to be a part of a word
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
# Pager and editor
export PAGER=less
export EDITOR=vim
# Set a virtualenvwrapper path, if not already set (resolves tmux nesting issue)
export VIRTUALENVWRAPPER_PYTHON=${VIRTUALENVWRAPPER_PYTHON:-$(which python3)}
export VIRTUALENV_PYTHON=${VIRTUALENVWRAPPER_PYTHON}
# Node Version Manager (NVM) direcory
export NVM_DIR=${HOME}/.nvm


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


# Choose binary in $PATH with fzf
insert_binary_from_path() {
    cmd=$(print -rl -- ${(ko)commands} | fzf --height 40% --layout=reverse)
    LBUFFER="${LBUFFER}${cmd}"
    zle redisplay
}
zle -N insert_binary_from_path
bindkey '^[d' insert_binary_from_path  # Alt+d


# zprof
