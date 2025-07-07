# 订阅管理系统 - CloudFlare Workers 一键部署指南

## 🚀 快速部署

### 方法一：GitHub Actions 自动部署（推荐）

#### 1. 准备工作

1. **Fork 或 Clone 此仓库到您的 GitHub 账户**

2. **获取 CloudFlare API Token**
   - 登录 [CloudFlare Dashboard](https://dash.cloudflare.com/)
   - 进入 `My Profile` > `API Tokens`
   - 点击 `Create Token`
   - 使用 `Custom token` 模板，设置权限：
     - `Account` - `Cloudflare Workers:Edit`
     - `Zone` - `Zone:Read` (如果使用自定义域名)
     - `Account Resources` - `Include All accounts`

3. **获取 Account ID**
   - 在 CloudFlare Dashboard 右侧边栏可以找到 Account ID

4. **创建 KV 命名空间**
   ```bash
   # 安装 wrangler (如果还没安装)
   npm install -g wrangler
   
   # 登录 CloudFlare
   wrangler login
   
   # 创建 KV 命名空间
   wrangler kv:namespace create SUBSCRIPTIONS_KV
   wrangler kv:namespace create SUBSCRIPTIONS_KV --preview
   ```

#### 2. 配置 GitHub Secrets

在您的 GitHub 仓库中设置以下 Secrets：
- 进入仓库 `Settings` > `Secrets and variables` > `Actions`
- 添加以下 Repository secrets：

```
CLOUDFLARE_API_TOKEN=your_api_token_here
CLOUDFLARE_ACCOUNT_ID=your_account_id_here
```

#### 3. 更新配置文件

编辑 `wrangler.toml` 文件，替换 KV 命名空间 ID：

```toml
[[kv_namespaces]]
binding = "SUBSCRIPTIONS_KV"
preview_id = "your_preview_kv_namespace_id"  # 替换为实际的预览 ID
id = "your_production_kv_namespace_id"       # 替换为实际的生产 ID
```

#### 4. 部署

推送代码到 `main` 或 `master` 分支，GitHub Actions 将自动部署：

```bash
git add .
git commit -m "Deploy subscription manager"
git push origin main
```

### 方法二：本地手动部署

#### 1. 安装依赖

```bash
npm install
```

#### 2. 登录 CloudFlare

```bash
wrangler login
```

#### 3. 创建 KV 命名空间

```bash
npm run kv:create
npm run kv:create:preview
```

#### 4. 更新 wrangler.toml

将创建的 KV 命名空间 ID 更新到 `wrangler.toml` 文件中。

#### 5. 部署

```bash
# 部署到生产环境
npm run deploy

# 或部署到测试环境
npm run deploy:staging
```

## 🔧 配置说明

### 环境变量

可以在 CloudFlare Dashboard 的 Workers 设置中添加环境变量：

- `ADMIN_USERNAME`: 管理员用户名（默认：admin）
- `ADMIN_PASSWORD`: 管理员密码（默认：password）
- `JWT_SECRET`: JWT 密钥（建议设置复杂密钥）

### 定时任务

系统默认配置每天早上8点检查即将到期的订阅：

```toml
[triggers]
crons = ["0 8 * * *"]
```

可以根据需要修改 cron 表达式：
- `0 */6 * * *` - 每6小时检查一次
- `0 9,18 * * *` - 每天9点和18点检查
- `0 8 * * 1-5` - 工作日早上8点检查

### 自定义域名

1. 在 CloudFlare Dashboard 中添加自定义域名
2. 在 `wrangler.toml` 中添加路由配置：

```toml
[env.production]
name = "subscription-manager"
routes = [
  { pattern = "your-domain.com/*", custom_domain = true }
]
```

## 🎯 部署后配置

1. **访问系统**：`https://your-worker.your-subdomain.workers.dev`

2. **首次登录**：
   - 用户名：`admin`
   - 密码：`password`

3. **修改默认密码**：
   - 登录后进入 `系统配置`
   - 修改管理员密码

4. **配置通知渠道**：
   - 配置 Telegram、NotifyX 或企业微信应用通知
   - 测试通知功能

## 🔄 更新部署

### 自动更新（GitHub Actions）

推送新代码到主分支即可自动部署：

```bash
git add .
git commit -m "Update features"
git push origin main
```

### 手动更新

```bash
git pull origin main
npm run deploy
```

## 🐛 故障排除

### 常见问题

1. **KV 命名空间错误**
   - 确保 `wrangler.toml` 中的 KV ID 正确
   - 检查 KV 命名空间是否已创建

2. **API Token 权限不足**
   - 确保 Token 有 `Cloudflare Workers:Edit` 权限
   - 检查 Account ID 是否正确

3. **定时任务不工作**
   - 检查 cron 表达式格式
   - 确保 Workers 已正确部署

### 查看日志

```bash
# 实时查看 Worker 日志
npm run tail

# 或使用 wrangler 直接查看
wrangler tail
```

## 📞 支持

如果遇到部署问题，请：

1. 检查 GitHub Actions 的运行日志
2. 查看 CloudFlare Workers 的实时日志
3. 确认所有配置文件格式正确
4. 验证 API Token 和权限设置

## 🎉 部署成功

部署成功后，您将拥有一个功能完整的订阅管理系统，包括：

- ✅ 订阅管理和提醒
- ✅ 农历日期显示
- ✅ 多渠道通知支持
- ✅ 企业微信应用通知
- ✅ 第三方 API 接口
- ✅ 响应式界面设计
- ✅ 自动定时检查
