
# zmodload zsh/zprof



# What characters are considered to be a part of a word
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
# Pagers and editors
export PAGER=less
export METAMAIL_PAGER=less
export VISUAL=vim
export EDITOR=vim
# Set a virtualenvwrapper path, if not already set (resolves tmux nesting issue)
export VIRTUALENVWRAPPER_PYTHON=${VIRTUALENVWRAPPER_PYTHON:-$(which python3)}
export VIRTUALENV_PYTHON=${VIRTUALENVWRAPPER_PYTHON}
# Node Version Manager (NVM) direcory
export NVM_DIR=${HOME}/.nvm
# ZSH history
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=1000000000
export SAVEHIST=1000000000


# Try to source:
for file (
    # NVM script and its completions
    "${NVM_DIR}/nvm.sh"
    "${NVM_DIR}/bash_completion"
    # zsh settings
    "${HOME}/.zsh/opts.zsh"
    "${HOME}/.zsh/keys.zsh"
    # "${HOME}/.zsh/antibody.zsh"
    "${HOME}/.zsh/zplugin.zsh"
    # "${HOME}/.zsh/zpm.zsh"
    "${HOME}/.zsh/aliases.zsh"
    "${HOME}/.zsh/completions.zsh"
    # command-not-found functionality
    "${HOME}/.zsh/other/command-not-found.zsh"
    # python's virtualenvwrapper
    # "${HOME}/.local/bin/virtualenvwrapper_lazy.sh"
    # nix package manager
)
    [ -s "${file}" ] && source "${file}"



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


autoload -U +X bashcompinit && bashcompinit
if (( ${+commands[terraform]} )); then
    complete -o nospace -C "$(which terraform)" terraform
fi


# opam configuration
if [[ -r ~/.opam/opam-init/init.zsh ]]; then
    ~/.opam/opam-init/init.zsh &>/dev/null || true
fi
eval "$(opam env)"

# zprof
