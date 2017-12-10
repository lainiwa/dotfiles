export VIRTUALENVWRAPPER_PYTHON=python3
source /usr/local/bin/virtualenvwrapper.sh

for file in $(echo "prompts aliases set_history antigen completions")
do
    . "$HOME/.zsh/.zsh_$file"
done

rationalize-dot() { [[ $LBUFFER = *.. ]] && LBUFFER+=/.. || LBUFFER+=. }
zle -N rationalize-dot # try to type "..." to see what this is
bindkey . rationalize-dot

# Automatically list directory contents on `cd`.
auto-ls () { ls; }
[[ ${chpwd_functions[(r)auto-ls]} == auto-ls ]] || chpwd_functions=( auto-ls $chpwd_functions )

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


setopt INTERACTIVE_COMMENTS extended_glob autocd

# Esc+h
autoload -Uz run-help
autoload -Uz run-help-git
autoload -Uz run-help-sudo

bindkey -e
export WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>'
# Ctrl+V Key to see key code
# Ctrl+Right and Ctrl+Left to skip words (lxterminal. doesn't work in urxvt)
bindkey ";5C" forward-word
bindkey ";5D" backward-word
# Shift+Up and Shift+Down to scroll history
bindkey ";2A" up-history
bindkey ";2B" down-history
# Same for PageUp and PageDown 
bindkey "^[[5~" up-history
bindkey "^[[6~" down-history

export PAGER=less
