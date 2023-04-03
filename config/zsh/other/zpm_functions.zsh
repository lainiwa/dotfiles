
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
        <<<  @exec/zoxide,origin:"zoxide init zsh"
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
    # Completions
    # <<< MenkeTechnologies/zsh-more-completions,fpath:/src
    <<< zchee/zsh-completions
    <<< zsh-users/zsh-completions,fpath:/src
    <<< srijanshetty/zsh-pandoc-completion
    <<< spwhitt/nix-zsh-completions
    <<< nojanath/ansible-zsh-completion
    <<< lukechilds/zsh-better-npm-completion
    # Zsh in nix-shell
    <<< chisui/zsh-nix-shell
    # Git related
    <<< paulirish/git-open
    (( ${+commands[fzf]} )) && <<< wfxr/forgit
    # Get gitignore template with `gi` command
    <<< voronkovich/gitignore.plugin.zsh
    # Source .in and .out files
    <<< zpm-zsh/autoenv

    # Heavy stuff
    <<< zsh-users/zsh-autosuggestions,source:zsh-autosuggestions.zsh
    <<< zdharma-continuum/fast-syntax-highlighting,fpath:/→chroma

    # History
    if (( ${+commands[atuin]} )); then
        <<< ellie/atuin
    elif (( ${+commands[sqlite3]} && (${+commands[fzf]} || ${+commands[sk]}) )); then
        <<< lainiwa/zsh-histdb
    elif (( ${+commands[mcfly]} )); then
        <<< cantino/mcfly,source:mcfly.zsh
    else
        <<< zsh-users/zsh-history-substring-search
    fi

    # Substitute `...` with `../..`
    (( ${+commands[awk]} )) && <<< lainiwa/zsh-manydots-magic,source:manydots-magic

    # Non-plugins
    if (( ${+commands[make]} )); then
        (( ! ${+commands[fff]} )) && <<< dylanaraps/fff,hook:"PREFIX=${_ZPM_POL} make install"
        <<<       snipem/v,hook:"PREFIX=${_ZPM_POL} make install"
    fi
    (( ${+commands[fzf]} && ${+commands[systemctl]} && ${+commands[awk]} )) &&
        <<<  joehillen/sysz,hook:"cp sysz ${_ZPM_POL}/bin/"
    <<<          gitbits/git-info,hook:"cp git-*      ${_ZPM_POL}/bin/"
    <<<        loelkes/git-redate,hook:"cp git-*      ${_ZPM_POL}/bin/"
    <<< takaaki-kasai/git-foresta,hook:"cp git-*      ${_ZPM_POL}/bin/"
    <<<     denilsonsa/prettyping,hook:"cp prettyping ${_ZPM_POL}/bin/pping"
    # get_bin cht.sh      "${URL}/cht.sh/:cht.sh" &

    # Download zsh completions
    (( ${+commands[beet]} && ${+commands[gawk]} )) &&
        <<<   @exec/beet,apply:fpath,origin:"${GH}/beetbox/beets/master/extra/_beet | sed s/awk/gawk/g > _beet"
    <<<            @exec/cht,apply:fpath,origin:"${URL}/cheat.sh/:zsh > _cht"
    <<<            @exec/exa,apply:fpath,origin:"${GH}/ogham/exa/master/completions/zsh/_exa > _exa"
    <<<            @exec/nnn,apply:fpath,origin:"${GH}/jarun/nnn/master/misc/auto-completion/zsh/_nnn > _nnn"
    <<<           @exec/beet,apply:fpath,origin:"${GH}/beetbox/beets/master/extra/_beet > _beet"
    <<<           @exec/buku,apply:fpath,origin:"${GH}/jarun/Buku/master/auto-completion/zsh/_buku > _buku"
    <<<           @exec/gist,apply:fpath,origin:"${GH}/jdowner/gist/master/share/gist.zsh > _gist"
    <<<        @exec/git-bug,apply:fpath,origin:"${GH}/MichaelMure/git-bug/master/misc/completion/zsh/git-bug > _git-bug"
    <<<           @exec/guix,apply:fpath,origin:"${GNU}/cgit/guix.git/plain/etc/completion/zsh/_guix > _guix"
    <<<         @exec/ffsend,apply:fpath,origin:"${GH}/timvisee/ffsend/master/contrib/completions/_ffsend > _ffsend"
    <<<         @exec/watson,apply:fpath,origin:"${GH}/TailorDev/Watson/master/watson.zsh-completion > _watson"
    <<<    @exec/taskwarrior,apply:fpath,origin:"${GH}/GothenburgBitFactory/taskwarrior/master/scripts/zsh/_task > _taskwarrior"
    <<< @exec/docker-compose,apply:fpath,origin:"${GH}/docker/compose/master/contrib/completion/zsh/_docker-compose > _docker-compose"
    <<<      @exec/aws-vault,apply:fpath,origin:"${GH}/99designs/aws-vault/master/contrib/completions/zsh/aws-vault.zsh > _aws-vault"

    # Download bash completions
    <<< @exec/timewarrior,origin:"${GH}/GothenburgBitFactory/timewarrior/master/completion/timew-completion.bash > _timewarrior"
    # <<<     @exec/hledger,apply:fpath,origin:"${GH}/simonmichael/hledger/master/hledger/shell-completion/hledger-completion.bash > _hledger"

    # Generate completions
    (( ${+commands[khal]}   )) && <<<   @exec/khal,apply:fpath,origin:"_KHAL_COMPLETE=zsh_source khal > _khal"
    (( ${+commands[kaf]}    )) && <<<    @exec/kaf,apply:fpath,origin:"kaf completion zsh > _kaf"
    (( ${+commands[wgcf]}   )) && <<<   @exec/wgcf,apply:fpath,origin:"wgcf completion zsh > _wgcf"
    (( ${+commands[arc]}    )) && <<<    @exec/arc,apply:fpath,origin:"arc completion zsh > _arc"
    (( ${+commands[ya]}    ))  && <<<     @exec/ya,apply:fpath,origin:"ya completion --zsh; cat ~/.ya.completion/zsh/_ya; rm -rf ~/.ya.completion/zsh > _ya"
    (( ${+commands[k0s]}    )) && <<<    @exec/k0s,apply:fpath,origin:"k0s completion zsh > _k0s"
    (( ${+commands[k0sctl]} )) && <<< @exec/k0sctl,apply:fpath,origin:"k0sctl completion zsh > _k0sctl"
    (( ${+commands[hcloud]} )) && <<< @exec/hcloud,apply:fpath,origin:"hcloud completion zsh > _hcloud"
    (( ${+commands[dvc]}    )) && <<<    @exec/dvc,apply:fpath,origin:"dvc completion -s zsh > _dvc"
    (( ${+commands[gh]}     )) && <<<     @exec/gh,apply:fpath,origin:"gh completion -s zsh > _gh"
    (( ${+commands[poetry]} )) && <<< @exec/poetry,apply:fpath,origin:"poetry completions zsh > _poetry"
    (( ${+commands[rclone]} )) && <<< @exec/rclone,apply:fpath,origin:"rclone genautocomplete zsh /dev/stdout > _rclone"
    (( ${+commands[restic]} )) && <<< @exec/restic,apply:fpath,origin:"restic generate --zsh-completion /dev/stdout > _restic"
    (( ${+commands[rustup]} )) && <<<  @exec/cargo,apply:fpath,origin:"rustup completions zsh cargo > _cargo"
    (( ${+commands[rustup]} )) && <<< @exec/rustup,apply:fpath,origin:"rustup completions zsh rustup > _rustup"
    (( ${+commands[helm]}   )) && <<<   @exec/helm,apply:fpath,origin:"helm completion zsh > _helm"
    (( ${+commands[flux]}   )) && <<<   @exec/flux,apply:fpath,origin:"flux completion zsh > _flux"
    (( ${+commands[eksctl]} )) && <<< @exec/eksctl,apply:fpath,origin:"eksctl completion zsh > _eksctl"
    if (( ${+commands[register-python-argcomplete]} )); then
        (( ${+commands[pipx]} ))   && <<<   @exec/pipx,apply:fpath,origin:"register-python-argcomplete pipx > _pipx"
        (( ${+commands[cz]} ))     && <<<     @exec/cz,apply:fpath,origin:"register-python-argcomplete cz > _cz"
        (( ${+commands[git-cz]} )) && <<< @exec/git-cz,apply:fpath,origin:"register-python-argcomplete git-cz > _git-cz"
    fi

    # Generate sourceables
    (( ${+commands[brew]}          )) && <<< @exec/linuxbrew,origin:"brew shellenv; <<<'FPATH=$(brew --prefix)/share/zsh/site-functions:\${FPATH}'"
    (( ${+commands[aws_completer]} )) && <<<       @exec/aws,origin:"<<<'complete -C =aws_completer aws'"
    (( ${+commands[dircolors]}     )) && <<< @exec/dircolors,origin:"dircolors --bourne-shell <(${GH}/trapd00r/LS_COLORS/master/LS_COLORS)"
    (( ${+commands[git-town]}      )) && <<<  @exec/git-town,origin:"git-town completions zsh"
    (( ${+commands[broot]}         )) && <<<     @exec/broot,origin:"broot --print-shell-function zsh"
    (( ${+commands[pip]}           )) && <<<       @exec/pip,origin:"pip completion --zsh"
    (( ${+commands[pip3]}          )) && <<<      @exec/pip3,origin:"pip3 completion --zsh"
    (( ${+commands[pyenv]}         )) && <<<     @exec/pyenv,origin:"pyenv init - --no-rehash"
    (( ${+commands[kubectl]}       )) && <<<   @exec/kubectl,origin:"kubectl completion zsh"
    (( ${+commands[vault]}         )) && <<<     @exec/vault,origin:"<<<'complete -o nospace -C =vault vault'"
    (( ${+commands[terraform]}     )) && <<< @exec/terraform,origin:"<<<'complete -o nospace -C =terraform terraform'"
    (( ${+commands[s5cmd]}         )) && <<<     @exec/s5cmd,origin:"<<<'complete -o nospace -C =s5cmd s5cmd'"
    (( ${+commands[git-extras]}    )) && <<<@exec/git-extras,origin:"cat /usr/share/zsh/vendor-completions/_git-extras"

    # Download sourceables
    (( ${+commands[lf]}            )) && <<<        @exec/lf,origin:"${GH}/gokcehan/lf/master/etc/lfcd.sh"
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
ORDER BY max(history.start_time) DESC
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


