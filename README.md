# caddy 

[![Caddy Build](https://github.com/lifansama/caddy/actions/workflows/caddy.yml/badge.svg?branch=master)](https://github.com/lifansama/caddy/actions/workflows/caddy.yml)

Build Self-use Caddy Automatically.


```
apt install -y zstd
tar xvf caddy_windows_amd64.tar.zst
```

```
curl https://raw.githubusercontent.com/lifansama/caddy/master/update.sh | bash
```

## Run with Docker
```
mkdir -p /etc/caddy/data
mkdir -p /etc/caddy/config
chown -R 1000:1000 /etc/caddy
```

```
docker run -d --name caddy --network host --restart unless-stopped --user 1000:1000 -v /etc/caddy/caddy.json:/etc/caddy/caddy.json:Z -v /etc/caddy/data:/data:Z -v /etc/caddy/config:/config:Z ghcr.io/lifansama/caddy:latest caddy run --config /etc/caddy/caddy.json
```
