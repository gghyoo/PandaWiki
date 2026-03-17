#!/bin/sh
set -e

# 如果 ssl 目录（bind mount）中尚无证书（首次启动，API 还未生成真实证书），
# 则先用内置占位证书初始化，确保 nginx 能正常启动。
# API 生成真实证书后，reload 信号会令 nginx 自动加载新证书。
if [ ! -f /etc/nginx/ssl/panda-wiki.crt ] || [ ! -f /etc/nginx/ssl/panda-wiki.key ]; then
    echo "⚡ SSL 证书不存在，使用内置占位证书初始化..."
    cp /docker-ssl-defaults/panda-wiki.crt /etc/nginx/ssl/
    cp /docker-ssl-defaults/panda-wiki.key /etc/nginx/ssl/
fi

exec nginx -g 'daemon off;'
