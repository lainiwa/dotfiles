

#################################################################
# INSTALL zinit AND LOAD IT
#

# Install zinit if not installed
if [[ ! -f ${HOME}/.zinit/bin/zinit.zsh ]]; then
    mkdir --parents "${HOME}/.zinit"
    git clone "https://github.com/zdharma/zinit" "${HOME}/.zinit/bin"
    mkdir --parents "${HOME}/.zinit/polaris/share/man/man"{1,2,3,4,5,6,7,8,9}
fi

# Setup and load zinit
declare -A ZINIT
ZINIT[ZCOMPDUMP_PATH]="${HOME}/.cache/zinit/.zcompdump"
ZINIT[COMPINIT_OPTS]='-i'  # without `-i` spawns warning on `sudo -s`
source "${HOME}/.zinit/bin/zinit.zsh"

# Compile the zinit`s binary module, if not yet compiled
if [[ ! -f "${ZINIT[BIN_DIR]}/zmodules/Src/zdharma/zplugin.so" ]]; then
    zinit module build
fi

# Load zinit's binary module (`zpmod -h` for help)
module_path+=( "${ZINIT[BIN_DIR]}/zmodules/Src" )
zmodload zdharma/zplugin

# Add zinit extensions
zinit load zinit-zsh/z-a-bin-gem-node  # for managing "shims"
zinit load zinit-zsh/z-a-patch-dl  # for downloading files and applying patches
zinit load zinit-zsh/z-a-test  # for running tests on plugin load
# zstyle :zinit:annex:test quiet 0  # run the tests in a verbose mode

[[ ${OSTYPE} == *linux* ]] && is_linux=true || is_linux=false


#################################################################
# PROMPT SETTINGS
#
# This settings are applied immidiately (because we need to show
# prompt as fast as possible), so the plugins are being loaded
# eagerly.
#

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

zinit load romkatv/zsh-prompt-benchmark
zinit load agkozak/agkozak-zsh-prompt


#################################################################
# FUZZY SEARCH AND MOVEMENT
#
# * fzf   - a fuzzy picker
# * z     - fast movement through directories
# * fzf-z - pick a recent directory (fzf+z)
# * v     - fast open in vim
#

zplugin pack"binary+keys" for fzf

# Pure zsh port of rupa/z
export ZSHZ_DATA=${HOME}/.cache/.z
export ZSHZ_OWNER=${HOME:t}
zinit load agkozak/zsh-z

# Pick from most frecent folders with `Ctrl+g`
# Relies on z script
zinit load andrewferrier/fzf-z

# Fast open file in vim
zinit ice has'bash' fbin"v" atpull'%atclone' \
    atclone"cp *.1 ${ZPFX}/share/man/man1/"
zinit load rupa/v


#################################################################
# INSTALL NON-PLUGIN COMMANDS
#

# # Gdown - downloader for google drive
# zinit ice as'command' mv'gdown.pl -> gdown' pick'gdown'
# zinit load circulosmeos/gdown.pl

# # Substitute cat with bat
# zinit ice if"${is_linux}" \
#     from"gh-r" bpick"bat-v*-x86_64-unknown-linux-gnu*" \
#     sbin"bat" \
#     mv'bat-*/bat -> bat' \
#     atload"alias cat=bat"
# zinit load sharkdp/bat

# # Hub - a command to work with github + alias + completions + man
# zinit ice if"${is_linux}" from"gh-r" bpick"hub-linux-amd64*" atpull'%atclone' \
#     atclone"
#         cd hub-* &&
#         PREFIX=${ZPFX} ./install
#     " \
#     mv"hub-*/etc/hub.zsh_completion -> _hub" \
#     as"completion" pick"_hub" \
#     atload"alias git=hub"
# zinit load github/hub

# # Broot aka br - a tree file viewer
# zinit ice if"${is_linux}" from"gh-r" bpick"broot" fbin"broot -> br"
# zinit load Canop/broot

# Install `ffsend` (a Firefox Send client) statically-linked binary
zinit ice if"${is_linux}" \
    from"gh-r" bpick"^ffsend-v*-linux-x64-static$" \
    mv"ffsend-v* -> ffsend" fbin"ffsend"
zinit load timvisee/ffsend

# # Install timelapse screen recorder
# zinit ice from"gh-r" mv'tl-* -> tl' fbin'tl' has'X'
# zinit load ryanmjacobs/tl
# zinit ice has'X' atpull'%atclone' \
#     atclone"cp src/*.1 ${ZPFX}/share/man/man1/" \
#     id-as"ryanmjacobs/tl_man" pick"/dev/null"
# zinit load ryanmjacobs/tl

# # Git curses interface
# zinit ice as'command' if"${is_linux}" \
#     from"gh-r" bpick"^grv_v*_linux64$" mv"grv_v* -> grv"
# zinit load rgburke/grv

# Install twtxt (zinit automatically installs completions/_txtnish)
zinit ice as"command" make"PREFIX=${ZPFX}"
zinit load mdom/txtnish

# Install fff and it's man page
zinit ice as"command" make"PREFIX=${ZPFX} install"
zinit load dylanaraps/fff


#################################################################
# INSTALL `k` COMMAND AND GENERATE COMPLITIONS
#
# zload RobSis/zsh-completion-generator

# zinit ice atload"gencomp k"
# zload supercrabtree/k

# # alias l='k -h'


#################################################################
# OTHER PLUGINS
#

# Rename tmux pane to current folder's basename
zinit load trystan2k/zsh-tab-title

# Add `git dsf` command to git
zinit ice has"git" as"program" pick"bin/git-dsf"
zinit load zdharma/zsh-diff-so-fancy

