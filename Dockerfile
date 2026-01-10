# 第一阶段：编译阶段
FROM golang:alpine AS builder

RUN apk add --no-cache git
RUN go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest

RUN xcaddy build \
    --with github.com/caddyserver/forwardproxy@caddy2=github.com/klzgrad/forwardproxy@naive \
    --with github.com/mholt/caddy-l4

# 第二阶段：运行阶段
FROM caddy:alpine

# 安装 libcap 用于设置能力
RUN apk add --no-cache libcap

# 从编译阶段拷贝生成的二进制文件
COPY --from=builder /go/caddy /usr/bin/caddy

# 关键步骤：
# 1. 赋予 caddy 监听特权端口的能力
# 2. 确保 caddy 用户（UID 1000）有权运行该二进制文件
RUN setcap cap_net_bind_service=+ep /usr/bin/caddy

# 切换到非 root 用户 (caddy 用户在官方镜像中默认 UID 为 1000)
USER caddy

# 验证
RUN caddy version
