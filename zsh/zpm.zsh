
# Lacking (compared to zplugin.zsh)
# * rupa/v
# * bobthecow/git-flow-completion
# * spwhitt/nix-zsh-completions
# * nojanath/ansible-zsh-completion
# * gdown


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
    # ZPM plugins
    zpm-zsh/clipboard
    zpm-zsh/undollar
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
    zsh-users/zsh-completions,apply:fpath
    zdharma/history-search-multi-word,fpath:/
    zdharma/fast-syntax-highlighting
    zsh-users/zsh-autosuggestions,source:zsh-autosuggestions.zsh
    # Substitute `...` with `../..`
    lainiwa/zsh-manydots-magic,source:manydots-magic
)
zpm load "${plugins[@]}"


get_comp() {
    local name=${1}
    local url=${2}
    if [[ ! -f ${_ZPM}/completions/_${name} ]]; then
        mkdir --parents -- "${_ZPM}/completions"
        wget --quiet "${url}" --output-document="${_ZPM}/completions/_${name}"
    fi
}
gen_comp() {
    local name=${1}
    local cmd=${2}
    local has=${${(z)cmd}[1]}
    if [[ ! -f ${_ZPM}/completions/_${name} ]] && (( ${+commands[${has}]} )); then
        mkdir --parents -- "${_ZPM}/completions"
        eval "${cmd}"    > "${_ZPM}/completions/_${name}"
    fi
}
sourceable() {
    local cmd=${1}
    local has=${${(z)cmd}[1]}
    if [[ ! -f ${_ZPM}/sourceables/${has}.zsh ]] && (( ${+commands[${has}]} )); then
        mkdir --parents -- "${_ZPM}/sourceables"
        eval "${cmd}"    > "${_ZPM}/sourceables/${has}.zsh"
    fi
    if [[ -f ${_ZPM}/sourceables/${has}.zsh ]]; then
        source "${_ZPM}/sourceables/${has}.zsh"
    fi
}
# Download completions
get_comp beet           "${GH}/beetbox/beets/master/extra/_beet"
get_comp buku           "${GH}/jarun/Buku/master/auto-completion/zsh/_buku"
get_comp docker-compose "${GH}/docker/compose/master/contrib/completion/zsh/_docker-compose"
get_comp exa            "${GH}/ogham/exa/master/contrib/completions.zsh"
get_comp ffsend         "${GH}/timvisee/ffsend/master/contrib/completions/_ffsend"
get_comp gist           "${GH}/jdowner/gist/alpha/share/gist.zsh"
get_comp guix           "${GNU}/cgit/guix.git/plain/etc/completion/zsh/_guix"
get_comp khal           "${GH}/pimutils/khal/master/misc/__khal"
# Generate completions for present commands
gen_comp cargo  'rustup completions zsh cargo'
gen_comp pipx   'register-python-argcomplete pipx'
gen_comp poetry 'poetry completions zsh'
gen_comp rclone 'rclone genautocomplete zsh /dev/stdout'
gen_comp restic 'restic generate --zsh-completion /dev/stdout'
gen_comp rustup 'rustup completions zsh rustup'
gen_comp beet   'curl --silent "${GH}/beetbox/beets/master/extra/_beet" | sed s/awk/gawk/g'
# Generate completions for present commands
sourceable 'pyenv init - --no-rehash'
sourceable 'pip  completion --zsh'
sourceable 'pip3 completion --zsh'
sourceable 'dircolors --bourne-shell <(curl --silent "${GH}/trapd00r/LS_COLORS/master/LS_COLORS")'
autoload -U +X bashcompinit
bashcompinit
sourceable 'terraform version >/dev/null && <<<"complete -o nospace -C $(which terraform) terraform"'


fpath+=(${_ZPM}/completions)
fpath+=(~/.zsh/completions/)
# export FPATH=${HOME}/.zsh/completions:${FPATH}


unset _ZPM
unset GH
unset GNU
