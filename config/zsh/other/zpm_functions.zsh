
requirements() {
    emulate -L zsh
    # <<< agkozak/zhooks
    # <<< romkatv/gitstatus
    # Prompt
    <<< romkatv/zsh-prompt-benchmark
    <<< agkozak/agkozak-zsh-prompt
    # Z
    <<< agkozak/zsh-z
    # <<< andrewferrier/fzf-z
    # Tmux plugins
    <<< zpm-zsh/title
    # <<< zpm-zsh/tmux
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
    # <<< MenkeTechnologies/zsh-more-completions
    <<< zchee/zsh-completions
    <<< zsh-users/zsh-completions
    # <<< zpm-zsh/zsh-completions,apply:fpath
    <<< srijanshetty/zsh-pandoc-completion
    <<< bobthecow/git-flow-completion
    <<< spwhitt/nix-zsh-completions
    <<< nojanath/ansible-zsh-completion
    <<< lukechilds/zsh-better-npm-completion
    # Zsh in nix-shell
    <<< chisui/zsh-nix-shell
    # Get gitignore template with `gi` command
    <<< voronkovich/gitignore.plugin.zsh
    # Heavy stuff
    # <<< zdharma/history-search-multi-word,fpath:/
    # (( ${+commands[mcfly]} )) && <<< cantino/mcfly,source:mcfly.zsh
    (( ${+commands[sqlite3]} )) && <<< lainiwa/zsh-histdb
    <<< zdharma/fast-syntax-highlighting,fpath:/→chroma
    <<< zsh-users/zsh-autosuggestions,source:zsh-autosuggestions.zsh
    # <<< m42e/zsh-histdb-fzf,source:fzf-histdb.zsh
    # Substitute `...` with `../..`
    (( ${+commands[awk]} )) && <<< lainiwa/zsh-manydots-magic,source:manydots-magic
    # Non-plugins
    (( ${+commands[make]} )) &&  <<< dylanaraps/fff,hook:"make; PREFIX=${_ZPM_POL} make install"
    (( ${+commands[make]} )) &&  <<<   nvie/gitflow,hook:"make install prefix=${_ZPM_POL}"
    (( ${+commands[make]} )) &&  <<<       snipem/v,hook:"PREFIX=${_ZPM_POL} make install"
     <<<      gitbits/git-info,hook:"cp git-*    ${_ZPM_POL}/bin/"
     (( ${+commands[perl]} )) && <<< circulosmeos/gdown.pl,hook:"cp gdown.pl ${_ZPM_POL}/bin/gdown"
     (( ${+commands[bash]} )) && <<<    greymd/tmux-xpanes,hook:"./install.sh '${_ZPM_POL}'",apply:fpath,fpath:/completion/zsh
    # Generate completions
    (( ${+commands[rustup]} )) && <<< @empty/rustup,gen-completion:"rustup completions zsh rustup"
    (( ${+commands[rustup]} )) && <<< @empty/cargo,gen-completion:"rustup completions zsh cargo"
    (( ${+commands[poetry]} )) && <<< @empty/poetry,gen-completion:"poetry completions zsh"
    (( ${+commands[rclone]} )) && <<< @empty/rclone,gen-completion:"rclone genautocomplete zsh /dev/stdout"
    (( ${+commands[restic]} )) && <<< @empty/restic,gen-completion:"restic generate --zsh-completion /dev/stdout"
    (( ${+commands[beet]} && ${+commands[gawk]} )) &&
        <<<   @empty/beet,gen-completion:"${GH}/beetbox/beets/master/extra/_beet | sed s/awk/gawk/g"
    # Download completions
    <<<           @empty/beet,gen-completion:"${GH}/beetbox/beets/master/extra/_beet"
    <<<           @empty/buku,gen-completion:"${GH}/jarun/Buku/master/auto-completion/zsh/_buku"
    <<<            @empty/cht,gen-completion:"${URL}/cheat.sh/:zsh"
    <<<            @empty/nnn,gen-completion:"${GH}/jarun/nnn/master/misc/auto-completion/zsh/_nnn"
    <<< @empty/docker-compose,gen-completion:"${GH}/docker/compose/master/contrib/completion/zsh/_docker-compose"
    <<<            @empty/exa,gen-completion:"${GH}/ogham/exa/master/contrib/completions.zsh"
    <<<         @empty/ffsend,gen-completion:"${GH}/timvisee/ffsend/master/contrib/completions/_ffsend"
    <<<           @empty/gist,gen-completion:"${GH}/jdowner/gist/alpha/share/gist.zsh"
    <<<           @empty/guix,gen-completion:"${GNU}/cgit/guix.git/plain/etc/completion/zsh/_guix"
    <<<           @empty/khal,gen-completion:"${GH}/pimutils/khal/master/misc/__khal"
    # Generate sourceables
    (( ${+commands[brew]}          )) && <<< @empty/linuxbrew,gen-plugin:"brew shellenv; <<<'FPATH=$(brew --prefix)/share/zsh/site-functions:\${FPATH}'"
    (( ${+commands[aws_completer]} )) && <<<       @empty/aws,gen-plugin:"<<<'complete -C $(which aws_completer) aws'"
    (( ${+commands[dircolors]}     )) && <<< @empty/dircolors,gen-plugin:"dircolors --bourne-shell <(${GH}/trapd00r/LS_COLORS/master/LS_COLORS)"
    (( ${+commands[pip]}           )) && <<<       @empty/pip,gen-plugin:"pip completion --zsh"
    (( ${+commands[pip3]}          )) && <<<      @empty/pip3,gen-plugin:"pip3 completion --zsh"
    (( ${+commands[pyenv]}         )) && <<<     @empty/pyenv,gen-plugin:"pyenv init - --no-rehash"
    (( ${+commands[kubectl]}       )) && <<<   @empty/kubectl,gen-plugin:"kubectl completion zsh"
    (( ${+commands[terraform]}     )) && <<< @empty/terraform,gen-plugin:"<<<'complete -o nospace -C $(which terraform) terraform'"
    (( ${+commands[register-python-argcomplete]} && ${+commands[pipx]} )) &&
        <<< @empty/pipx,gen-plugin:"register-python-argcomplete pipx"
    # # Fetch releases from Github
    # if (( ${+commands[jq]} && ${+commands[tar]} )); then
    #     _glow=$( get_gh_url charmbracelet/glow 'linux_x86_64.tar.gz$')
    #     _micro=$(get_gh_url zyedidia/micro     'linux64-static.tar.gz$')
    #     <<<  @empty/glow,hook:"${_FETCH} ${_glow}  | tar -xzf-; cp glow    ${_ZPM_POL}/bin/"
    #     <<< @empty/micro,hook:"${_FETCH} ${_micro} | tar -xzf-; cp */micro ${_ZPM_POL}/bin/"
    # fi
}


histdb-fzf-widget() {
    emulate -L zsh
    local selected num
    selected=$(
        _histdb_query "
SELECT min(history.id), REPLACE(argv, X'0A', '; ')
FROM history
LEFT JOIN commands ON history.command_id = commands.rowid
GROUP BY argv
ORDER BY history.start_time DESC
" |
    ${${commands[sk]:+sk}:-fzf} \
        --height "${FZF_TMUX_HEIGHT:-40%}" \
        --no-multi \
        --query="${LBUFFER}" \
        --bind=ctrl-r:toggle-sort \
        --with-nth 2.. \
        --delimiter='\|'
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


