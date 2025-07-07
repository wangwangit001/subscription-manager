#!/bin/bash

# 订阅管理系统 - CloudFlare Workers 部署脚本

echo "🚀 开始部署订阅管理系统到 CloudFlare Workers..."

# 检查是否安装了 wrangler
if ! command -v wrangler &> /dev/null; then
    echo "❌ 未找到 wrangler，正在安装..."
    npm install -g wrangler
fi

# 检查是否已登录
echo "🔐 检查 CloudFlare 登录状态..."
if ! wrangler whoami &> /dev/null; then
    echo "📝 请登录 CloudFlare 账户..."
    wrangler login
fi

# 创建 KV 命名空间
echo "📦 创建 KV 命名空间..."
echo "正在创建生产环境 KV 命名空间..."
PROD_KV=$(wrangler kv:namespace create SUBSCRIPTIONS_KV --json | jq -r '.id')

echo "正在创建预览环境 KV 命名空间..."
PREVIEW_KV=$(wrangler kv:namespace create SUBSCRIPTIONS_KV --preview --json | jq -r '.id')

# 更新 wrangler.toml
echo "⚙️ 更新配置文件..."
sed -i "s/your-production-kv-namespace-id/$PROD_KV/g" wrangler.toml
sed -i "s/your-preview-kv-namespace-id/$PREVIEW_KV/g" wrangler.toml

echo "✅ KV 命名空间配置完成："
echo "   生产环境 ID: $PROD_KV"
echo "   预览环境 ID: $PREVIEW_KV"

# 部署到 CloudFlare Workers
echo "🚀 部署到 CloudFlare Workers..."
wrangler deploy

if [ $? -eq 0 ]; then
    echo ""
    echo "🎉 部署成功！"
    echo ""
    echo "📋 接下来的步骤："
    echo "1. 访问您的 Worker URL"
    echo "2. 使用默认账户登录："
    echo "   用户名: admin"
    echo "   密码: password"
    echo "3. 进入系统配置修改默认密码"
    echo "4. 配置通知渠道"
    echo ""
    echo "🔗 Worker URL: https://subscription-manager.your-subdomain.workers.dev"
    echo ""
    echo "📚 详细文档: https://github.com/your-username/subscription-manager"
else
    echo "❌ 部署失败，请检查错误信息"
    exit 1
fi
