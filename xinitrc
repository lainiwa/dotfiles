# VBoxClient-all || true
/usr/bin/VBoxClient --clipboard        || true
/usr/bin/VBoxClient --checkhostversion || true
/usr/bin/VBoxClient --display          || true
/usr/bin/VBoxClient --seamless         || true
/usr/bin/VBoxClient --draganddrop      || true

if command -v i3 >/dev/null; then
    exec i3

else
    while true; do
        xsetroot -name "$( date +"%F %R" )"
        sleep 1m
    done &

    exec dwm

fi
