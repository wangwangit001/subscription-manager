@echo off
chcp 65001 >nul
echo 🚀 开始部署订阅管理系统到 CloudFlare Workers...

REM 检查是否安装了 Node.js
where node >nul 2>nul
if %errorlevel% neq 0 (
    echo ❌ 未找到 Node.js，请先安装 Node.js
    echo 下载地址: https://nodejs.org/
    pause
    exit /b 1
)

REM 检查是否安装了 wrangler
where wrangler >nul 2>nul
if %errorlevel% neq 0 (
    echo ❌ 未找到 wrangler，正在安装...
    npm install -g wrangler
)

echo 🔐 检查 CloudFlare 登录状态...
wrangler whoami >nul 2>nul
if %errorlevel% neq 0 (
    echo 📝 请登录 CloudFlare 账户...
    wrangler login
)

echo 📦 创建 KV 命名空间...
echo 正在创建生产环境 KV 命名空间...
wrangler kv:namespace create SUBSCRIPTIONS_KV

echo 正在创建预览环境 KV 命名空间...
wrangler kv:namespace create SUBSCRIPTIONS_KV --preview

echo.
echo ⚠️  请手动更新 wrangler.toml 文件中的 KV 命名空间 ID
echo    将上面输出的 ID 替换到 wrangler.toml 文件中对应位置
echo.
pause

echo 🚀 部署到 CloudFlare Workers...
wrangler deploy

if %errorlevel% equ 0 (
    echo.
    echo 🎉 部署成功！
    echo.
    echo 📋 接下来的步骤：
    echo 1. 访问您的 Worker URL
    echo 2. 使用默认账户登录：
    echo    用户名: admin
    echo    密码: password
    echo 3. 进入系统配置修改默认密码
    echo 4. 配置通知渠道
    echo.
    echo 📚 详细文档请查看 DEPLOY.md
) else (
    echo ❌ 部署失败，请检查错误信息
)

pause
