#!/bin/bash
source /etc/profile
cd /dev/shm
rm -f caddy
caddy version
wget -q https://github.com/lifansama/caddy/releases/latest/download/caddy_linux_amd64.tar.zst -O - | tar xv --zstd
mv -f caddy /usr/bin
caddy version
service caddy restart

