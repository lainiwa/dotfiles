
# Install `zplugin` if not installed
if [ ! -d "${HOME}/.zplugin" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"
fi


# Load `zplugin`
source "${HOME}/.zplugin/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin


# Install `fzf` bynary with completions
zplugin ice from"gh-r" as"command"
    zplugin light junegunn/fzf-bin
zplugin ice as"command" pick"bin/fzf-tmux"
    zplugin light junegunn/fzf
zplugin ice multisrc"shell/{completion,key-bindings}.zsh" \
        id-as"junegunn/fzf_completions" pick"/dev/null"
    zplugin light junegunn/fzf


# Fuzzy movement and directory choosing
zplugin light rupa/z  # autojump command
zplugin ice if'[[ -n "$commands[fzf]" ]]'  # FIXME: fires on next run only
    zplugin light andrewferrier/fzf-z  # choose from most frecent folders with `Ctrl+g`
zplugin ice if'[[ -n "$commands[fzf]" && -n "$commands[z]" ]]'
    zplugin light changyuheng/fzf      # lets z+[Tab] and zz+[Tab]


# Install `ffsend` binary with completions
zplugin ice from"gh-r" as"command" bpick"*-static" mv"* -> ffsend";
    zplugin light timvisee/ffsend
zplugin ice as'completion' id-as'timvisee/ffsend_completions'
    zplugin snippet 'https://raw.githubusercontent.com/timvisee/ffsend/master/contrib/completions/_ffsend'


# Install `cloc` binary (if not already installed via package manager)
zplugin ice if'[[ -z "$commands[cloc]" ]]' from"gh-r" as"command" bpick"*pl" mv"cloc-* -> cloc";
    zplugin light AlDanial/cloc


# Install completions for `my` script and for python-gist
# (use `-f` flag to force completion installation)
zplugin ice as"completion" if"[ -f '${HOME}/.zsh/completions/_my' ]" id-as"my";
    zplugin snippet "${HOME}/.zsh/completions/_my"
zplugin ice as"completion" if"[ -f '${HOME}/.local/share/gist/gist.zsh' ]" id-as"gist" mv"gist.zsh -> _gist";
    zplugin snippet "${HOME}/.local/share/gist/gist.zsh"


# Install a number of plugins,
# which require setting `ice` options
zplugin ice as"command"   pick"v";              zplugin light rupa/v
zplugin ice as"command"   pick"bin/git-dsf";    zplugin light zdharma/zsh-diff-so-fancy
zplugin ice lucid wait"0" pick"manydots-magic"; zplugin light knu/zsh-manydots-magic
zplugin ice if'[[ -n "$commands[gawk]" ]]';     zplugin light soimort/translate-shell



# Install all other plugins
zplugin light supercrabtree/k                        # ls -lh + git helpers
zplugin light hcgraf/zsh-sudo                        # Toggles "sudo" before the current/previous command by pressing ESC-ESC.
zplugin light zsh-users/zsh-completions              # Additional completion definitions for Zsh.
zplugin light zsh-users/zsh-autosuggestions          # slow!
zplugin light mdumitru/fancy-ctrl-z                  # Run `fg` command to return
                                                     # to foregrounded (Ctrl+Z'd) vim
zplugin light viko16/gitcd.plugin.zsh


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
    zplugin ice if"command -v ${cmd_1st_ford} >/dev/null" \
                atclone"${cmd_compgen} > ${plugin_name}.zsh" \
                atpull"%atclone" \
                pick"${plugin_name}.zsh"
    # Install the dummy plugin
    zplugin load "_local/${plugin_name}"
}
completions_from_command pip 'pip completion --zsh'  # pip3 only (?) completions
completions_from_command rust 'rustup completions zsh'  # rustup, rustc, cargo, ..?
unset -f completions_from_command


# Print python virtual environment name in prompt
zplugin light tonyseek/oh-my-zsh-virtualenv-prompt
export PS1='%B%F{green}$(virtualenv_prompt_info)'${PS1}


# Print command exit code as a human-readable string
zplugin light bric3/nice-exit-code
export RPS1='%B%F{red}$(nice_exit_code)%f%b'


# Add execution time to right prompt
zplugin light sindresorhus/pretty-time-zsh
zplugin light popstas/zsh-command-time
export ZSH_COMMAND_TIME_MIN_SECONDS=1
export ZSH_COMMAND_TIME_MSG=''
export RPS1=${RPS1}' %B%F{green}$([[ -n ${ZSH_COMMAND_TIME} ]] && pretty-time ${ZSH_COMMAND_TIME})%f%b'


# Fuzzy search by `Ctrl+P` a file and open in `$EDITOR`
zplugin light mafredri/zsh-async
zplugin light seletskiy/zsh-fuzzy-search-and-edit
bindkey '^P' fuzzy-search-and-edit
export EDITOR="${EDITOR:-vim}"


# Fuzzy history search by `Ctrl+R`
zplugin light zsh-users/zsh-history-substring-search


# Syntax highlighting
zplugin light zdharma/fast-syntax-highlighting


# Load completions
autoload -Uz compinit
compinit -i  # if not `-i` spauns warning when 'sudo -s'


# Execute compdefs provided by rest of plugins
zplugin cdreplay -q
