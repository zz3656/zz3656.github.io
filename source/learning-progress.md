# 小马学习进度记录

> 每日学习自动记录，记录各学习源的访问情况和学到的知识点。

## 学习源状态

| 学习源 | URL | 状态 | 备注 |
|--------|-----|------|------|
| 中国社区官网 | https://hermesagent.org.cn/ | 待访问 | 网络不通，下次重试 |
| 官方文档 | https://hermes-agent.nousresearch.com/docs | 待访问 | 网络不通，下次重试 |
| 社区 MCP 文档 | https://mcp.hermesagent.org.cn/v1 | 已访问 | Streamable HTTP MCP，14篇文档全部获取 |

---

## 2025-04-30 补学记录

### 学习源1: 社区 MCP 中文文档服务 (mcp.hermesagent.org.cn/v1)

**服务信息:**
- 名称: community-mcp-docs v1.2.0
- 协议版本: 2025-03-26
- 传输方式: Streamable HTTP，基于 JSON-RPC 2.0
- 提供工具: list_docs（列文档）、get_doc（获取内容）

**学到的知识点:**

#### 1. MCP 协议概述
- MCP = Model Context Protocol（模型上下文协议），由 Anthropic 2024年11月开源
- 像 USB-C 统一设备连接一样，统一 AI 模型与外部世界的连接
- 核心价值：统一标准、安全可控、双向通信、可扩展

#### 2. MCP 架构设计
- C/S 模式，三大组件：Host（宿主）、Client（客户端）、Server（服务器）
- 四大原语：Tools（工具）、Resources（资源）、Prompts（提示词）、Sampling（采样）
- 传输层：stdio（本地）和 HTTP+SSE/Streamable HTTP（网络）

#### 3. MCP Tools（工具详解）
- 工具定义包含 name、description、inputSchema
- 调用流程：tools/call → 服务器执行 → 返回结果
- 支持文本和图片结果
- 设计原则：单一职责、清晰描述、参数校验、错误处理

#### 4. MCP Resources（资源详解）
- 支持文本、JSON、二进制（base64）资源
- 通过 resources/list 发现，resources/read 读取
- 支持资源订阅（变化通知）

#### 5. MCP 传输层
- Stdio：本地进程间通信，安全性高
- Streamable HTTP（推荐）：支持流式响应、可选 SSE 升级、JSON 批处理
- 会话管理：Mcp-Session-Id 头标识

#### 6. MCP 认证与安全
- 基于 OAuth 2.1 认证模型
- 安全实践：输入校验、权限最小化、超时控制、HTTPS、用户确认敏感操作

#### 7. MCP 服务器/客户端开发
- 支持 TypeScript、Python、Java、Go、Rust 等
- TS SDK: @modelcontextprotocol/sdk，Python SDK: mcp 包
- 进度报告、取消支持、错误恢复

#### 8. MCP 调试排错
- MCP Inspector（官方调试工具）
- 常见问题：启动失败、连接超时、工具调用失败、SSE 断开
- 推荐流程：先 Inspector 测试再集成

### 学习源2 & 3: 社区官网 & 官方文档
- 网络不通未能访问（GitHub 相关域名 443 端口超时）
- 下次学习时优先重试

### 今日总结
- 成功通过 MCP 文档服务学习了 MCP 协议的完整知识体系
- 了解了 MCP 的架构设计、四大原语、传输层、认证安全、开发指南
- 网络问题是主要障碍，hermesagent.org.cn 和官方文档站下次需要解决网络连通性

### 明日计划
- 重试访问 hermesagent.org.cn 社区官网
- 重试访问官方文档
- 深入学习 MCP 实战案例和常见问题
- 探索社区网站的其他板块（如有论坛、博客等）
