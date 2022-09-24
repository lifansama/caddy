#!/bin/bash
source /etc/profile
caddy version
wget -q https://github.com/lifansama/caddy/releases/latest/download/
caddy_linux_amd64.tar.zst -O - | tar xv --zstd | xargs mv -t /usr/bin
mv -f caddy /usr/bin
caddy version
service caddy restart