# Add command-line online translator
zinit ice has"gawk"
zinit load soimort/translate-shell

# Toggles "sudo" before the current/previous command by pressing ESC-ESC.
zinit load hcgraf/zsh-sudo

# Run `fg` command to return to foregrounded (Ctrl+Z'd) vim
zinit load mdumitru/fancy-ctrl-z

# Install gitcd function to clone git repository and cd into it
export GITCD_HOME=${HOME}/tmp
export GITCD_TRIM=1
zinit load lainiwa/gitcd

# Adds `git open`
zinit load paulirish/git-open

# Get gitignore template with `gi` command
zinit load voronkovich/gitignore.plugin.zsh

# Git-extras
# zinit ice as"program" \
#     pick"${ZPFX}/bin/git-*" make"PREFIX=${ZPFX}"
# zinit load tj/git-extras

# zinit ice as'completion' src"etc/git-extras-completion.zsh" id-as"extracomp"
# zinit load tj/git-extras

# zinit ice pick"git-extras-completion.zsh"
# zinit snippet 'https://raw.githubusercontent.com/tj/git-extras/master/etc/git-extras-completion.zsh'

# Gitflow commands and completions
zinit ice as"command" make"install prefix=${ZPFX}"
zinit load nvie/gitflow
zinit load bobthecow/git-flow-completion

# Colorize ls/exa output based on file type
zinit pack for ls_colors


#################################################################
# COMPLETIONS FOR ALREADY INSTALLED BINARIES
#

# zinit atpull'%atclone' for
#     atclone"pyenv init - --no-rehash > pyenv.plugin.zsh" zdharma/null

# Install completions for pyenv, if present in $PATH
zinit ice has'pyenv' id-as'pyenv' atpull'%atclone' \
    atclone"pyenv init - --no-rehash > pyenv.plugin.zsh"
zinit load zdharma/null

# Completions for rclone
# (zsh completions available only from older vertsions)
zinit ice has'rclone' id-as'rclone' \
    if"rclone genautocomplete zsh --help | grep -q 'rclone genautocomplete zsh'" \
    blockf atpull'%atclone' \
    atclone"
        mkdir src/ &&
        rclone genautocomplete zsh src/_rclone &&
        echo fpath+=\"\${0:h}/src\" > rclone.plugin.zsh &&
    "
zinit load zdharma/null

# Install completions for poetry, if present in $PATH
zinit ice has'poetry' id-as'poetry' \
    blockf atpull'%atclone' \
    atclone"
        mkdir src/ &&
        poetry completions zsh > src/_poetry &&
        echo fpath+=\"\${0:h}/src\" > poetry.plugin.zsh &&
    "
zinit load zdharma/null

# Install completions for rustup and cargo, if rustup is in $PATH
zinit ice has'rustup' id-as'rustup' \
    blockf atpull'%atclone' \
    atclone"
        mkdir src/ &&
        rustup completions zsh cargo > src/_cargo &&
        rustup completions zsh rustup > src/_rustup &&
        echo fpath+=\"\${0:h}/src\" > rustup.plugin.zsh &&
    "
zinit load zdharma/null

# zinit ice as'completion'  atpull'%atclone' \
#     atclone"
#         zinit creinstall -q %SNIPPETS/https--raw.githubusercontent.com--jdowner--gist--alpha--share/gist.zsh
#     "
# zinit snippet ''


GH=https://raw.githubusercontent.com
GNU=https://git.savannah.gnu.org

# Completions for
# * docker-compose
# * ffsend - CLI Firefox Send client
# * buku - bookmarks manager
# * guix - declarative package manager
# * exa  - ls substitution
# * gist - github gist client
# * khal - CLI calendar
# * beet - music organizer  # TODO: check has gawk
#
zinit as'completion' atpull'%atclone' for \
    has'docker-compose' "${GH}/docker/compose/master/contrib/completion/zsh/_docker-compose" \
    has'ffsend'         "${GH}/timvisee/ffsend/master/contrib/completions/_ffsend" \
    has'buku'           "${GH}/jarun/Buku/master/auto-completion/zsh/_buku" \
    has'guix' "${GNU}/cgit/guix.git/plain/etc/completion/zsh/_guix" \
    has'exa'  mv'* -> _exa'  "${GH}/ogham/exa/master/contrib/completions.zsh" \
    has'gist' mv'* -> _gist' "${GH}/jdowner/gist/alpha/share/gist.zsh" \
    has'khal' mv'* -> _khal' "${GH}/pimutils/khal/master/misc/__khal" \
    has'beet' atclone'perl -pi -e 's/awk/gawk/g' _beet' \
        "${GH}/beetbox/beets/master/extra/_beet"

# Install Nix package manager completions
zinit ice has'nix'
zinit load spwhitt/nix-zsh-completions


#################################################################
# IMPORTANT PLUGINS
#

zinit pack for system-completions

# Additional completion definitions
zinit ice blockf atclone'zinit creinstall -q .' atpull'%atclone'
zinit load zsh-users/zsh-completions

# History search by `Ctrl+R`
zinit load zdharma/history-search-multi-word

# Autosuggestions
export ZSH_AUTOSUGGEST_USE_ASYNC=1
export ZSH_AUTOSUGGEST_MANUAL_REBIND=1
zinit ice atload'_zsh_autosuggest_start'
zinit load zsh-users/zsh-autosuggestions

# Syntax highlighting
zinit ice wait'0' lucid atinit"zpcompinit; zpcdreplay"
zinit load zdharma/fast-syntax-highlighting

# `...` ==> `../..`
zinit ice lucid wait"0b" pick"manydots-magic"
zinit load knu/zsh-manydots-magic
