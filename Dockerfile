# 第一阶段：编译阶段 (使用最新的 Go Alpine 镜像)
FROM golang:alpine AS builder

# 安装编译工具和 xcaddy
RUN apk add --no-cache git
RUN go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest

# 编译 Caddy：包含 NaiveProxy 和 L4 模块
RUN xcaddy build \
    --with github.com/caddyserver/forwardproxy@caddy2=github.com/klzgrad/forwardproxy@naive \
    --with github.com/mholt/caddy-l4

# 第二阶段：运行阶段
FROM caddy:alpine

# 从编译阶段拷贝生成的 caddy 二进制文件到系统路径
COPY --from=builder /go/caddy /usr/bin/caddy

# 验证安装版本
RUN caddy version
