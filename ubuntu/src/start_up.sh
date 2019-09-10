#!/bin/bash
### every exit != 0 fails the script
set -e

## change vnc password
echo -e "\n------------------ change VNC password  ------------------"
# first entry is control, second is view (if only one is valid for both)
mkdir -p "$HOME/.vnc"
PASSWD_PATH="$HOME/.vnc/passwd"

if [[ -f $PASSWD_PATH ]]; then
    echo -e "\n---------  purging existing VNC password settings  ---------"
    rm -f $PASSWD_PATH
fi

echo "$VNC_PW" | vncpasswd -f >> $PASSWD_PATH
chmod 600 $PASSWD_PATH

echo -e "\n------------------ start VNC server ------------------------"
echo "remove old vnc locks to be a reattachable container"
vncserver -kill :1 \
    || rm -rfv /tmp/.X*-lock /tmp/.X11-unix \
    || echo "no locks present"
vncserver -geometry ${WIDTH:-1152}x${HEIGHT-864} :1

#start supervisor
_term() {
    while kill -0 $child >/dev/null 2>&1
    do
        kill -TERM $child 2>/dev/null
    done
}

trap _term 15 9
exec /usr/bin/supervisord -n &
child=$!
wait $child