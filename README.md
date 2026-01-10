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
docker run -d \
  --name caddy \
  --restart unless-stopped \
  -p 80:80 \
  -p 443:443 \
  -p 443:443/udp \
  -v /path/to/Caddy.json:/etc/caddy/Caddy.json \
  -v caddy_data:/data \
  -v caddy_config:/config \
  ghcr.io/lifansama/caddy:latest \
  caddy run --config /etc/caddy/Caddy.json
```
