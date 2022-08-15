#!/bin/bash
source /etc/profile
cd /dev/shm
rm -f caddy_linux_amd64.tar.zst
rm -f caddy
wget -q https://github.com/lifansama/caddy/releases/latest/download/caddy_linux_amd64.tar.zst
tar xvf caddy_linux_amd64.tar.zst
mv -f caddy /usr/bin
caddy version
rm -f caddy_linux_amd64.tar.zst
service caddy restart
