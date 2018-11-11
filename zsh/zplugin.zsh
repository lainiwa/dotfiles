
# Install `zplugin` if not installed
if [ ! -d "$HOME/.zplugin" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"
fi

source "$HOME/.zplugin/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin


# Install `fzf`
zplugin ice from"gh-r" as"command";                                       zplugin light junegunn/fzf-bin
zplugin ice as"command" pick"bin/fzf-tmux";                               zplugin light junegunn/fzf
zplugin ice multisrc"shell/{completion,key-bindings}.zsh" id-as"fzf-zsh"; zplugin light junegunn/fzf

zplugin ice as"command" pick"v";            zplugin light rupa/v
zplugin ice as"command" pick"bin/git-dsf";  zplugin light zdharma/zsh-diff-so-fancy
zplugin ice if'[[ -n "$commands[gawk]" ]]'; zplugin light soimort/translate-shell
# stoped working after zplugin update (?)
# zplugin ice pick"manydots-magic"; zplugin light knu/zsh-manydots-magic


zplugin light supercrabtree/k                        # ls -lh + git helpers
zplugin light mafredri/zsh-async
zplugin light seletskiy/zsh-fuzzy-search-and-edit    # Ctrl+P
zplugin light hcgraf/zsh-sudo                        # Toggles "sudo" before the current/previous command by pressing ESC-ESC.
zplugin light Tarrasch/zsh-command-not-found         # Guess what to install when running an unknown command.
zplugin light tonyseek/oh-my-zsh-virtualenv-prompt   # I use virtualenv_prompt_info() from here.
zplugin light bric3/nice-exit-code                   # Maps exit status code to human readable string.
zplugin light sindresorhus/pretty-time-zsh           # Used in prompt to convert seconds to human-readable format.
zplugin light popstas/zsh-command-time               # Print time after program finishes. I use it in right prompt.
zplugin light rupa/z                                 # Looks like autojump
zplugin light andrewferrier/fzf-z                    # ctrl+g to choose from most frecent folders
zplugin light chrissicool/zsh-256color
zplugin light zsh-users/zsh-completions              # Additional completion definitions for Zsh.
zplugin light zsh-users/zsh-autosuggestions          # slow!
zplugin light zsh-users/zsh-syntax-highlighting      # Syntax highlighting bundle
zplugin light zsh-users/zsh-history-substring-search # Crtl+R search now highlited
zplugin light changyuheng/fz                         # lets z+[Tab] and zz+[Tab]. Doesn't integrate well with autosuggestions
                                                     # but there is hope: https://github.com/changyuheng/fz/pull/15

# zplugin light lainiwa/pastebin  # experimenting with my extention
zplugin ice as"completion"; zplugin snippet "${HOME}/.zsh/completions/_my"  # flag `-f` for developing mode

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

# Install completions
autoload -Uz compinit
compinit -i  # if not `-i` spauns warning when 'sudo -s'

# Execute compdefs provided by rest of plugins
zplugin cdreplay -q
