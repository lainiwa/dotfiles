
# Lacking (compared to zplugin.zsh)
# * junegunn/fzf shell/{completion,key-bindings}.zsh
# * clean does not work?
# * make mdom/txtnish
# * Command-line online translator -- soimort/translate-shell


###################################
# SET VARIABLES
#
_ZPM=${XDG_CACHE_HOME:-${HOME}/.cache}/zpm
_ZPM_POL=${_ZPM}/polaris
_ZMP_REQ=${TMPDIR:-/tmp}/zsh-${UID}/requirements.zpm

_FETCH=${0:A:h}/other/fetch_file
GH="${_FETCH} https://raw.githubusercontent.com"
GNU="${_FETCH} https://git.savannah.gnu.org"
URL="${_FETCH} https:/"


###################################
# ENABLE BASH COMPLETIONS
#
autoload -U +X bashcompinit
bashcompinit


###################################
# INSTALL ZSH PLUGIN MANAGER
#
export _ZPM_DIR=${_ZPM}/zpm
export _ZPM_PLUGIN_DIR=${_ZPM}/plugins
if [[ ! -f ${_ZPM_DIR}/zpm.zsh ]]; then
    git clone --depth 1 https://github.com/zpm-zsh/zpm "${_ZPM_DIR}"
    mkdir -p -- "${_ZPM_POL}"/{bin,share/{doc,man/man{1..9}}}
fi


###################################
# SETUP PROMPT
#
# Python virtual environment name
AGKOZAK_CUSTOM_PROMPT='%(10V.%B%F{green}(%10v)%f%b.)'
# Username and hostname
AGKOZAK_CUSTOM_PROMPT+='%(!.%S%B.%B%F{yellow})%n%1v%(!.%b%s.%f%b) '
# Path
AGKOZAK_CUSTOM_PROMPT+=$'%B%F{green}%2v%f%b '
# Prompt character
AGKOZAK_CUSTOM_PROMPT+='%B%F{red}%(4V.:.%#)%f%b '
# Nnn file browser shell level
if [[ -n "${NNNLVL}" ]]; then
    AGKOZAK_CUSTOM_PROMPT="%F{cyan}N${NNNLVL}%f ${AGKOZAK_CUSTOM_PROMPT}"
fi
# Git status
AGKOZAK_CUSTOM_SYMBOLS=( '⇣⇡' '⇣' '⇡' '+' 'x' '!' '>' '?' 'S')
AGKOZAK_CUSTOM_RPROMPT='%(3V.%F{yellow}%3v%f.)'
# Exit status
AGKOZAK_CUSTOM_RPROMPT+=' %(?..%B%F{red}(%?%)%f%b)'
# Execution time
AGKOZAK_CMD_EXEC_TIME=1
AGKOZAK_CUSTOM_RPROMPT+=' %B%F{green}%9v%f%b'


###################################
# CONFIGURE OTHER PLUGINS
#
# Zsh-z configuration
export ZSHZ_DATA=${HOME}/.cache/.z
export ZSHZ_OWNER=${HOME:t}
export ZSHZ_NO_RESOLVE_SYMLINKS=1
export ZSHZ_MAX_SCORE=900000
# Gitcd configuration
export GITCD_HOME=${HOME}/tmp
export GITCD_TRIM=1
# Autosuggestions configuration
# export ZSH_AUTOSUGGEST_USE_ASYNC=1
export ZSH_AUTOSUGGEST_MANUAL_REBIND=1

export FORGIT_NO_ALIASES=1


source "${0:A:h}/other/zpm_functions.zsh"


if [[ ! ${_ZMP_REQ} -nt ${0}
   || ! ${_ZMP_REQ} -nt ${0:A:h}/other/zpm_functions.zsh ]]; then
    echo "Resetting ZPM cache..."
    rm -rf -- "${_ZMP_REQ:h}"
    mkdir -p -- "${_ZMP_REQ:h}"
    requirements > "${_ZMP_REQ}"
fi
source "${_ZPM_DIR}/zpm.zsh"
zpm load "${(@f)"$(<"${_ZMP_REQ}")"}"


###################################
# CONFIGURE HISTORY
#
# If history is stored in sqlite - adjust Ctrl+R and autosuggestions
if (( ${+functions[_histdb_query]} )); then
    zle     -N   histdb-fzf-widget
    bindkey '^R' histdb-fzf-widget
    ZSH_AUTOSUGGEST_STRATEGY=histdb_last_command
fi


(
# Get binary files
get_bin cht.sh      "${URL}/cht.sh/:cht.sh" &
get_bin pping       "${GH}/denilsonsa/prettyping/master/prettyping" &
get_bin git-foresta "${GH}/takaaki-kasai/git-foresta/master/git-foresta" &
wait
)


###################################
# CREATE LINKS AND ALIASES
#
link_bin merge /opt/sublime_merge/sublime_merge
link_bin vim   nvim
alias cht='cht.sh'


fpath+=("${0:A:h}/completions/")
export PATH=${_ZPM_POL}/bin${PATH:+:}${PATH}


###################################
# UNSET VARIABLES
#
unset _ZPM
unset _ZPM_POL
unset _ZMP_REQ

unset _FETCH
unset GH
unset GNU
unset URL
