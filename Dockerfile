# --- 阶段 1: 构建阶段 ---
FROM golang:alpine AS builder

# 1. 安装必要的构建工具
RUN apk add --no-cache git

# 2. 安装 xcaddy
RUN go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest

# 3. 编译 Caddy
ENV XCADDY_LDFLAGS="-s -w"
RUN xcaddy build \
    --with github.com/caddyserver/forwardproxy@caddy2=github.com/klzgrad/forwardproxy@naive \
    --with github.com/mholt/caddy-l4 \
    --output /usr/bin/caddy

# --- 阶段 2: 运行阶段 ---
# 使用干净的 alpine 避免 caddy:alpine 的镜像层重叠
FROM alpine:latest

# 1. 安装运行 Caddy 必需的最小依赖
# ca-certificates: 处理 HTTPS 证书必备
# libcap: 用于 setcap，允许非 root 用户监听 443 端口
RUN apk add --no-cache ca-certificates libcap

# 2. 创建 caddy 用户和组
RUN addgroup -S caddy && \
    adduser -S caddy -G caddy && \
    mkdir -p /config /data && \
    chown -R caddy:caddy /config /data

# 3. 从构建阶段只拷贝这一个二进制文件
COPY --from=builder /usr/bin/caddy /usr/bin/caddy

# 4. 权限设置：允许 caddy 用户绑定低位端口
RUN setcap cap_net_bind_service=+ep /usr/bin/caddy

# 5. 设置 Caddy 默认的环境变量路径
ENV XDG_CONFIG_HOME=/config
ENV XDG_DATA_HOME=/data

USER caddy

# 工作目录
WORKDIR /srv

# 默认启动命令 (可根据你的 Caddyfile 路径调整)
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
