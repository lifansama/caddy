#!/bin/bash
source /etc/profile

wget https://github.com/lifansama/caddy/releases/latest/download/caddy_linux_amd64.tar.zst
tar xvf caddy_linux_amd64.tar.zst

chmod +x caddy
mv caddy /usr/bin/
mkdir /etc/caddy
rm -rf caddy_linux_amd64.tar.zst

groupadd --system caddy
useradd --system \
    --gid caddy \
    --create-home \
    --home-dir /var/lib/caddy \
    --shell /usr/sbin/nologin \
    --comment "Caddy web server" \
    caddy

cat << EOF > /etc/caddy/Caddyfile
{
  servers {
    protocol {
      experimental_http3
    }
  }
}
:443, example.com
tls me@example.com
route {
  forward_proxy {
    basic_auth user pass
    hide_ip
    hide_via
    probe_resistance
  }
  file_server { root /var/www/html }
}
EOF

cat << EOF > /etc/systemd/system/caddy.service
[Unit]
Description=Caddy
Documentation=https://caddyserver.com/docs/
After=network.target network-online.target
Requires=network-online.target

[Service]
User=caddy
Group=caddy
ExecStart=/usr/bin/caddy run --environ --config /etc/caddy/Caddyfile
ExecReload=/usr/bin/caddy reload --config /etc/caddy/Caddyfile
TimeoutStopSec=5s
LimitNOFILE=1048576
LimitNPROC=512
PrivateTmp=true
ProtectSystem=full
AmbientCapabilities=CAP_NET_BIND_SERVICE

[Install]
WantedBy=multi-user.target
EOF

setcap 'cap_net_bind_service=+ep' /usr/bin/caddy

systemctl daemon-reload
systemctl enable caddy

