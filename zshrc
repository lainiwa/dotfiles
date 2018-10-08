
export VIRTUALENVWRAPPER_PYTHON="${VIRTUALENVWRAPPER_PYTHON:-$(which python3)}"
source "$(which virtualenvwrapper.sh)"

setopt interactive_comments extended_glob autocd complete_aliases
# Ctrl+V Key to see key code
# bindkey -e
bindkey "^A" vi-beginning-of-line  # Ctrl+A
bindkey "^E"       vi-end-of-line  # Ctrl+E
bindkey "^[[1;5C"     forward-word # Ctrl+Right
bindkey "^[[1;5D"    backward-word # Ctrl+Left
bindkey ";2A"           up-history # Shift+Up
bindkey ";2B"         down-history # Shift+Down
bindkey "^[[5~"         up-history # PageUp
bindkey "^[[6~"       down-history # PageDown

for file in prompts aliases set_history zplugin completions; do
    source "$HOME/.zsh/$file.zsh"
done

# Automatically list directory contents on `cd`.
auto-ls () { ls; }
[[ ${chpwd_functions[(r)auto-ls]} == auto-ls ]] || chpwd_functions=( auto-ls $chpwd_functions )

# Esc+h
autoload -Uz run-help
autoload -Uz run-help-git
autoload -Uz run-help-sudo


export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
export EDITOR=vim
if type most &>/dev/null; then
    export PAGER=most
else
    export PAGER=less
fi

export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
    source "$NVM_DIR/nvm.sh"
fi
if [ -s "$NVM_DIR/bash_completion" ]; then
    source "$NVM_DIR/bash_completion"
fi

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
