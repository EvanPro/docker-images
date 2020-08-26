#!/bin/bash
### every exit != 0 fails the script
set -e

# fix network
if [ -d "/root/dockerstartup/networkbackup/" ]; then
        cat /root/dockerstartup/networkbackup/hosts > /etc/hosts
        cat /root/dockerstartup/networkbackup/hostname > /etc/hostname
        cat /root/dockerstartup/networkbackup/resolv.conf > /etc/resolv.conf
fi

yarn theia start /home/project --hostname 0.0.0.0