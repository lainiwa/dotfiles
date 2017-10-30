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

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
