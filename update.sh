#!/bin/bash
source /etc/profile
rm -rf caddy_linux_amd64.tar.zst
rm -rf caddy
wget https://github.com/lifansama/caddy/releases/latest/download/caddy_linux_amd64.tar.zst
tar xvf caddy_linux_amd64.tar.zst
rm -rf /usr/bin/caddy
mv caddy /usr/bin
chmod +x /usr/bin/caddy
caddy version
service caddy restart
rm -rf caddy_linux_amd64.tar.zst
rm -rf caddy

