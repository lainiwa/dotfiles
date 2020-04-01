

_ZPM=${XDG_CACHE_HOME:-${HOME}/.cache}/zpm
GH=https://raw.githubusercontent.com
GNU=https://git.savannah.gnu.org

# Install ZSH Plugin Manager
export _ZPM_DIR=${_ZPM}/zpm
export _ZPM_PLUGIN_DIR=${_ZPM}/plugins
if [[ ! -f ${_ZPM_DIR}/zpm.zsh ]]; then
  git clone --depth 1 https://github.com/zpm-zsh/zpm "${_ZPM_DIR}"
fi
source "${_ZPM_DIR}/zpm.zsh"


# Refresh ZPM cache
# if cache is older than this file
if [[ ${0} -nt ${TMPDIR:-/tmp}/zsh-${UID} ]]; then
    zpm clean
fi

# Python virtual environment name
AGKOZAK_CUSTOM_PROMPT='%(10V.%B%F{green}(%10v)%f%b.)'
# Username and hostname
AGKOZAK_CUSTOM_PROMPT+='%(!.%S%B.%B%F{yellow})%n%1v%(!.%b%s.%f%b) '
# Path
AGKOZAK_CUSTOM_PROMPT+=$'%B%F{green}%2v%f%b '
# Prompt character
AGKOZAK_CUSTOM_PROMPT+='%B%F{red}%(4V.:.%#)%f%b '
# Git status
AGKOZAK_CUSTOM_SYMBOLS=( '⇣⇡' '⇣' '⇡' '+' 'x' '!' '>' '?' 'S')
AGKOZAK_CUSTOM_RPROMPT='%(3V.%F{yellow}%3v%f.)'
# Exit status
AGKOZAK_CUSTOM_RPROMPT+=' %(?..%B%F{red}(%?%)%f%b)'
# Execution time
AGKOZAK_CMD_EXEC_TIME=1
AGKOZAK_CUSTOM_RPROMPT+=' %B%F{green}%9v%f%b'


# Zsh-z configuration
export ZSHZ_DATA=${HOME}/.cache/.z
export ZSHZ_OWNER=${HOME:t}
# Gitcd configuration
export GITCD_HOME=${HOME}/tmp
export GITCD_TRIM=1


plugins=(
    # Prompt
    romkatv/zsh-prompt-benchmark
    agkozak/agkozak-zsh-prompt
    # Z
    agkozak/zsh-z
    andrewferrier/fzf-z
    # Rename tmux pane to current folder's basename
    trystan2k/zsh-tab-title
    # Command-line online translator
    soimort/translate-shell
    # Toggles `sudo` for current/previous command on ESC-ESC.
    hcgraf/zsh-sudo
    # Run `fg` on C-Z
    mdumitru/fancy-ctrl-z
    # My plugins
    lainiwa/gitcd
    lainiwa/ph-marks
    # Adds git open
    paulirish/git-open
    # Completions
    bobthecow/git-flow-completion
    spwhitt/nix-zsh-completions
    # Get gitignore template with `gi` command
    voronkovich/gitignore.plugin.zsh
    # Heavy stuff
    zsh-users/zsh-completions
    zdharma/history-search-multi-word,fpath:/
    zdharma/fast-syntax-highlighting
    zsh-users/zsh-autosuggestions,source:zsh-autosuggestions.zsh
    # Substitute `...` with `../..`
    ankaan/zsh-manydots-magic,source:manydots-magic
)
zpm load "${plugins[@]}"


# Create and enter completions directory
mkdir --parents -- "${_ZPM}/completions"
pushd -q "${_ZPM}/completions"
# Download completions
[[ ! -f _exa ]] &&
wget --quiet "${GH}/ogham/exa/master/contrib/completions.zsh" --output-document=_exa
[[ ! -f _gist ]] &&
    wget --quiet "${GH}/jdowner/gist/alpha/share/gist.zsh" --output-document=_gist
[[ ! -f _khal ]] &&
    wget --quiet "${GH}/pimutils/khal/master/misc/__khal" --output-document=_khal
[[ ! -f _buku ]] &&
    wget --quiet "${GH}/jarun/Buku/master/auto-completion/zsh/_buku"
[[ ! -f _docker-completion ]] &&
    wget --quiet "${GH}/docker/compose/master/contrib/completion/zsh/_docker-compose"
[[ ! -f _beet ]] &&
    wget --quiet "${GH}/beetbox/beets/master/extra/_beet"
[[ ! -f _guix ]] &&
    wget --quiet "${GNU}/cgit/guix.git/plain/etc/completion/zsh/_guix"
# Generate completions for present commands
[[ ! -f _rclone ]] && (( ${+commands[rclone]} )) &&
    rclone genautocomplete zsh _rclone
[[ ! -f _poetry ]] && (( ${+commands[poetry]} )) &&
    poetry completions zsh > _poetry
[[ ! -f _cargo  ]] && (( ${+commands[rustup]} )) &&
    rustup completions zsh cargo > _cargo
[[ ! -f _rustup ]] && (( ${+commands[rustup]} )) &&
    rustup completions zsh rustup > _rustup

# Leave completions directory
popd -q

fpath+=(${_ZPM}/completions)
fpath+=(~/.zsh/completions/)
# export FPATH=${HOME}/.zsh/completions:${FPATH}

# Create and enter completions directory
mkdir --parents -- "${_ZPM}/sourceables"
pushd -q "${_ZPM}/sourceables"
# Generate completions for present commands
[[ ! -f   pyenv.zsh ]] && (( ${+commands[pyenv]}     )) &&
    pyenv init - --no-rehash > pyenv.zsh
[[ ! -f     pip.zsh ]] && (( ${+commands[pip]}       )) &&
    pip completion --zsh > pip.zsh
[[ ! -f    pip3.zsh ]] && (( ${+commands[pip3]}      )) &&
    pip3 completion --zsh > pip3.zsh
[[ ! -f lscolors.sh ]] && (( ${+commands[dircolors]} )) &&
    dircolors --bourne-shell \
        <(curl --silent "${GH}/trapd00r/LS_COLORS/master/LS_COLORS") \
        >lscolors.sh
# Leave completions directory
popd -q

for sourceable in "${_ZPM}/sourceables"/*sh; do
    source "${sourceable}"
done


unset _ZPM
unset GH
unset GNU
