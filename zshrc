
export VIRTUALENVWRAPPER_PYTHON="${VIRTUALENVWRAPPER_PYTHON:-$(which python3)}"
source "$(which virtualenvwrapper.sh)"

for file (prompts aliases set_history zplugin completions) source "$HOME/.zsh/$file.zsh" end

# Automatically list directory contents on `cd`.
auto-ls () { ls; }
[[ ${chpwd_functions[(r)auto-ls]} == auto-ls ]] || chpwd_functions=( auto-ls $chpwd_functions )

setopt INTERACTIVE_COMMENTS extended_glob autocd

# Esc+h
autoload -Uz run-help
autoload -Uz run-help-git
autoload -Uz run-help-sudo

bindkey -e

# Ctrl+V Key to see key code
bindkey "^[[1;5C"  forward-word # Ctrl+Right
bindkey "^[[1;5D" backward-word # Ctrl+Left
bindkey ";2A"     up-history    # Shift+Up
bindkey ";2B"   down-history    # Shift+Down
bindkey "^[[5~"   up-history    # PageUp
bindkey "^[[6~" down-history    # PageDown

export WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>'
export PAGER=less
export EDITOR=vim
