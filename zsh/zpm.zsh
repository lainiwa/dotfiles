
# Lacking (compared to zplugin.zsh)
# * junegunn/fzf shell/{completion,key-bindings}.zsh
# * clean does not work?
# * make mdom/txtnish
# * Command-line online translator -- soimort/translate-shell


_ZPM=${XDG_CACHE_HOME:-${HOME}/.cache}/zpm
_ZPM_POL=${_ZPM}/polaris
_ZPM_COMP=${_ZPM}/completions
_ZPM_SRC=${_ZPM}/sourceables
GH=https://raw.githubusercontent.com
GNU=https://git.savannah.gnu.org

# Install ZSH Plugin Manager
export _ZPM_DIR=${_ZPM}/zpm
export _ZPM_PLUGIN_DIR=${_ZPM}/plugins
if [[ ! -f ${_ZPM_DIR}/zpm.zsh ]]; then
    git clone --depth 1 https://github.com/zpm-zsh/zpm "${_ZPM_DIR}"
    mkdir -p -- "${_ZPM_POL}"/{bin,share/{doc,man/man{1,2,3,4,5,6,7,8,9}}}
    mkdir -p -- "${_ZPM_COMP}"
    mkdir -p -- "${_ZPM_COMP}"
    mkdir -p -- "${_ZPM_SRC}"
fi
source "${_ZPM_DIR}/zpm.zsh"


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
# Autosuggestions configuration
# export ZSH_AUTOSUGGEST_USE_ASYNC=1
export ZSH_AUTOSUGGEST_MANUAL_REBIND=1
# Notes configuration
export QUICKNOTE_FORMAT="%Y-%m-%d"
export NOTES_EXT="md"
export NOTES_DIRECTORY=~/notes


plugins=(
    # Prompt
    romkatv/zsh-prompt-benchmark
    agkozak/agkozak-zsh-prompt
    # Z
    agkozak/zsh-z
    andrewferrier/fzf-z
    # Rename tmux pane to current folder's basename
    trystan2k/zsh-tab-title
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
    # Git related
    paulirish/git-open
    zdharma/zsh-diff-so-fancy
    # Completions
    zpm-zsh/zsh-completions,apply:fpath
    zchee/zsh-completions
    srijanshetty/zsh-pandoc-completion
    bobthecow/git-flow-completion
    spwhitt/nix-zsh-completions
    nojanath/ansible-zsh-completion
    lukechilds/zsh-better-npm-completion
    # Get gitignore template with `gi` command
    voronkovich/gitignore.plugin.zsh
    # Heavy stuff
    zdharma/history-search-multi-word,fpath:/
    zdharma/fast-syntax-highlighting
    zsh-users/zsh-autosuggestions,source:zsh-autosuggestions.zsh
    # Substitute `...` with `../..`
    lainiwa/zsh-manydots-magic,source:manydots-magic
    # Non-plugins
    dylanaraps/fff,hook:"make; PREFIX=${_ZPM_POL} make install"
    nvie/gitflow,hook:"make install prefix=${_ZPM_POL}"
    circulosmeos/gdown.pl,hook:"cp gdown.pl ${_ZPM_POL}/bin/gdown"
    snipem/v,hook:"PREFIX=${_ZPM_POL} make install"
    gitbits/git-info,hook:"cp git-* ${_ZPM_POL}/bin/"
    greymd/tmux-xpanes,hook:"./install.sh '${_ZPM_POL}'",apply:fpath,fpath:/completion/zsh
    pimterry/notes,hook:"PREFIX=${_ZPM_POL} make -f <(sed 's|^\(BASH_COMPLETION_DIR\).*|\1 = /tmp|' Makefile)"
    #
    # AdrieanKhisbe/diractions
    # michaelxmcbride/zsh-dircycle
)
zpm load "${plugins[@]}"


