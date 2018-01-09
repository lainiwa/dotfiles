
if [ ! -d "$HOME/.zplugin" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"
fi

source "$HOME/.zplugin/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

zplugin ice from"gh-r" as"command";         zplugin load junegunn/fzf-bin
zplugin ice as"command" pick"bin/fzf-tmux"; zplugin load junegunn/fzf
zplugin ice if'[[ $- == *i* ]]';
zplugin snippet 'https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.zsh'   # because no way(?) to src two files at once
zplugin snippet 'https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh'

zplugin load supercrabtree/k                        # ls -lh + git helpers
zplugin load soimort/translate-shell
zplugin load mafredri/zsh-async
zplugin load seletskiy/zsh-fuzzy-search-and-edit    # Ctrl+P
zplugin load zlsun/solarized-man
zplugin load hcgraf/zsh-sudo                        # Toggles "sudo" before the current/previous command by pressing ESC-ESC.
zplugin load MichaelAquilina/zsh-you-should-use
zplugin load Tarrasch/zsh-command-not-found         # Guess what to install when running an unknown command.
zplugin load Tarrasch/zsh-functional
zplugin load Tarrasch/zsh-autoenv
zplugin load tonyseek/oh-my-zsh-virtualenv-prompt   # I use virtualenv_prompt_info() from here.
zplugin load bric3/nice-exit-code                   # Maps exit status code to human readable string.
zplugin load sindresorhus/pretty-time-zsh           # Used in prompt to convert seconds to human-readable format.
zplugin load popstas/zsh-command-time               # Print time after program finishes. I use it in right prompt.
zplugin load rupa/z                                 # Looks like autojump
zplugin load andrewferrier/fzf-z                    # alt+g to choose from most frecent folders
zplugin load chrissicool/zsh-256color
zplugin load zsh-users/zsh-completions              # Additional completion definitions for Zsh.
zplugin load zsh-users/zsh-autosuggestions
zplugin load zsh-users/zsh-syntax-highlighting      # Syntax highlighting bundle
zplugin load zsh-users/zsh-history-substring-search # Crtl+R search now highlited

zplugin ice pick"manydots-magic"; zplugin load knu/zsh-manydots-magic

# tonyseek/oh-my-zsh-virtualenv-prompt
PS1='%B%F{green}$(virtualenv_prompt_info)'$PS1

# bric3/nice-exit-code
RPS1='%B%F{red}$(nice_exit_code)%f%b'

# popstas/zsh-command-time
# sindresorhus/pretty-time-zsh
ZSH_COMMAND_TIME_MIN_SECONDS=1
ZSH_COMMAND_TIME_ECHO=''
RPS1=$RPS1' %B%F{green}$([[ -n $ZSH_COMMAND_TIME ]] && pretty-time $ZSH_COMMAND_TIME)%f%b'

# mafredri/zsh-async
# seletskiy/zsh-fuzzy-search-and-edit
bindkey '^P' fuzzy-search-and-edit
export EDITOR="${EDITOR:-vim}"

# zsh-users/zsh-syntax-highlighting
export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
