
requirements() {
    emulate -L zsh
    # <<< agkozak/zhooks
    # <<< romkatv/gitstatus
    # Prompt
    <<< romkatv/zsh-prompt-benchmark
    <<< agkozak/agkozak-zsh-prompt
    # Z
    <<< Angelmmiguel/pm,fpath:/zsh,source:/zsh/pm.zsh
    if (( ${+commands[zoxide]} )); then
        <<<  @empty/zoxide,gen-plugin:"zoxide init zsh"
    elif (( ${+commands[lua]} )); then
        <<< skywind3000/z.lua
    else
        <<< agkozak/zsh-z
    fi
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
    <<< paulirish/git-open
    <<< zdharma/zsh-diff-so-fancy
    # Completions
    # <<< MenkeTechnologies/zsh-more-completions,fpath:/src
    <<< zchee/zsh-completions
    <<< zsh-users/zsh-completions
    <<< srijanshetty/zsh-pandoc-completion
    <<< spwhitt/nix-zsh-completions
    <<< nojanath/ansible-zsh-completion
    <<< lukechilds/zsh-better-npm-completion
    # Zsh in nix-shell
    <<< chisui/zsh-nix-shell
    # Get gitignore template with `gi` command
    <<< voronkovich/gitignore.plugin.zsh
    # History
    if (( ${+commands[atuin]} )); then
        <<< ellie/atuin
    elif (( ${+commands[sqlite3]} && (${+commands[fzf]} || ${+commands[sk]}) )); then
        <<< lainiwa/zsh-histdb
    elif (( ${+commands[mcfly]} )); then
        <<< cantino/mcfly,source:mcfly.zsh
    else
        <<< zdharma/history-search-multi-word,fpath:/
    fi
    # Heavy stuff
    <<< zdharma/fast-syntax-highlighting,fpath:/→chroma
    <<< zsh-users/zsh-autosuggestions,source:zsh-autosuggestions.zsh
    # Substitute `...` with `../..`
    (( ${+commands[awk]} )) && <<< lainiwa/zsh-manydots-magic,source:manydots-magic
    # Non-plugins
    if (( ${+commands[make]} )); then
        (( ! ${+commands[fff]} )) && <<< dylanaraps/fff,hook:"PREFIX=${_ZPM_POL} make install"
        <<<       snipem/v,hook:"PREFIX=${_ZPM_POL} make install"
    fi
    <<< gitbits/git-info,hook:"cp git-*    ${_ZPM_POL}/bin/"
    (( ${+commands[fzf]} )) && <<< wfxr/forgit
    # Generate completions
    (( ${+commands[rustup]} )) && <<< @empty/rustup,gen-completion:"rustup completions zsh rustup"
    (( ${+commands[rustup]} )) && <<<  @empty/cargo,gen-completion:"rustup completions zsh cargo"
    (( ${+commands[poetry]} )) && <<< @empty/poetry,gen-completion:"poetry completions zsh"
    (( ${+commands[rclone]} )) && <<< @empty/rclone,gen-completion:"rclone genautocomplete zsh /dev/stdout"
    (( ${+commands[restic]} )) && <<< @empty/restic,gen-completion:"restic generate --zsh-completion /dev/stdout"
    (( ${+commands[beet]} && ${+commands[gawk]} )) &&
        <<<   @empty/beet,gen-completion:"${GH}/beetbox/beets/master/extra/_beet | sed s/awk/gawk/g"
    # Download completions
    <<<            @empty/cht,gen-completion:"${URL}/cheat.sh/:zsh"
    <<<           @empty/guix,gen-completion:"${GNU}/cgit/guix.git/plain/etc/completion/zsh/_guix"
    <<<           @empty/gist,gen-completion:"${GH}/jdowner/gist/alpha/share/gist.zsh"
    <<<           @empty/beet,gen-completion:"${GH}/beetbox/beets/master/extra/_beet"
    <<<           @empty/buku,gen-completion:"${GH}/jarun/Buku/master/auto-completion/zsh/_buku"
    <<<            @empty/nnn,gen-completion:"${GH}/jarun/nnn/master/misc/auto-completion/zsh/_nnn"
    <<< @empty/docker-compose,gen-completion:"${GH}/docker/compose/master/contrib/completion/zsh/_docker-compose"
    <<<            @empty/exa,gen-completion:"${GH}/ogham/exa/master/contrib/completions.zsh"
    <<<         @empty/ffsend,gen-completion:"${GH}/timvisee/ffsend/master/contrib/completions/_ffsend"
    <<<           @empty/khal,gen-completion:"${GH}/pimutils/khal/master/misc/__khal"
    <<<    @empty/taskwarrior,gen-completion:"${GH}/GothenburgBitFactory/taskwarrior/master/scripts/zsh/_task"
    # Generate completions
    (( ${+commands[dvc]} )) && <<< @empty/dvc,gen-completion:"dvc completion -s zsh"
    (( ${+commands[gh]}  )) && <<<  @empty/gh,gen-completion:"gh  completion -s zsh"
    if (( ${+commands[register-python-argcomplete]} )); then
        (( ${+commands[pipx]} ))   && <<<   @empty/pipx,gen-completion:"register-python-argcomplete pipx"
        (( ${+commands[cz]} ))     && <<<     @empty/cz,gen-completion:"register-python-argcomplete cz"
        (( ${+commands[git-cz]} )) && <<< @empty/git-cz,gen-completion:"register-python-argcomplete git-cz"
    fi
    # Generate sourceables
    (( ${+commands[brew]}          )) && <<< @empty/linuxbrew,gen-plugin:"brew shellenv; <<<'FPATH=$(brew --prefix)/share/zsh/site-functions:\${FPATH}'"
    (( ${+commands[aws_completer]} )) && <<<       @empty/aws,gen-plugin:"<<<'complete -C =aws_completer aws'"
    (( ${+commands[dircolors]}     )) && <<< @empty/dircolors,gen-plugin:"dircolors --bourne-shell <(${GH}/trapd00r/LS_COLORS/master/LS_COLORS)"
    (( ${+commands[git-town]}      )) && <<<  @empty/git-town,gen-plugin:"git-town completions zsh"
    (( ${+commands[pip]}           )) && <<<       @empty/pip,gen-plugin:"pip completion --zsh"
    (( ${+commands[pip3]}          )) && <<<      @empty/pip3,gen-plugin:"pip3 completion --zsh"
    (( ${+commands[pyenv]}         )) && <<<     @empty/pyenv,gen-plugin:"pyenv init - --no-rehash"
    (( ${+commands[kubectl]}       )) && <<<   @empty/kubectl,gen-plugin:"kubectl completion zsh"
    (( ${+commands[terraform]}     )) && <<< @empty/terraform,gen-plugin:"<<<'complete -o nospace -C =terraform terraform'"
    (( ${+commands[s5cmd]}         )) && <<<     @empty/s5cmd,gen-plugin:"<<<'complete -o nospace -C =s5cmd s5cmd'"
}

