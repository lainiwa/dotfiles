
# Return first installed util.
# Example: `_1st_found most less more`.
_1st_found() {
    for cmd in "$@"; do
        if type "$cmd" &>/dev/null; then
            printf "%s" "${cmd}"
            break
        fi
    done
}


# What characters are considered to be a part of a word
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
# Pager and editor
export PAGER=$(_1st_found most less more)
export EDITOR=$(_1st_found emacs vim vi)
# Set a virtualenvwrapper path, if not already set (resolves tmux nesting issue)
export VIRTUALENVWRAPPER_PYTHON="${VIRTUALENVWRAPPER_PYTHON:-$(which $(_1st_found python3.6 python3.5 python3))}"
# Node Version Manager (NVM) direcory
export NVM_DIR="$HOME/.nvm"


# Try to source:
#     NVM script and its completions
#     virtualenvwrapper
#     zsh settings
for file in "$NVM_DIR/nvm.sh" \
            "$NVM_DIR/bash_completion" \
            "$(which virtualenvwrapper.sh)" \
            "$HOME/.zsh/prompts.zsh" \
            "$HOME/.zsh/aliases.zsh" \
            "$HOME/.zsh/set_history.zsh" \
            "$HOME/.zsh/zplugin.zsh" \
            "$HOME/.zsh/completions.zsh"
do
    [ -s "$file" ] && source "$file"
done


# Set some options
setopt interactive_comments extended_glob autocd complete_aliases


# Set key bindings (Ctrl+V Key to see key code)
# bindkey -e
bindkey "^A" vi-beginning-of-line # Ctrl+A
bindkey "^E"       vi-end-of-line # Ctrl+E
bindkey "^[[1;5C"    forward-word # Ctrl+Right
bindkey "^[[1;5D"   backward-word # Ctrl+Left
bindkey ";2A"          up-history # Shift+Up
bindkey ";2B"        down-history # Shift+Down
bindkey "^[[5~"        up-history # PageUp
bindkey "^[[6~"      down-history # PageDown


# Automatically list directory contents on `cd`.
auto-ls () { ls; }
[[ ${chpwd_functions[(r)auto-ls]} == auto-ls ]] || chpwd_functions=( auto-ls $chpwd_functions )


# Run manpage on Esc+h
autoload -Uz run-help
autoload -Uz run-help-git
autoload -Uz run-help-sudo


# Unset function so it would not be available is shell
unset -f _1st_found
