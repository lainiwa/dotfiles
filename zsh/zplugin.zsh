
if [ ! -d "$HOME/.zplugin" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"
fi

source "$HOME/.zplugin/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

zplugin ice from"gh-r" as"command";         zplugin light junegunn/fzf-bin
zplugin ice as"command" pick"bin/fzf-tmux"; zplugin light junegunn/fzf
zplugin snippet 'https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.zsh'   # because no way(?) to src two files at once
zplugin snippet 'https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh'

# eval "$(pip3 completion --zsh)"  # <-- slow af. soo:
function _pip_completion {
  local words cword
  read -Ac words
  read -cn cword
  reply=( $( COMP_WORDS="$words[*]" \
             COMP_CWORD=$(( cword-1 )) \
             PIP_AUTO_COMPLETE=1 $words[1] ) )
}
compctl -K _pip_completion pip3


zplugin light supercrabtree/k                        # ls -lh + git helpers
zplugin light soimort/translate-shell
zplugin light mafredri/zsh-async
zplugin light seletskiy/zsh-fuzzy-search-and-edit    # Ctrl+P
zplugin light zlsun/solarized-man
zplugin light hcgraf/zsh-sudo                        # Toggles "sudo" before the current/previous command by pressing ESC-ESC.
zplugin light MichaelAquilina/zsh-you-should-use
zplugin light Tarrasch/zsh-command-not-found         # Guess what to install when running an unknown command.
zplugin light Tarrasch/zsh-functional
zplugin light Tarrasch/zsh-autoenv
zplugin light tonyseek/oh-my-zsh-virtualenv-prompt   # I use virtualenv_prompt_info() from here.
zplugin light bric3/nice-exit-code                   # Maps exit status code to human readable string.
zplugin light sindresorhus/pretty-time-zsh           # Used in prompt to convert seconds to human-readable format.
zplugin light popstas/zsh-command-time               # Print time after program finishes. I use it in right prompt.
zplugin light rupa/z                                 # Looks like autojump
zplugin light andrewferrier/fzf-z                    # alt+g to choose from most frecent folders
zplugin light chrissicool/zsh-256color
zplugin light zsh-users/zsh-completions              # Additional completion definitions for Zsh.
zplugin light zsh-users/zsh-autosuggestions          # slow!
zplugin light zsh-users/zsh-syntax-highlighting      # Syntax highlighting bundle
zplugin light zsh-users/zsh-history-substring-search # Crtl+R search now highlited

zplugin ice pick"manydots-magic"; zplugin light knu/zsh-manydots-magic

# tonyseek/oh-my-zsh-virtualenv-prompt
PS1='%B%F{green}$(virtualenv_prompt_info)'$PS1

# bric3/nice-exit-code
RPS1='%B%F{red}$(nice_exit_code)%f%b'

# popstas/zsh-command-time
# sindresorhus/pretty-time-zsh
ZSH_COMMAND_TIME_MIN_SECONDS=1
ZSH_COMMAND_TIME_MSG=''
RPS1=$RPS1' %B%F{green}$([[ -n $ZSH_COMMAND_TIME ]] && pretty-time $ZSH_COMMAND_TIME)%f%b'

# mafredri/zsh-async
# seletskiy/zsh-fuzzy-search-and-edit
bindkey '^P' fuzzy-search-and-edit
export EDITOR="${EDITOR:-vim}"

# zsh-users/zsh-syntax-highlighting
export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Caused compinit to spaun warning when 'sudo -s'
# autoload -Uz compinit
# compinit

zplugin cdreplay -q # -q is for quiet
