
# Install `zplugin` if not installed
if [ ! -d "${HOME}/.zplugin" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"
fi


# Load `zplugin`
source "${HOME}/.zplugin/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin


# Function to make configuration less verbose
turbo0()   { zplugin ice wait"0" lucid "${@}"; }
zload()    { zplugin load              "${@}"; }
zsnippet() { zplugin snippet           "${@}"; }


# Install `fzf` bynary with completions
turbo0 as"command" from"gh-r";         zload junegunn/fzf-bin
turbo0 as"command" pick"bin/fzf-tmux"; zload junegunn/fzf
turbo0 multisrc"shell/{completion,key-bindings}.zsh" \
        id-as"junegunn/fzf_completions" pick"/dev/null"
    zload junegunn/fzf


# Fuzzy movement and directory choosing
turbo0; zload rupa/z               # autojump command
turbo0; zload andrewferrier/fzf-z  # choose from most frecent folders with `Ctrl+g`
turbo0; zload changyuheng/fz       # lets z+[Tab] and zz+[Tab]


# Install `ffsend` binary with completions
turbo0 as"command" from"gh-r" bpick"*-static" mv"* -> ffsend";
    zload timvisee/ffsend
turbo0 as'completion' id-as'timvisee/ffsend_completions'
    zsnippet 'https://raw.githubusercontent.com/timvisee/ffsend/master/contrib/completions/_ffsend'


# Install `cloc` binary (if not already installed via package manager)
turbo0 if'[[ -z "$commands[cloc]" ]]' as"command" from"gh-r" bpick"*pl" mv"cloc-* -> cloc";
    zload AlDanial/cloc


# Install completions for `my` script and for python-gist
# (use `-f` flag to force completion installation)
turbo0 as"completion" if"[ -f '${HOME}/.zsh/completions/_my' ]" id-as"my";
    zsnippet "${HOME}/.zsh/completions/_my"
turbo0 as"completion" if"[ -f '${HOME}/.local/share/gist/gist.zsh' ]" id-as"gist" mv"gist.zsh -> _gist";
    zsnippet "${HOME}/.local/share/gist/gist.zsh"


# Install a number of plugins,
# which require setting `ice` options
turbo0 as"command"   pick"v";              zload rupa/v
turbo0 as"command"   pick"bin/git-dsf";    zload zdharma/zsh-diff-so-fancy
turbo0 pick"manydots-magic";               zload knu/zsh-manydots-magic
turbo0 if'[[ -n "$commands[gawk]" ]]';     zload soimort/translate-shell


# Install all other plugins
turbo0; zload supercrabtree/k                # ls -lh + git helpers
turbo0; zload hcgraf/zsh-sudo                # Toggles "sudo" before the current/previous command by pressing ESC-ESC.
turbo0; zload mdumitru/fancy-ctrl-z          # Run `fg` command to return
                                                    #     to foregrounded (Ctrl+Z'd) vim
turbo0; zload viko16/gitcd.plugin.zsh


# Autosuggestions
turbo0 atload"_zsh_autosuggest_start"; zload zsh-users/zsh-autosuggestions
export ZSH_AUTOSUGGEST_USE_ASYNC=1
export ZSH_AUTOSUGGEST_MANUAL_REBIND=1


# Install completions from various commands
completions_from_command() {
    # Function arguments
    local cmd_name=$1  # name of command we are making completions for (e.g. `pip`)
    local cmd_compgen=$2  # command to generate completions (e.g. `pip completion --zsh`)
    # Other variables
    local cmd_1st_ford=${cmd_compgen/%\ */}
    local plugin_name=${cmd_name}_completions
    local plugin_dir="${ZPLGM[PLUGINS_DIR]}/_local---${plugin_name}"
    # Create directory for new dummy plugin (if not exists)
    if [[ ! -d ${plugin_dir} ]]; then
        mkdir -p -- "${plugin_dir}"
    fi
    # Hook install completions to the dummy plugin installation
    turbo0 if"command -v ${cmd_1st_ford} >/dev/null" \
           atclone"${cmd_compgen} > ${plugin_name}.zsh" \
           atpull"%atclone" \
           pick"${plugin_name}.zsh"
    # Install the dummy plugin
    zload "_local/${plugin_name}"
}
completions_from_command pip 'pip completion --zsh'  # pip3 only (?) completions
completions_from_command rust 'rustup completions zsh'  # rustup, rustc, cargo, ..?
unset -f completions_from_command


# Additional completion definitions
turbo0 blockf
zload zsh-users/zsh-completions


# Print python virtual environment name in prompt
zload tonyseek/oh-my-zsh-virtualenv-prompt
export PS1='%B%F{green}$(virtualenv_prompt_info)'${PS1}


# Print command exit code as a human-readable string
# (`cedi/meaningful-error-codes` might be an alternative)
zload bric3/nice-exit-code
export RPS1='%B%F{red}$(nice_exit_code)%f%b'


# Add execution time to right prompt
zload sindresorhus/pretty-time-zsh
zload popstas/zsh-command-time
export ZSH_COMMAND_TIME_MIN_SECONDS=1
export ZSH_COMMAND_TIME_MSG=''
export RPS1=${RPS1}' %B%F{green}$([[ -n ${ZSH_COMMAND_TIME} ]] && pretty-time ${ZSH_COMMAND_TIME})%f%b'


# Fuzzy search by `Ctrl+P` a file and open in `$EDITOR`
turbo0; zload mafredri/zsh-async
turbo0; zload seletskiy/zsh-fuzzy-search-and-edit
bindkey '^P' fuzzy-search-and-edit
export EDITOR="${EDITOR:-vim}"


# Fuzzy history search by `Ctrl+R`
turbo0; zload zsh-users/zsh-history-substring-search


# Syntax highlighting
ZPLGM[COMPINIT_OPTS]="-i"  # compinit without`-i` spawns warning on 'sudo -s'
turbo0 atinit"zpcompinit; zpcdreplay"
zload zdharma/fast-syntax-highlighting


# Include python's virtualenvwrapper
turbo0 if'[[ -n "${VIRTUALENVWRAPPER_SCRIPT}" ]]'
    zplugin snippet "${VIRTUALENVWRAPPER_SCRIPT}"


# Execute compdefs provided by rest of plugins
zplugin cdreplay -q


# Remove temporary functions
unset -f turbo0
unset -f zload
unset -f zsnippet
