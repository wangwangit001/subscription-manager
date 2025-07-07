# 订阅管理系统

基于 CloudFlare Workers 的智能订阅管理和提醒系统，支持农历显示、多渠道通知、企业微信应用通知等功能。

## ✨ 功能特色

### 🎯 核心功能
- **订阅管理**：添加、编辑、删除各类订阅服务
- **智能提醒**：自定义提前提醒天数，自动续订计算
- **农历显示**：支持农历日期显示，可控制开关
- **状态管理**：订阅启用/停用，过期状态自动识别

### 📱 多渠道通知
- **Telegram**：支持 Telegram Bot 通知
- **NotifyX**：集成 NotifyX 推送服务
- **企业微信应用通知**：支持企业微信应用推送
- **自定义 Webhook**：支持自定义请求格式和模板

### 🌙 农历功能
- **农历转换**：支持 1900-2100 年农历转换
- **智能显示**：列表和编辑页面可控制农历显示
- **通知集成**：通知消息中可包含农历信息

### 🎨 用户体验
- **响应式设计**：完美适配桌面端和移动端
- **备注优化**：长备注自动截断，悬停显示完整内容
- **实时预览**：日期选择时实时显示对应农历
- **用户偏好**：记住用户的显示偏好设置

## 🚀 一键部署

### 部署到 CloudFlare Workers

[![Deploy to Cloudflare Workers](https://deploy.workers.cloudflare.com/button)](https://deploy.workers.cloudflare.com/?url=https://github.com/wangwangit001/notify)

### GitHub Actions 自动部署

1. **Fork 此仓库**
2. **设置 GitHub Secrets**：
   - `CLOUDFLARE_API_TOKEN`
   - `CLOUDFLARE_ACCOUNT_ID`
3. **推送代码自动部署**

详细部署说明请查看 [DEPLOY.md](./DEPLOY.md)

## 📋 快速开始

### 1. 部署系统
按照上述部署方式选择一种进行部署

### 2. 首次登录
- 访问部署后的域名
- 默认用户名：`admin`
- 默认密码：`password`

### 3. 基础配置
1. **修改管理员密码**
2. **配置通知渠道**（选择一个或多个）：
   - Telegram：需要 Bot Token 和 Chat ID
   - NotifyX：需要 API Key
   - 企业微信应用通知：需要推送 URL
3. **测试通知功能**

### 4. 添加订阅
1. 点击"添加新订阅"
2. 填写订阅信息
3. 设置提醒天数
4. 保存并测试

## 🔧 配置说明

### 通知渠道配置

#### Telegram
```
Bot Token: 从 @BotFather 获取
Chat ID: 从 @userinfobot 获取
```

#### NotifyX
```
API Key: 从 https://www.notifyx.cn/ 获取
```

#### 企业微信应用通知
```
推送 URL: 从 https://push.996007.icu 获取
支持自定义请求头和消息模板
```

### 定时任务
系统默认每天早上 8 点检查即将到期的订阅，可在 `wrangler.toml` 中修改：

```toml
[triggers]
crons = ["0 8 * * *"]  # 每天早上8点
```

## 📱 第三方 API

系统提供第三方 API 接口，支持外部系统发送通知：

```bash
POST /api/notify/{code}
Content-Type: application/json

{
  "title": "通知标题",
  "content": "通知内容"
}
```

## 🎨 界面预览

### 订阅列表
- 清晰的订阅状态显示
- 农历日期可控显示
- 响应式表格布局
- 智能备注截断

### 编辑页面
- 实时农历显示
- 自动到期日期计算
- 用户偏好记忆

### 配置页面
- 多渠道通知配置
- 全局农历显示控制
- 实时配置测试

## 🔄 更新日志

### v2.0.0 - 2025-07-06

#### 🎉 新功能
- ✅ 农历日期显示功能
- ✅ 多渠道通知支持
- ✅ 企业微信应用通知
- ✅ 第三方 API 接口
- ✅ 备注显示优化
- ✅ 响应式界面优化

#### 🔧 改进
- ✅ 配置保存优化
- ✅ 用户体验提升
- ✅ 移动端适配

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 📄 许可证

MIT License

## 🙏 致谢

- [CloudFlare Workers](https://workers.cloudflare.com/) - 强大的边缘计算平台
- [Tailwind CSS](https://tailwindcss.com/) - 优秀的 CSS 框架
- [Font Awesome](https://fontawesome.com/) - 丰富的图标库

---

**如果这个项目对您有帮助，请给个 ⭐ Star 支持一下！**