print_status() {
    local verb=${1}
    local entity=${2}
    echo "${c[bold]}${c[green]}${verb}" \
         "${c[blue]}${entity}" \
         "${c[green]}✔" \
         "${c[reset]}"
}
get_comp() {
    local name=${1}
    local url=${2}
    if [[ ! -f ${_ZPM_COMP}/_${name} ]]; then
        wget --quiet "${url}" --output-document="${_ZPM_COMP}/_${name}"
        print_status "Download" "_${name}"
    fi
}
gen_comp() {
    local name=${1}
    local cmd=${2}
    local has=${${(z)cmd}[1]}
    if [[ ! -f ${_ZPM_COMP}/_${name} ]] && (( ${+commands[${has}]} )); then
        eval "${cmd}"    > "${_ZPM_COMP}/_${name}"
        print_status "Generate" "_${name}"
    fi
}
gen_zsh() {
    local cmd=${1}
    local has=${${(z)cmd}[1]}
    if [[ ! -f ${_ZPM_SRC}/${has}.zsh ]] && (( ${+commands[${has}]} )); then
        eval "${cmd}"    > "${_ZPM_SRC}/${has}.zsh"
        print_status "Generate" "${has}.zsh"
    fi
}
get_bin() {
    local name=${1}
    local url=${2}
    if [[ ! -f ${_ZPM_POL}/bin/${name} ]]; then
        wget --quiet "${url}" --output-document="${_ZPM_POL}/bin/${name}"
        chmod +x "${_ZPM_POL}/bin/${name}"
        print_status "Download" "${name}"
    fi
}


(
# Download completions
get_comp beet           "${GH}/beetbox/beets/master/extra/_beet" &
get_comp buku           "${GH}/jarun/Buku/master/auto-completion/zsh/_buku" &
get_comp docker-compose "${GH}/docker/compose/master/contrib/completion/zsh/_docker-compose" &
get_comp exa            "${GH}/ogham/exa/master/contrib/completions.zsh" &
get_comp ffsend         "${GH}/timvisee/ffsend/master/contrib/completions/_ffsend" &
get_comp gist           "${GH}/jdowner/gist/alpha/share/gist.zsh" &
get_comp guix           "${GNU}/cgit/guix.git/plain/etc/completion/zsh/_guix" &
get_comp khal           "${GH}/pimutils/khal/master/misc/__khal" &
# Generate completions for present commands
gen_comp beet   'curl --silent "${GH}/beetbox/beets/master/extra/_beet" | sed s/awk/gawk/g' &
gen_comp cargo  'rustup completions zsh cargo' &
gen_comp poetry 'poetry completions zsh' &
gen_comp rclone 'rclone genautocomplete zsh /dev/stdout' &
gen_comp restic 'restic generate --zsh-completion /dev/stdout' &
gen_comp rustup 'rustup completions zsh rustup' &
# Generate completions for present commands
gen_zsh 'pipx --version >/dev/null && register-python-argcomplete pipx' &
gen_zsh 'pyenv init - --no-rehash' &
gen_zsh 'pip  completion --zsh' &
gen_zsh 'pip3 completion --zsh' &
gen_zsh 'dircolors --bourne-shell <(curl --silent "${GH}/trapd00r/LS_COLORS/master/LS_COLORS")' &
gen_zsh 'terraform version >/dev/null && <<<"complete -o nospace -C $(which terraform) terraform"' &
# Get binary files
get_bin pping       "${GH}/denilsonsa/prettyping/master/prettyping" &
get_bin git-foresta "${GH}/takaaki-kasai/git-foresta/master/git-foresta" &
wait
)


autoload -U +X bashcompinit
bashcompinit


for file in "${_ZPM}/sourceables"/*sh; do
    source "${file}"
done
source "/usr/share/bash-completion/completions/atool"


fpath+=(${_ZPM_COMP})
fpath+=(~/.zsh/completions/)
export PATH=${_ZPM_POL}/bin${PATH:+:}${PATH}


unset _ZPM
unset _ZPM_POL
unset _ZPM_COMP
unset _ZPM_SRC
unset GH
unset GNU
