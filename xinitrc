#!/bin/sh


if [ -f ~/.Xresources ]; then
    xrdb -load ~/.Xresources

fi


# RUN VIRTUALBOX GUEST ADDITIONS
#
if command -v VBoxClient-all >/dev/null; then
    VBoxClient-all || true

else
    VBoxClient --clipboard        || true
    VBoxClient --checkhostversion || true
    VBoxClient --display          || true  # for VBoxClient --version 5.*.*
    VBoxClient --vmsvga           || true  # for VBoxClient --version 6.*.*
    VBoxClient --seamless         || true
    VBoxClient --draganddrop      || true

fi


pkill 'aw-watcher-*'
pkill 'aw-server-*'
if command -v aw-qt >/dev/null && ! pgrep -x aw-qt >/dev/null; then
    {
        while ! pgrep py3status; do
            sleep 1
        done &
        sleep 10 && aw-qt
    } &

fi


if command -v arbtt-capture >/dev/null && ! pgrep -x arbtt-capture >/dev/null; then
    arbtt-capture &

fi


if command -v dunst >/dev/null && ! pgrep -x dunst >/dev/null; then
    dunst &

fi


if command -v compton >/dev/null && ! pgrep -x compton >/dev/null; then
    compton &

fi


if command -v i3 >/dev/null; then
    exec i3

elif command -v spectrwm >/dev/null; then
    exec spectrwm

elif command -v dwm >/dev/null; then
    while true; do
        xsetroot -name "$( date +"%F %R" )"
        sleep 1m
    done &
    exec dwm

else
    echo 'ERROR: No i3, spectrwm or dwm found!'

fi
