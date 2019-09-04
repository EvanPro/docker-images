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
vncserver $DISPLAY

## start vncserver and noVNC webclient
echo -e "\n------------------ start noVNC  ----------------------------"
$NO_VNC_HOME/utils/launch.sh --vnc localhost:5901 --listen $NO_VNC_PORT

### resolve_vnc_connection
VNC_IP=$(hostname -i)
echo -e "\nnoVNC HTML client started:\n\t=> connect via http://$VNC_IP:$NO_VNC_PORT/?password=...\n"
