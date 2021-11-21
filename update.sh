#!/bin/bash
source /etc/profile
rm -rf caddy.tar.zst
rm -rf caddy
tag=$(wget -qO- -t1 -T2 "https://api.github.com/repos/lifansama/caddy/releases/latest" | grep "tag_name" | head -n 1 | awk -F ":" '{print $2}' | sed 's/\"//g;s/,//g;s/ //g')
wget https://github.com/lifansama/caddy/releases/download/$tag/caddy.tar.zst
tar xvf caddy.tar.zst
rm -rf /usr/bin/caddy
mv caddy /usr/bin
chmod +x /usr/bin/caddy
service caddy restart
