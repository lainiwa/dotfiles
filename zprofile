
[[ ! $DISPLAY && $(tty) = /dev/tty1 && $(id --group) -ne 0 ]] && exec xinit -- :1
