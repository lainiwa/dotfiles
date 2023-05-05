
# zmodload zsh/zprof

# https://bixense.com/clicolors/
export CLICOLOR=1
# What characters are considered to be a part of a word
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
# Pagers and editors
export VISUAL=vim
export EDITOR=vim
export METAMAIL_PAGER=less
export PAGER=less
(( ${+commands[lesspipe]} )) && export LESSOPEN='|lesspipe %s'
export LESS='-Ri '
# Set a virtualenvwrapper path, if not already set (resolves tmux nesting issue)
export VIRTUALENVWRAPPER_PYTHON=${VIRTUALENVWRAPPER_PYTHON:-$(which python3)}
export VIRTUALENV_PYTHON=${VIRTUALENVWRAPPER_PYTHON}
# Node Version Manager (NVM) direcory
export NVM_DIR=${HOME}/.nvm
# ZSH history
export HISTFILE=${HISTFILE:-${HOME}/.zsh_history}
export HISTSIZE=10000000
export SAVEHIST=10000000
# Zoxide
export _ZO_MAXAGE=10000000

# Try to source:
for file (
    # NVM script and its completions
    "${NVM_DIR}/nvm.sh"
    "${NVM_DIR}/bash_completion"
    # zsh settings
    "${HOME}/.config/zsh/man.zsh"
    "${HOME}/.config/zsh/opts.zsh"
    "${HOME}/.config/zsh/keys.zsh"
    # "${HOME}/.config/zsh/zplugin.zsh"
    "${HOME}/.config/zsh/zpm.zsh"
    "${HOME}/.config/zsh/aliases.zsh"
    "${HOME}/.config/zsh/completions.zsh"
    "${HOME}/.config/zsh/nnn.zsh"
    # command-not-found functionality
    "${HOME}/.config/zsh/other/command-not-found.zsh"
    # python's virtualenvwrapper
    # "${HOME}/.local/bin/virtualenvwrapper_lazy.sh"
    # nix package manager
)
    [[ -s "${file}" ]] && source "${file}"


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


# opam configuration
if [[ -r ~/.opam/opam-init/init.zsh ]]; then
    source ~/.opam/opam-init/init.zsh
    eval "$(opam env)"
fi


# # Set terminal title
# preexec_hook_set_title() {
#     print -Pn "\e]0;${1}\a"
# }
# autoload -Uz add-zsh-hook
# add-zsh-hook preexec preexec_hook_set_title


# Deduplicate these arrays
typeset -U path cdpath fpath manpath
# zprof


# # Run tmux on start
# if (( ${+commands[tmux]}     )) &&
#     [[ ! "${TERM}" =~ screen ]] &&
#     [[ ! "${TERM}" =~ tmux   ]] &&
#     [[ -z "${TMUX}"          ]]; then
#   tmux attach || tmux
# fi
