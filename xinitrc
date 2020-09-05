# VBoxClient-all || true
/usr/bin/VBoxClient --clipboard        || true
/usr/bin/VBoxClient --checkhostversion || true
/usr/bin/VBoxClient --display          || true  # for VBoxClient --version 5.*.*
/usr/bin/VBoxClient --vmsvga           || true  # for VBoxClient --version 6.*.*
/usr/bin/VBoxClient --seamless         || true
/usr/bin/VBoxClient --draganddrop      || true

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
    echo 'ERROR: No i3 or dwm found!'

fi
