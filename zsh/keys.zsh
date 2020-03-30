
# Set key bindings (Ctrl+V Key to see key code)
bindkey -e
bindkey -r '^[c'                  # remove unwanted binding
bindkey '^[[D'    backward-char                           # left       move cursor one char backward
bindkey '^[[C'    forward-char                            # right      move cursor one char forward
# bindkey '^[[A'    z4h-up-line-or-beginning-search-local   # up         prev command in local history
# bindkey '^[[B'    z4h-down-line-or-beginning-search-local # down       next command in local history
# bindkey '^[[H'    beginning-of-line                       # home       go to the beginning of line
# bindkey '^[[F'    end-of-line                             # end        go to the end of line
# bindkey '^?'      backward-delete-char                    # bs         delete one char backward
bindkey '^[[3~'   delete-char                             # delete     delete one char forward
bindkey '^[[1;5C' forward-word                            # ctrl+right go forward one word
bindkey '^[[1;5D' backward-word                           # ctrl+left  go backward one word
# bindkey '^H'      backward-kill-word                      # ctrl+bs    delete previous word
# bindkey '^[[3;5~' kill-word                               # ctrl+del   delete next word
# bindkey '^K'      kill-line                               # ctrl+k     delete line after cursor
# bindkey '^J'      backward-kill-line                      # ctrl+j     delete line before cursor
# bindkey '^N'      kill-buffer                             # ctrl+n     delete all lines
bindkey '^_'      undo                                    # ctrl+/     undo
bindkey '^\'      redo                                    # ctrl+\     redo
# bindkey '^[[1;5A' up-line-or-beginning-search             # ctrl+up    prev cmd in global history
# bindkey '^[[1;5B' down-line-or-beginning-search           # ctrl+down  next cmd in global history
# bindkey '^ '      z4h-expand-alias                        # ctrl+space expand alias
# bindkey '^[[1;3D' z4h-cd-back                             # alt+left   cd into the prev directory
# bindkey '^[[1;3C' z4h-cd-forward                          # alt+right  cd into the next directory
# bindkey '^[[1;3A' z4h-cd-up                               # alt+up     cd ..
# bindkey '\t'      z4h-expand-or-complete-with-dots        # tab        fzf-tab completion
# bindkey '^[[1;3B' fzf-cd-widget                           # alt+down   fzf cd
# bindkey '^T'      fzf-completion                          # ctrl+t     fzf file completion
# bindkey '^R'      z4h-fzf-history-widget                  # ctrl+r     fzf history
# bindkey '^[h'     z4h-run-help                            # alt+h      help for the cmd at cursor
# bindkey '^[H'     z4h-run-help                            # alt+H      help for the cmd at cursor

bindkey '^[[1;5C'  forward-word # Ctrl+Right
bindkey '^[[1;5D' backward-word # Ctrl+Left
bindkey ';2A'        up-history # Shift+Up
bindkey ';2B'      down-history # Shift+Down
bindkey '^[[5~'      up-history # PageUp
bindkey '^[[6~'    down-history # PageDown

# Run manpage on Esc+h
autoload -Uz run-help
autoload -Uz run-help-git
autoload -Uz run-help-sudo
bindkey '^[h' run-help  # Esc+h
