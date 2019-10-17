#!/bin/bash
### every exit != 0 fails the script
set -e

ENABLE_SSH=${ENABLE_SSH:-true}
ENABLE_VNC=${ENABLE_VNC:-true}

## fix network config
if [ -d "/root/dockerstartup/networkbackup/" ]; then
    cat /root/dockerstartup/networkbackup/hosts > /etc/hosts
    cat /root/dockerstartup/networkbackup/hostname > /etc/hostname
    cat /root/dockerstartup/networkbackup/resolv.conf > /etc/resolv.conf
fi

SSH_CONF=/etc/supervisor/conf.d/sshd.conf
VNC_CONF=/etc/supervisor/conf.d/vncserver.conf

# start ssh
if [[ "$ENABLE_SSH" == "true" ]] ; then
    if [ ! -f $SSH_CONF ] ; then
        cp /root/dockerstartup/modes/sshd.conf /etc/supervisor/conf.d/
    fi
fi

# start vnc server
if [[ "$ENABLE_VNC" == "true" ]] ; then
    if [ ! -f $VNC_CONF ] ; then
        echo "remove old vnc locks to be a reattachable container"
        vncserver -kill :1 \
            || rm -rfv /tmp/.X*-lock /tmp/.X11-unix \
            || echo "no locks present"

        cp /root/dockerstartup/modes/vncserver.conf /etc/supervisor/conf.d/
        sed -i "s/1152/${WIDTH:-1152}/g" $VNC_CONF
        sed -i "s/864/${HEIGHT:-864}/g" $VNC_CONF
    fi
fi

# Forward SIGTERM to supervisord process
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