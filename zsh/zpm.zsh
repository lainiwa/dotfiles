
# Lacking (compared to zplugin.zsh)
# * junegunn/fzf shell/{completion,key-bindings}.zsh
# * clean does not work?
# * make mdom/txtnish
# * Command-line online translator -- soimort/translate-shell


_ZPM=${XDG_CACHE_HOME:-${HOME}/.cache}/zpm
_ZPM_POL=${_ZPM}/polaris
_ZPM_COMP=${_ZPM}/completions
_ZPM_SRC=${_ZPM}/sourceables
_ZMP_REQ=${TMPDIR:-/tmp}/zsh-${UID}/requirements.zpm
GH='curl --silent https://raw.githubusercontent.com'
GNU='curl --silent https://git.savannah.gnu.org'


autoload -U +X bashcompinit
bashcompinit


# Install ZSH Plugin Manager
export _ZPM_DIR=${_ZPM}/zpm
export _ZPM_PLUGIN_DIR=${_ZPM}/plugins
if [[ ! -f ${_ZPM_DIR}/zpm.zsh ]]; then
    git clone --depth 1 https://github.com/zpm-zsh/zpm "${_ZPM_DIR}"
    mkdir -p -- "${_ZPM_POL}"/{bin,share/{doc,man/man{1..9}}}
    mkdir -p -- "${_ZPM_COMP}"
    mkdir -p -- "${_ZPM_COMP}"
    mkdir -p -- "${_ZPM_SRC}"
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
# Autosuggestions configuration
# export ZSH_AUTOSUGGEST_USE_ASYNC=1
export ZSH_AUTOSUGGEST_MANUAL_REBIND=1
# Notes configuration
export QUICKNOTE_FORMAT="%Y-%m-%d"
export NOTES_EXT="md"
export NOTES_DIRECTORY=~/notes


