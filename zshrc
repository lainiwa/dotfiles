
# zmodload zsh/zprof



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
    # "${HOME}/.zsh/zplugin.zsh"
    "${HOME}/.zsh/zpm.zsh"
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




# opam configuration
if [[ -r ~/.opam/opam-init/init.zsh ]]; then
    source ~/.opam/opam-init/init.zsh
    eval "$(opam env)"
fi

export NNN_OPTS="dnrx"
if [[ -d ${XDG_CONFIG_HOME:-${HOME}/.config}/nnn/plugins ]]; then
    export NNN_PLUG='f:finder;o:fzopen;p:mocplay;d:diffs;t:nmount;v:imgview'
    (( ${+commands[fzf]} && ${+functions[zshz]} )) && export NNN_PLUG="${NNN_PLUG};z:fzz"
    export NNN_PLUG="${NNN_PLUG};a:preview-tabbed"
fi

# zprof
