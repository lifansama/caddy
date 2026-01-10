FROM golang:alpine AS builder

RUN apk add --no-cache git
RUN go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest

RUN xcaddy build \
    --with github.com/caddyserver/forwardproxy@caddy2=github.com/klzgrad/forwardproxy@naive \
    --with github.com/mholt/caddy-l4

FROM caddy:alpine

RUN apk add --no-cache libcap
COPY --from=builder /go/caddy /usr/bin/caddy
RUN setcap cap_net_bind_service=+ep /usr/bin/caddy
RUN caddy version

USER caddy
