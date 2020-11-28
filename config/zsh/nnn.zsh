
export NNN_FIFO=/tmp/nnn.fifo


# _has() {
#     for bin in "$@"; do
#     done

# }


# -d  detail mode
# -n  type-to-nav mode
# -r  use advcpmv patched cp, mv
# -x  notis, sel to system clipboard
# -U      show user and group
export NNN_OPTS="drxU"

if (( ${+commands[trash-cli]} )); then
    export NNN_TRASH=1
elif (( ${+commands[gio]} )); then
    export NNN_TRASH=2
else
    export NNN_TRASH=0
fi


if (( ${+commands[atool]} || ${+commands[bsdtar]} )); then
    export NNN_ARCHIVE="\\.(7z|a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|rar|rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip)$"
fi

if [[ -d ${XDG_CONFIG_HOME:-${HOME}/.config}/nnn/plugins ]]; then
    export NNN_PLUG='f:finder;o:fzopen;d:diffs;t:nmount'
    # autojump/fzz
    # dragdrop

    # Copy system clipboard newline-separated file list to selection
    if (( ${+commands[xclip]} || ${+commands[xsel]} )); then
        export NNN_PLUG="${NNN_PLUG};x:x2sel"
    fi
    # Cd to any dir in the z database using an fzf pane
    if (( ${+commands[fzf]} )) && [[ -f "${_Z_DATA:-${ZSHZ_DATA:-$HOME/.z}}" ]]; then
        export NNN_PLUG="${NNN_PLUG};z:fzz"
    fi
    # Open images in hovered  directory and thumbnails
    # open hovered image in sxiv or viu and browse other images in the directory
    if (( ${+commands[sxiv]} || ${+commands[imv]} || ${+commands[imvr]} )); then
        export NNN_PLUG="${NNN_PLUG};v:imgview"
    fi
    # Tabbed/xembed based file previewer
    export NNN_PLUG="${NNN_PLUG};a:preview-tabbed"
    # Terminal based file previewer
    export NNN_PLUG="${NNN_PLUG};c:preview-tui"
fi
