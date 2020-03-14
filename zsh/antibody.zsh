
# Install antibody
if (( ! ${+commands[antibody]} )); then
    curl --silent --fail --location git.io/antibody | sh -s - -b ~/bin
fi

# Configuration
ZSH_CACHE_DIR=${HOME}/.cache/zsh
COMPLETIONS_DIR=${ZSH_CACHE_DIR}/completions
SOURCEABLES_DIR=${ZSH_CACHE_DIR}/sourceables

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
# Zsh-z configuration
export ZSHZ_DATA=${HOME}/.cache/.z
export ZSHZ_OWNER=${HOME:t}
# Gitcd configuration
export GITCD_HOME=${HOME}/tmp
export GITCD_TRIM=1

#
if [[ ! -d $COMPLETIONS_DIR ]]; then
    # Create and enter completions directory
    mkdir --parents -- "${COMPLETIONS_DIR}"
    pushd "${COMPLETIONS_DIR}"
    # Download completions
    GH=https://raw.githubusercontent.com
    wget --quiet "${GH}/ogham/exa/master/contrib/completions.zsh" --output-file=logfile
    wget --quiet "${GH}/jdowner/gist/alpha/share/gist.zsh" --output-file=_gist
    wget --quiet "${GH}/pimutils/khal/master/misc/__khal" --output-file=_khal
    wget --quiet "${GH}/jarun/Buku/master/auto-completion/zsh/_buku"
    wget --quiet "${GH}/docker/compose/master/contrib/completion/zsh/_docker-compose"
    wget --quiet "${GH}/beetbox/beets/master/extra/_beet"
    wget --quiet 'https://git.savannah.gnu.org/cgit/guix.git/plain/etc/completion/zsh/_guix'
    unset GH
    # Generate completions for present commands
    if (( ${+commands[rclone]} )); then
        rclone genautocomplete zsh _rclone
    fi
    if (( ${+commands[poetry]} )); then
        poetry completions zsh > _poetry
    fi
    if (( ${+commands[rustup]} )); then
        rustup completions zsh cargo > _cargo
        rustup completions zsh rustup > _rustup
    fi
    # Leave completions directory
    popd
fi

fpath+=(${COMPLETIONS_DIR})
fpath+=(~/.zsh/completions/)
export FPATH=${HOME}/.zsh/completions:${FPATH}

if [[ ! -d $SOURCEABLES_DIR ]]; then
    # Create and enter completions directory
    mkdir --parents -- "${SOURCEABLES_DIR}"
    pushd "${SOURCEABLES_DIR}"
    # Generate completions for present commands
    if (( ${+commands[antibody]} )); then
        antibody bundle < ~/.zsh/plugins.txt > plugins.zsh
    fi
    if (( ${+commands[pyenv]} )); then
        pyenv init - --no-rehash > pyenv.zsh
    fi
    if (( ${+commands[pip]} )); then
        pip completion --zsh > pip.zsh
    fi
    if (( ${+commands[pip3]} )); then
        pip3 completion --zsh > pip3.zsh
    fi
    if (( ${+commands[dircolors]} )); then
        dircolors --bourne-shell \
            <(curl --silent 'https://raw.githubusercontent.com/trapd00r/LS_COLORS/master/LS_COLORS') \
            >lscolors.sh
    fi
    # Leave completions directory
    popd
fi

for sourceable in "${SOURCEABLES_DIR}"/*; do
    source "${sourceable}"
done

unset ZSH_CACHE_DIR
unset COMPLETIONS_DIR
unset SOURCEABLES_DIR

autoload -U compinit
compinit
