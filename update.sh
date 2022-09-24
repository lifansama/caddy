#!/bin/bash
source /etc/profile
cd /dev/shm
rm -f caddy_linux_amd64.tar.zst
rm -f caddy
caddy version
wget -q https://github.com/lifansama/caddy/releases/latest/download/caddy_linux_amd64.tar.zst -O - | tar xvf
mv -f caddy /usr/bin
caddy version
service caddy restart