pick_fzf() {
    ${${commands[sk]:+sk}:-fzf} \
        --height "${FZF_TMUX_HEIGHT:-40%}" \
        --no-multi \
        --query="${LBUFFER}" \
        --bind=ctrl-r:toggle-sort \
        --with-nth 2.. \
        --delimiter='\|' \
        --no-sort \
        --exact
}

histdb-fzf-widget() {
    emulate -L zsh
    local selected num
    selected=$(
        _histdb_query "
SELECT min(history.command_id), REPLACE(argv, X'0A', '; ')
FROM history
LEFT JOIN commands ON history.command_id = commands.rowid
GROUP BY argv
ORDER BY history.start_time DESC
" |
    pick_fzf
    )
    selected=${selected%%|*}
    if [[ -n ${selected} ]]; then
        selected=$(_histdb_query "
SELECT argv
FROM commands
WHERE id = ${selected}
LIMIT 1
")
    fi

    LBUFFER=${selected}
    zle redisplay
    typeset -f zle-line-init >/dev/null && zle zle-line-init

    return $ret
}


_zsh_autosuggest_strategy_histdb_last_command() {
    emulate -L zsh
    local query="
SELECT argv
FROM history
LEFT JOIN commands ON history.command_id = commands.rowid
WHERE commands.argv LIKE '$(sql_escape ${1})%'
ORDER BY history.start_time DESC
LIMIT 1
"
    suggestion=$(_histdb_query "$query")
}


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


