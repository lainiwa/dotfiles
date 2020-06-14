

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
    if [[ ! -f "${ZINIT[BIN_DIR]}/zmodules/config.log" ]]; then
        zinit module build
    fi

else
    # Load zinit's binary module (`zpmod -h` for help)
    module_path+=( "${ZINIT[BIN_DIR]}/zmodules/Src" )
    zmodload zdharma/zplugin

fi


# Add zinit extensions
zinit load zinit-zsh/z-a-bin-gem-node  # for managing "shims"
zinit load zinit-zsh/z-a-patch-dl  # for downloading files and applying patches
# zinit load zinit-zsh/z-a-test  # for running tests on plugin load
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

# fzf binary only
zinit ice from"gh-r" sbin"fzf" id-as"junegunn/fzf_bin"
zinit load junegunn/fzf-bin

# fzf-tmux script, completions for many programs (e.g. kill <TAB>)
# key bindings and man pages
zinit ice multisrc"shell/{completion,key-bindings}.zsh" \
    pick"/dev/null" \
    sbin"bin/fzf-tmux" atpull'%atclone' \
    atclone"cp man/man1/* ${ZPFX}/share/man/man1/"
zinit load junegunn/fzf

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

# Install perl scripts
# * diff-so-fancy and git-dsf commands
# * gdown - downloader for google drive
#
zinit as'command' for \
    pick"bin/git-dsf" zdharma/zsh-diff-so-fancy \
    mv'gdown.pl -> gdown' pick'gdown' circulosmeos/gdown.pl



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
# zinit ice from"gh-r" if"${is_linux}" as"command" for \
#     bpick"^broot_*.zip$" mv"build/x86_64-linux/broot -> broot"
# zinit load Canop/broot

# Fetch binaries when on linux
# * ffsend - CLI Firefox Send client
# * grv    - git curses interface
# * bat    - substitution for cat
#
# zinit from"gh-r" if"${is_linux}" as'command' for \
#     bpick"^ffsend-v*-linux-x64-static$" mv"ffsend-v* -> ffsend" timvisee/ffsend \
#     bpick"^grv_v*_linux64$"             mv"grv_v* -> grv"       rgburke/grv \
#     bpick"bat-v*-x86_64-unknown-linux-gnu.tar.gz" mv'bat-*/bat -> bat' \
#         pick'bat' atload"alias cat=bat" @sharkdp/bat


# # Install timelapse screen recorder
# zinit ice from"gh-r" mv'tl-* -> tl' fbin'tl' has'X'
# zinit load ryanmjacobs/tl
# zinit ice has'X' atpull'%atclone' \
#     atclone"cp src/*.1 ${ZPFX}/share/man/man1/" \
#     id-as"ryanmjacobs/tl_man" pick"/dev/null"
# zinit load ryanmjacobs/tl


# Install
# * git-flow - git subcommand
# * txtnish  - twtxt client (zinit automatically installs completions/_txtnish)
# * fff      - file manager
#
zinit as"null" for \
    make"install prefix=${ZPFX}" nvie/gitflow \
    make"PREFIX=${ZPFX}"         mdom/txtnish \
    make"PREFIX=${ZPFX} install" dylanaraps/fff


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


# ZPM ecosystem plugins
# * clipboard - adds `pbcopy`, `pbpaste` and `clip` commands
# * undollar - strip `^$\ ` from command
#
zinit for \
    zpm-zsh/clipboard \
    zpm-zsh/undollar

# My own plugins
# * gitcd    - git clone && cd
# * ph-marks - pornhub bookmarks manager
#
export GITCD_HOME=${HOME}/tmp
export GITCD_TRIM=1
zinit for lainiwa/gitcd
zinit for lainiwa/ph-marks

# Rename tmux pane to current folder's basename
zinit load trystan2k/zsh-tab-title

# Add command-line online translator
zinit ice has"gawk"
zinit load soimort/translate-shell

# Toggles "sudo" before the current/previous command by pressing ESC-ESC.
zinit load hcgraf/zsh-sudo

# Run `fg` command to return to foregrounded (Ctrl+Z'd) vim
zinit load mdumitru/fancy-ctrl-z

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

# Colorize ls/exa output based on file type
zinit pack for ls_colors