requirements() {
    # Prompt
    <<< romkatv/zsh-prompt-benchmark
    <<< agkozak/agkozak-zsh-prompt
    # Z
    <<< agkozak/zsh-z
    <<< andrewferrier/fzf-z
    # Rename tmux pane to current folder's basename
    <<< trystan2k/zsh-tab-title
    # Toggles `sudo` for current/previous command on ESC-ESC.
    <<< hcgraf/zsh-sudo
    # Run `fg` on C-Z
    <<< mdumitru/fancy-ctrl-z
    # ZPM plugins
    <<< zpm-zsh/clipboard
    <<< zpm-zsh/undollar
    # My plugins
    <<< lainiwa/gitcd
    <<< lainiwa/ph-marks
    # Git related
    # <<< paulirish/git-open
    <<< zdharma/zsh-diff-so-fancy
    # Completions
    <<< zpm-zsh/zsh-completions,apply:fpath
    <<< zchee/zsh-completions
    <<< srijanshetty/zsh-pandoc-completion
    <<< bobthecow/git-flow-completion
    <<< spwhitt/nix-zsh-completions
    <<< nojanath/ansible-zsh-completion
    <<< lukechilds/zsh-better-npm-completion
    # Get gitignore template with `gi` command
    <<< voronkovich/gitignore.plugin.zsh
    # Heavy stuff
    <<< zdharma/history-search-multi-word,fpath:/
    <<< zdharma/fast-syntax-highlighting
    <<< zsh-users/zsh-autosuggestions,source:zsh-autosuggestions.zsh
    # Substitute `...` with `../..`
    <<< lainiwa/zsh-manydots-magic,source:manydots-magic
    # Non-plugins
    <<< dylanaraps/fff,hook:"make; PREFIX=${_ZPM_POL} make install"
    <<< nvie/gitflow,hook:"make install prefix=${_ZPM_POL}"
    <<< circulosmeos/gdown.pl,hook:"cp gdown.pl ${_ZPM_POL}/bin/gdown"
    <<< snipem/v,hook:"PREFIX=${_ZPM_POL} make install"
    <<< gitbits/git-info,hook:"cp git-* ${_ZPM_POL}/bin/"
    <<< greymd/tmux-xpanes,hook:"./install.sh '${_ZPM_POL}'",apply:fpath,fpath:/completion/zsh
    <<< pimterry/notes,hook:"PREFIX=${_ZPM_POL} make -f <(sed 's|^\(BASH_COMPLETION_DIR\).*|\1 = /tmp|' Makefile)"
    #
    # AdrieanKhisbe/diractions
    # michaelxmcbride/zsh-dircycle
    <<< rustup,type:mkdir,gen-comp:"rustup completions zsh rustup"
    <<<  cargo,type:mkdir,gen-comp:"rustup completions zsh cargo"
    <<< poetry,type:mkdir,gen-comp:"poetry completions zsh"
    <<< rclone,type:mkdir,gen-comp:"rclone genautocomplete zsh /dev/stdout"
    <<< restic,type:mkdir,gen-comp:"restic generate --zsh-completion /dev/stdout"
    <<<   beet,type:mkdir,gen-comp:"${GH}/beetbox/beets/master/extra/_beet | sed s/awk/gawk/g"

    <<<           beet,type:mkdir,gen-comp:"${GH}/beetbox/beets/master/extra/_beet"
    <<<           buku,type:mkdir,gen-comp:"${GH}/jarun/Buku/master/auto-completion/zsh/_buku"
    <<< docker-compose,type:mkdir,gen-comp:"${GH}/docker/compose/master/contrib/completion/zsh/_docker-compose"
    <<<            exa,type:mkdir,gen-comp:"${GH}/ogham/exa/master/contrib/completions.zsh"
    <<<         ffsend,type:mkdir,gen-comp:"${GH}/timvisee/ffsend/master/contrib/completions/_ffsend"
    <<<           gist,type:mkdir,gen-comp:"${GH}/jdowner/gist/alpha/share/gist.zsh"
    <<<           guix,type:mkdir,gen-comp:"${GNU}/cgit/guix.git/plain/etc/completion/zsh/_guix"
    <<<           khal,type:mkdir,gen-comp:"${GH}/pimutils/khal/master/misc/__khal"

    (( ${+commands[dircolors]} )) && <<< dircolors,type:mkdir,gen-pl:"dircolors --bourne-shell <(${GH}/trapd00r/LS_COLORS/master/LS_COLORS)"
    (( ${+commands[pip]}       )) && <<<       pip,type:mkdir,gen-pl:"pip completion --zsh"
    (( ${+commands[pip3]}      )) && <<<      pip3,type:mkdir,gen-pl:"pip3 completion --zsh"
    (( ${+commands[pyenv]}     )) && <<<     pyenv,type:mkdir,gen-pl:"pyenv init - --no-rehash"
    (( ${+commands[kubectl]}   )) && <<<   kubectl,type:mkdir,gen-pl:"kubectl completion zsh"

    (( ${+commands[register-python-argcomplete]} && ${+commands[pipx]} )) &&
        <<< pipx,type:mkdir,gen-pl:"register-python-argcomplete pipx"
    <<< terraform,type:mkdir,gen-pl:"<<<'complete -o nospace -C $(which terraform) terraform'"
}


if [[ ! /tmp/zsh-1000/requirements.zpm -nt ~/.zsh/zpm.zsh ]]; then
    echo "Resetting ZPM cache..."
    rm -rf /tmp/zsh-1000
    mkdir -p -- "${_ZMP_REQ:h}"
    requirements > "${_ZMP_REQ}"
fi


source "${_ZPM_DIR}/zpm.zsh"
zpm load "${(@f)"$(<"${_ZMP_REQ}")"}"


get_bin() {
    local name=${1}
    local url=${2}
    if [[ ! -f ${_ZPM_POL}/bin/${name} ]]; then
        wget --quiet "${url}" --output-document="${_ZPM_POL}/bin/${name}"
        chmod +x "${_ZPM_POL}/bin/${name}"
        echo "${c[bold]}${c[green]}Download" \
             "${c[blue]}${name}" \
             "${c[green]}✔" \
             "${c[reset]}"
    fi
}


(
# Get binary files
get_bin pping       "${GH}/denilsonsa/prettyping/master/prettyping" &
get_bin git-foresta "${GH}/takaaki-kasai/git-foresta/master/git-foresta" &
wait
)


fpath+=(${_ZPM_COMP})
fpath+=(~/.zsh/completions/)
export PATH=${_ZPM_POL}/bin${PATH:+:}${PATH}


unset _ZPM
unset _ZPM_POL
unset _ZPM_COMP
unset _ZPM_SRC
unset _ZMP_REQ
unset GH
unset GNU
