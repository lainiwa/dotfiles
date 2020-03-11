
if [[ -z $commands[antibody] ]]; then
    curl -sfL git.io/antibody | sh -s - -b ~/bin
fi


GEN_COMPLETION_DIR=${HOME}/.cache/generated_zsh_completions

if [[ ! -d $GEN_COMPLETION_DIR ]]; then
    mkdir --parents "${GEN_COMPLETION_DIR}"
    pushd "${GEN_COMPLETION_DIR}"
    GH=https://raw.githubusercontent.com


    wget "${GH}/ogham/exa/master/contrib/completions.zsh" --output-file=logfile
    wget "${GH}/jdowner/gist/alpha/share/gist.zsh" --output-file=_gist
    wget "${GH}/pimutils/khal/master/misc/__khal" --output-file=_khal
    wget "${GH}/jarun/Buku/master/auto-completion/zsh/_buku"
    wget "${GH}/docker/compose/master/contrib/completion/zsh/_docker-compose"
    wget "${GH}/beetbox/beets/master/extra/_beet"
    wget 'https://git.savannah.gnu.org/cgit/guix.git/plain/etc/completion/zsh/_guix'

    if [[ -z $commands[rclone] ]]; then
        rclone genautocomplete zsh _rclone
    fi
    if [[ -z $commands[poetry] ]]; then
        poetry completions zsh > _poetry
    fi
    if [[ -z $commands[rustup] ]]; then
        rustup completions zsh cargo > _cargo
        rustup completions zsh rustup > _rustup
    fi

    unset GH
    popd
fi

fpath=(${GEN_COMPLETION_DIR} $fpath)
fpath=(~/.zsh/completions/ $fpath)
unset GEN_COMPLETION_DIR


source <(antibody init)

# Python virtual environment name
AGKOZAK_CUSTOM_PROMPT='%B%F{green}$(virtualenv_prompt_info)'
# Username and hostname
AGKOZAK_CUSTOM_PROMPT+='%(!.%S%B.%B%F{yellow})%n%1v%(!.%b%s.%f%b) '
# Path
AGKOZAK_CUSTOM_PROMPT+=$'%B%F{green}%2v%f%b '
# Prompt character
AGKOZAK_CUSTOM_PROMPT+='%B%F{red}%(4V.:.%#)%f%b '

# Git status
AGKOZAK_CUSTOM_RPROMPT='%(3V.%F{yellow}%3v%f.)'
# Exit status
AGKOZAK_CUSTOM_RPROMPT+=' %B%F{red}$(nice_exit_code)%f%b'
# Execution time
export ZSH_COMMAND_TIME_MIN_SECONDS=1
export ZSH_COMMAND_TIME_MSG=''
AGKOZAK_CUSTOM_RPROMPT+=' %B%F{green}$([[ -n ${ZSH_COMMAND_TIME} ]] && pretty-time ${ZSH_COMMAND_TIME})%f%b'


export ZSHZ_DATA="${HOME}/.cache/.z"
export ZSHZ_OWNER=$(basename "${HOME}")

export GITCD_HOME=${HOME}/tmp
export GITCD_TRIM=1

antibody bundle <<- EOF
    # prompt
    tonyseek/oh-my-zsh-virtualenv-prompt
    bric3/nice-exit-code
    sindresorhus/pretty-time-zsh
    popstas/zsh-command-time
    agkozak/agkozak-zsh-prompt

    agkozak/zsh-z
    andrewferrier/fzf-z

    # Rename tmux pane to current folder's basename
    trystan2k/zsh-tab-title

    # Add command-line online translator
    soimort/translate-shell

    # Toggles "sudo" before the current/previous command by pressing ESC-ESC.
    hcgraf/zsh-sudo

    # Run fg command to return to foregrounded (Ctrl+Z'd) vim
    mdumitru/fancy-ctrl-z

    lainiwa/gitcd

    # Adds git open
    paulirish/git-open

    bobthecow/git-flow-completion
    spwhitt/nix-zsh-completions

    # Get gitignore template with gi command
    #voronkovich/gitignore.plugin.zsh

    zsh-users/zsh-completions
    robobenklein/zdharma-history-search-multi-word
    zsh-users/zsh-autosuggestions
    zsh-users/zsh-syntax-highlighting

    ankaan/zsh-manydots-magic

EOF

autoload -U compinit
compinit