#################################################################
# COMPLETIONS FOR ALREADY INSTALLED BINARIES
#
autoload -U +X bashcompinit
bashcompinit

# Generate completions for
# * pyenv     - python version management script
# * poetry    - python package manager
# * cargo     - rust package manager
# * rustup    - rust toolchain installer
# * restic    - backup tool
# * pipx      - tool for installing isolated python packages
# * terraform - cloud infrastructure management tool
# * rclone    - rsync for the cloud (we check if genautocomplete subcommand is available)
#
zinit atpull'%atclone' for \
    has'pyenv'  id-as'pyenv'  atclone"pyenv init - --no-rehash         > pyenv.plugin.zsh"    zdharma/null \
    has'poetry' id-as'poetry' atclone"poetry completions zsh           > _poetry"             zdharma/null \
    has'rustup' id-as'cargo'  atclone"rustup completions zsh cargo     > _cargo"              zdharma/null \
    has'rustup' id-as'rustup' atclone"rustup completions zsh cargo     > _rustup"             zdharma/null \
    has'restic' id-as'restic' atclone"restic generate --zsh-completion   _restic"             zdharma/null \
    has'pipx'   id-as'pipx'   atclone"register-python-argcomplete pipx > pipx.plugin.zsh" \
        has'register-python-argcomplete' zdharma/null \
    has'terraform' id-as'terraform' \
        atclone'<<<"complete -o nospace -C $(which terraform) terraform" > terraform.plugin.zsh' zdharma/null \
    has'rclone' id-as'rclone' atclone"rclone genautocomplete zsh         _rclone" \
        if"rclone genautocomplete zsh --help | grep -q 'rclone genautocomplete zsh'" zdharma/null

# Download completions for
# * docker-compose
# * ffsend - CLI Firefox Send client
# * buku - bookmarks manager
# * guix - declarative package manager
# * exa  - ls substitution
# * gist - github gist client
# * khal - CLI calendar
# * beet - music organizer  # TODO: check has gawk
#
GH=https://raw.githubusercontent.com
GNU=https://git.savannah.gnu.org
zinit as'completion' atpull'%atclone' for \
    has'docker-compose' "${GH}/docker/compose/master/contrib/completion/zsh/_docker-compose" \
    has'ffsend'         "${GH}/timvisee/ffsend/master/contrib/completions/_ffsend" \
    has'buku'           "${GH}/jarun/Buku/master/auto-completion/zsh/_buku" \
    has'guix' "${GNU}/cgit/guix.git/plain/etc/completion/zsh/_guix" \
    has'exa'  mv'* -> _exa'  "${GH}/ogham/exa/master/contrib/completions.zsh" \
    has'gist' mv'* -> _gist' "${GH}/jdowner/gist/alpha/share/gist.zsh" \
    has'khal' mv'* -> _khal' "${GH}/pimutils/khal/master/misc/__khal" \
    has'beet' atclone"perl -pi -e 's/awk/gawk/g' _beet" \
        "${GH}/beetbox/beets/master/extra/_beet"
unset GH GNU

# Completions for
# * git-flow
# * nix package manager
# * ansible
#
zinit for \
    has'git-flow' bobthecow/git-flow-completion \
    has'nix'      spwhitt/nix-zsh-completions \
    has'ansible'  nojanath/ansible-zsh-completion


#################################################################
# IMPORTANT PLUGINS
#

# Additional completion definitions
zinit ice blockf atclone'zinit creinstall -q .' atpull'%atclone'
zinit load zsh-users/zsh-completions

# History search by `Ctrl+R`
zinit load zdharma/history-search-multi-word

# Syntax highlighting
zinit ice atinit"zpcompinit; zpcdreplay"
zinit load zdharma/fast-syntax-highlighting

# # Autosuggestions
# export ZSH_AUTOSUGGEST_USE_ASYNC=1
export ZSH_AUTOSUGGEST_MANUAL_REBIND=1
zinit ice blockf atload'!_zsh_autosuggest_start'
zinit load zsh-users/zsh-autosuggestions


# `...` ==> `../..`
# zinit ice lucid wait"0b" pick"manydots-magic"
zinit load lainiwa/zsh-manydots-magic
