
export NNN_FIFO=/tmp/nnn.fifo

# -d  detail mode
# -n  type-to-nav mode
# -r  use advcpmv patched cp, mv
# -x  notis, sel to system clipboard
export NNN_OPTS="dnrx"

if [[ -d ${XDG_CONFIG_HOME:-${HOME}/.config}/nnn/plugins ]]; then
    export NNN_PLUG='f:finder;o:fzopen;p:mocplay;d:diffs;t:nmount;v:imgview'
    if (( ${+commands[fzf]} )) && [[ -f "${_Z_DATA:-${HOME}/.z}" ]]; then
        export NNN_PLUG="${NNN_PLUG};z:fzz"
    fi
    # if (( ${+commands[bash]} && ${+commands[tabbed]} && ${+commands[tabbed]} && ${+commands[tabbed]} && ${+commands[tabbed]} )); then
        export NNN_PLUG="${NNN_PLUG};a:preview-tabbed"
    # fi
    export NNN_PLUG="${NNN_PLUG};c:preview-tui"
fi
