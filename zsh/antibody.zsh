
source <(antibody init)

if [ -s ~/.zsh_plugins.sh ]; then
    source ~/.zsh_plugins.sh

else

PLUGINS=$(cat <<-END
# PROMPT SETTINGS
tonyseek/oh-my-zsh-virtualenv-prompt
bric3/nice-exit-code
sindresorhus/pretty-time-zsh
popstas/zsh-command-time


rupa/z
andrewferrier/fzf-z
changyuheng/fz

rupa/v kind:path

mafredri/zsh-async
seletskiy/zsh-fuzzy-search-and-edit


# OTHER PLUGINS
zdharma/zsh-diff-so-fancy
# soimort/translate-shell
hcgraf/zsh-sudo
mdumitru/fancy-ctrl-z
lainiwa/gitcd
paulirish/git-open
ael-code/zsh-colored-man-pages

# IMPORTANT PLUGINS
zsh-users/zsh-completions
zdharma/fast-syntax-highlighting
knu/zsh-manydots-magic path:manydots-magic  # goes after syntax highlighting
zdharma/history-search-multi-word
zsh-users/zsh-autosuggestions
END
)

export PS1='%B%F{green}$(virtualenv_prompt_info)'${PS1}
export RPS1='%B%F{red}$(nice_exit_code)%f%b'
export ZSH_COMMAND_TIME_MIN_SECONDS=1
export ZSH_COMMAND_TIME_MSG=''
export RPS1=${RPS1}' %B%F{green}$([[ -n ${ZSH_COMMAND_TIME} ]] && pretty-time ${ZSH_COMMAND_TIME})%f%b'

export ZSHZ_OWNER=1

bindkey '^P' fuzzy-search-and-edit
export EDITOR=${EDITOR:-vim}

export GITCD_TRIM=1
export GITCD_HOME=${HOME}/tmp

export ZSH_AUTOSUGGEST_USE_ASYNC=1
export ZSH_AUTOSUGGEST_MANUAL_REBIND=1

echo "${PLUGINS}" | antibody bundle

fi
