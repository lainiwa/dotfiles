
# Lacking (compared to zplugin.zsh)
# * junegunn/fzf shell/{completion,key-bindings}.zsh
# * clean does not work?
# * make mdom/txtnish
# * Command-line online translator -- soimort/translate-shell


_ZPM=${XDG_CACHE_HOME:-${HOME}/.cache}/zpm
_ZPM_POL=${_ZPM}/polaris
_ZMP_REQ=${TMPDIR:-/tmp}/zsh-${UID}/requirements.zpm

if (( ${+commands[wget]} )); then
    _FETCH="wget --quiet --output-document -"
else
    _FETCH="curl --silent --location"
fi

GH="${_FETCH} https://raw.githubusercontent.com"
GNU="${_FETCH} https://git.savannah.gnu.org"
URL="${_FETCH} https:/"

autoload -U +X bashcompinit
bashcompinit


# Install ZSH Plugin Manager
export _ZPM_DIR=${_ZPM}/zpm
export _ZPM_PLUGIN_DIR=${_ZPM}/plugins
if [[ ! -f ${_ZPM_DIR}/zpm.zsh ]]; then
    git clone --depth 1 https://github.com/zpm-zsh/zpm "${_ZPM_DIR}"
    mkdir -p -- "${_ZPM_POL}"/{bin,share/{doc,man/man{1..9}}}
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


get_gh_url() {
    eval "${_FETCH} https://api.github.com/repos/${1}/releases/latest" |
        jq --raw-output "
            [.assets[] | .browser_download_url]
          + [.tarball_url, .zipball_url]         | .[]
        " |
        grep "${2}"
}


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
    <<< zsh-users/zsh-completions
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
    <<< zdharma/fast-syntax-highlighting,fpath:/→chroma
    <<< zsh-users/zsh-autosuggestions,source:zsh-autosuggestions.zsh
    # Substitute `...` with `../..`
    (( ${+commands[awk]} )) <<< lainiwa/zsh-manydots-magic,source:manydots-magic
    # Non-plugins
    (( ${+commands[make]} )) &&  <<< dylanaraps/fff,hook:"make; PREFIX=${_ZPM_POL} make install"
    (( ${+commands[make]} )) &&  <<<   nvie/gitflow,hook:"make install prefix=${_ZPM_POL}"
    (( ${+commands[make]} )) &&  <<<       snipem/v,hook:"PREFIX=${_ZPM_POL} make install"
     <<< circulosmeos/gdown.pl,hook:"cp gdown.pl ${_ZPM_POL}/bin/gdown"
     <<<      gitbits/git-info,hook:"cp git-*    ${_ZPM_POL}/bin/"
     <<<    lainiwa/tmux-xpanes,hook:"./install.sh '${_ZPM_POL}'",apply:fpath,fpath:/completion/zsh
    # Generate completions
    (( ${+commands[rustup]} )) && <<< rustup,type:empty,gen-completion:"rustup completions zsh rustup"
    (( ${+commands[rustup]} )) && <<<  cargo,type:empty,gen-completion:"rustup completions zsh cargo"
    (( ${+commands[poetry]} )) && <<< poetry,type:empty,gen-completion:"poetry completions zsh"
    (( ${+commands[rclone]} )) && <<< rclone,type:empty,gen-completion:"rclone genautocomplete zsh /dev/stdout"
    (( ${+commands[restic]} )) && <<< restic,type:empty,gen-completion:"restic generate --zsh-completion /dev/stdout"
    (( ${+commands[beet]} && ${+commands[gawk]} )) &&
        <<<   beet,type:empty,gen-completion:"${GH}/beetbox/beets/master/extra/_beet | sed s/awk/gawk/g"
    # Download completions
    <<<           beet,type:empty,gen-completion:"${GH}/beetbox/beets/master/extra/_beet"
    <<<           buku,type:empty,gen-completion:"${GH}/jarun/Buku/master/auto-completion/zsh/_buku"
    <<<            cht,type:empty,gen-completion:"${URL}/cheat.sh/:zsh"
    <<<            nnn,type:empty,gen-completion:"${GH}/jarun/nnn/master/misc/auto-completion/zsh/_nnn"
    <<< docker-compose,type:empty,gen-completion:"${GH}/docker/compose/master/contrib/completion/zsh/_docker-compose"
    <<<            exa,type:empty,gen-completion:"${GH}/ogham/exa/master/contrib/completions.zsh"
    <<<         ffsend,type:empty,gen-completion:"${GH}/timvisee/ffsend/master/contrib/completions/_ffsend"
    <<<           gist,type:empty,gen-completion:"${GH}/jdowner/gist/alpha/share/gist.zsh"
    <<<           guix,type:empty,gen-completion:"${GNU}/cgit/guix.git/plain/etc/completion/zsh/_guix"
    <<<           khal,type:empty,gen-completion:"${GH}/pimutils/khal/master/misc/__khal"
    # Generate sourceables
    (( ${+commands[brew]}          )) && <<< linuxbrew,type:empty,gen-plugin:"brew shellenv; <<<'FPATH=$(brew --prefix)/share/zsh/site-functions:\${FPATH}'"
    (( ${+commands[aws_completer]} )) && <<<       aws,type:empty,gen-plugin:"<<<'complete -C $(which aws_completer) aws'"
    (( ${+commands[dircolors]}     )) && <<< dircolors,type:empty,gen-plugin:"dircolors --bourne-shell <(${GH}/trapd00r/LS_COLORS/master/LS_COLORS)"
    (( ${+commands[pip]}           )) && <<<       pip,type:empty,gen-plugin:"pip completion --zsh"
    (( ${+commands[pip3]}          )) && <<<      pip3,type:empty,gen-plugin:"pip3 completion --zsh"
    (( ${+commands[pyenv]}         )) && <<<     pyenv,type:empty,gen-plugin:"pyenv init - --no-rehash"
    (( ${+commands[kubectl]}       )) && <<<   kubectl,type:empty,gen-plugin:"kubectl completion zsh"
    (( ${+commands[terraform]}     )) && <<< terraform,type:empty,gen-plugin:"<<<'complete -o nospace -C $(which terraform) terraform'"
    (( ${+commands[register-python-argcomplete]} && ${+commands[pipx]} )) &&
        <<< pipx,type:empty,gen-plugin:"register-python-argcomplete pipx"
    # Fetch releases from Github
    if (( ${+commands[jq]} && ${+commands[tar]} )); then
        _glow=$( get_gh_url charmbracelet/glow 'linux_x86_64.tar.gz$')
        _micro=$(get_gh_url zyedidia/micro     'linux64-static.tar.gz$')
        <<<  glow,type:empty,hook:"${_FETCH} ${_glow}  | tar -xzf-; cp glow    ${_ZPM_POL}/bin/"
        <<< micro,type:empty,hook:"${_FETCH} ${_micro} | tar -xzf-; cp */micro ${_ZPM_POL}/bin/"
    fi
}


