

#################################################################
# INSTALL zplugin AND LOAD IT
#

# Install zplugin if not installed
if [ ! -d "${HOME}/.zplugin" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"
    zplugin self-update
fi

# Load zplugin
source "${HOME}/.zplugin/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

# Compile the zplugin`s binary module, if not yet compiled
if [[ ! -f "${ZPLGM[BIN_DIR]}/zmodules/Src/zdharma/zplugin.so" ]]; then
    zplugin module build
fi

# Load zplugin's binary module (`zpmod -h` for help)
module_path+=( "${ZPLGM[BIN_DIR]}/zmodules/Src" )
zmodload zdharma/zplugin

# Install an extension for zplugin for managing "shims"
zplugin load zplugin/z-a-bin-gem-node


#################################################################
# PROMPT SETTINGS
#
# This settings are applied immidiately (because we need to show
# prompt as fast as possible), so the plugins are being loaded
# eagerly.
#

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
ZSH_COMMAND_TIME_MIN_SECONDS=1
ZSH_COMMAND_TIME_MSG=''
AGKOZAK_CUSTOM_RPROMPT+=' %B%F{green}$([[ -n ${ZSH_COMMAND_TIME} ]] && pretty-time ${ZSH_COMMAND_TIME})%f%b'

zplugin load tonyseek/oh-my-zsh-virtualenv-prompt
zplugin load bric3/nice-exit-code
zplugin ice compile"*.zsh"; zplugin load sindresorhus/pretty-time-zsh
zplugin load popstas/zsh-command-time
zplugin ice compile"lib/*.zsh"; zplugin load agkozak/agkozak-zsh-prompt


#################################################################
# FUZZY SEARCH AND MOVEMENT
#
# Install a fuzzy finder (fzf/fzy) and necessary completions
# and key bindings.
#

# fzf binary only
zplugin ice from"gh-r" sbin"fzf"
zplugin load junegunn/fzf-bin

# fzf-tmux script, completions for many programs (e.g. kill <TAB>)
# and key bindings
zplugin ice multisrc"shell/{completion,key-bindings}.zsh" \
    id-as"junegunn/fzf_completions" pick"/dev/null" \
    sbin"bin/fzf-tmux"
zplugin load junegunn/fzf

# Pure zsh port of rupa/z
zplugin load agkozak/zsh-z

# Pick from most frecent folders with `Ctrl+g`
# Relies on z script
zplugin load andrewferrier/fzf-z

# Fast open file in vim
zplugin ice fbin"v"
zplugin load rupa/v


#################################################################
# INSTALL NON-PLUGIN COMMANDS
#

# Install `ffsend` (a Firefox Send client) statically-linked binary
zplugin ice if'[[ -z "$commands[ffsend]" && $(uname -s) == Linux ]]' \
    from"gh-r" bpick"^ffsend-v*-linux-x64-static$" \
    mv"ffsend-v* -> ffsend" fbin"ffsend"
zplugin load timvisee/ffsend

# Install `ffsend` completions
zplugin ice if'[[ -z "$commands[ffsend]" && $(uname -s) == Linux ]]' as'completion'
zplugin snippet 'https://raw.githubusercontent.com/timvisee/ffsend/master/contrib/completions/_ffsend'

# Install timelapse screen recorder
zplugin ice from"gh-r" mv'tl-* -> tl' fbin'tl' if'[[ -n "$commands[X]" ]]'
zplugin load ryanmjacobs/tl

# Git curses interface
zplugin ice as'command' if'[[ $(uname -s) == Linux ]]' \
    from"gh-r" bpick"^grv_v*_linux64$" mv"grv_v* -> grv"
zplugin load rgburke/grv

# Install twtxt (zplugin automatically installs completions/_txtnish)
zplugin ice as"command" make"PREFIX=${ZPFX}"
zplugin load mdom/txtnish

# Install fff and it's man page
zplugin ice as"command" make"PREFIX=${ZPFX} install"
zplugin load dylanaraps/fff


#################################################################
# INSTALL `k` COMMAND AND GENERATE COMPLITIONS
#
# zload RobSis/zsh-completion-generator

# zplugin ice atload"gencomp k"
# zload supercrabtree/k

# # alias l='k -h'


#################################################################
# OTHER PLUGINS
#

# Add `git dsf` command to git
zplugin ice has"git" as"program" pick"bin/git-dsf"
zplugin load zdharma/zsh-diff-so-fancy

# Add command-line online translator
zplugin ice has"gawk"
zplugin load soimort/translate-shell

# Toggles "sudo" before the current/previous command by pressing ESC-ESC.
zplugin load hcgraf/zsh-sudo

# Run `fg` command to return to foregrounded (Ctrl+Z'd) vim
zplugin load mdumitru/fancy-ctrl-z

# Install gitcd function to clone git repository and cd into it
GITCD_HOME=${HOME}/tmp
GITCD_TRIM=1
zplugin load lainiwa/gitcd

# Adds `git open`
zplugin load paulirish/git-open

# Get gitignore template with `gi` command
zplugin load voronkovich/gitignore.plugin.zsh

# Git-extras
zplugin ice as"program" \
    pick"${ZPFX}/bin/git-*" src"etc/git-extras-completion.zsh" make"PREFIX=${ZPFX}"
zplugin light tj/git-extras
zplugin ice as"completion"
zplugin snippet 'https://raw.githubusercontent.com/tj/git-extras/master/etc/git-extras-completion.zsh'

# Gitflow commands and completions
zplugin ice as"command" make"install prefix=${ZPFX}"
zplugin load nvie/gitflow
zplugin load bobthecow/git-flow-completion

# Completions for docker-compose
zplugin ice wait'0' lucid has'docker-compose' as"completion" atpull'zplugin creinstall -q .'
zplugin snippet https://github.com/docker/compose/blob/master/contrib/completion/zsh/_docker-compose


#################################################################
# COMPLETIONS FOR ALREADY INSTALLED BINARIES
#

# Install completions for pyenv, if present in $PATH
zplugin ice has'pyenv' id-as'pyenv' atpull'%atclone' \
    atclone"pyenv init - --no-rehash > pyenv.plugin.zsh; zcompile pyenv.plugin.zsh"
zplugin load zdharma/null

# Install completions for poetry, if present in $PATH
zplugin ice has'poetry' id-as'poetry' atpull'%atclone' \
    blockf atpull'%atclone' \
    atclone"
        mkdir src/ &&
        poetry completions zsh > src/_poetry &&
        echo fpath+=\"\${0:h}/src\" > poetry.plugin.zsh &&
        zplugin creinstall -q .
    "
zplugin load zdharma/null

# Install completions for rustup and cargo, if rustup is in $PATH
zplugin ice has'rustup' id-as'rustup' atpull'%atclone' \
    blockf atpull'%atclone' \
    atclone"
        mkdir src/ &&
        rustup completions zsh cargo > src/_cargo &&
        rustup completions zsh rustup > src/_rustup &&
        echo fpath+=\"\${0:h}/src\" > rustup.plugin.zsh &&
        zplugin creinstall -q .
    "
zplugin load zdharma/null


zplugin ice from"gh-r" mv"exa* -> exa" sbin"exa" \
    atinit"
        alias ls='exa --color=auto --header --git'
        alias la='ls -a'
        alias lal='ls -al'
    "
zplugin load ogham/exa

zplugin ice as'completion' mv"*.zsh -> _exa"
zplugin snippet 'https://raw.githubusercontent.com/ogham/exa/master/contrib/completions.zsh'

zplugin ice from"gh-r" bpick"broot" fbin"broot -> br"
zplugin load Canop/broot
# Install Nix package manager completions
zplugin ice has'nix'
zplugin load spwhitt/nix-zsh-completions

# Install Guix package manager completions
zplugin ice has'guix' as'completion'
zplugin snippet 'https://git.savannah.gnu.org/cgit/guix.git/plain/etc/completion/zsh/_guix'


#################################################################
# IMPORTANT PLUGINS
#

# Additional completion definitions
zplugin ice blockf atclone'zplugin creinstall -q .' atpull'%atclone'
zplugin load zsh-users/zsh-completions

# History search by `Ctrl+R`
zplugin ice compile'{hsmw-*,test/*}'
zplugin load zdharma/history-search-multi-word

# Autosuggestions
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
zplugin ice compile'{src/*.zsh,src/strategies/*}' atload'_zsh_autosuggest_start'
zplugin load zsh-users/zsh-autosuggestions

# Syntax highlighting
# (compinit without `-i` spawns warning on `sudo -s`)
zplugin ice wait'0' lucid atinit"ZPLGM[COMPINIT_OPTS]='-i' zpcompinit; zpcdreplay"
zplugin load zdharma/fast-syntax-highlighting

# `...` ==> `../..`
zplugin ice lucid wait"0b" pick"manydots-magic"
zplugin load knu/zsh-manydots-magic