if [[ ! ${_ZMP_REQ} -nt ${0} ]]; then
    echo "Resetting ZPM cache..."
    rm -rf "${_ZMP_REQ:h}"
    mkdir -p -- "${_ZMP_REQ:h}"
    requirements > "${_ZMP_REQ}"
fi


source "${_ZPM_DIR}/zpm.zsh"
zpm load "${(@f)"$(<"${_ZMP_REQ}")"}"


get_bin() {
    local name=${1}
    local cmd=${2}
    if [[ ! -f ${_ZPM_POL}/bin/${name} ]]; then
        eval "${cmd}" > "${_ZPM_POL}/bin/${name}"
        chmod +x "${_ZPM_POL}/bin/${name}"
        echo "${c[bold]}${c[green]}Download" \
             "${c[blue]}${name}" \
             "${c[green]}✔" \
             "${c[reset]}"
    fi
}


link_bin() {
    local name=${1}
    local binary
    binary=$(command -v "${2}")
    if [[ ! -f ${_ZPM_POL}/bin/${name} && -f ${binary} ]]; then
        ln -s "${binary}" "${_ZPM_POL}/bin/${name}"
        echo "${c[bold]}${c[green]}Linking" \
             "${c[blue]}${name} -> ${binary}" \
             "${c[green]}✔" \
             "${c[reset]}"
    fi
}


(
# Get binary files
get_bin cht.sh      "${URL}/cht.sh/:cht.sh" &
get_bin pping       "${GH}/denilsonsa/prettyping/master/prettyping" &
get_bin git-foresta "${GH}/takaaki-kasai/git-foresta/master/git-foresta" &
wait
)


# Create links
link_bin merge /opt/sublime_merge/sublime_merge
link_bin vim   nvim
# and aliases
alias cht='cht.sh'


fpath+=(~/.zsh/completions/)
export PATH=${_ZPM_POL}/bin${PATH:+:}${PATH}


unset _ZPM
unset _ZPM_POL
unset _ZMP_REQ
unset GH
unset GNU
