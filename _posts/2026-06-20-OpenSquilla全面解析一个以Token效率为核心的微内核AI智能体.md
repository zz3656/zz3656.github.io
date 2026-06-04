# OpenSquilla 全面解析：一个以Token效率为核心的微内核AI智能体运行时

> 本文基于 [OpenSquilla 官方文档](https://github.com/opensquilla/opensquill) 0.3.x 版本整理翻译，供中文社区参考。

---

## 一、项目概述

**OpenSquilla** 是一个**以Token效率为核心理念的微内核AI智能体**，专为命令行终端、本地Web UI和聊天渠道设计。它的核心设计理念可以用一句话概括：

> **相同的预算，更强的能力，更好的结果。**

它提供了一个统一的往返交互循环（turn loop），让所有入口——Web UI、CLI、以及各聊天渠道——都通过相同的路径运行，确保工具调度、重试机制和决策日志在所有界面下行为一致。

### 核心架构

- **本地模型路由器（SquillaRouter）**：智能地将每个请求分派到最便宜的、能处理该任务的模型
- **持久化记忆**：跨会话持久存储用户偏好、项目事实、决策记录
- **分层沙箱**：安全的工具执行环境，支持人工审批流程
- **内置网络搜索**：支持 Brave Search、DuckDuckGo 等多种搜索提供商
- **设备端嵌入（Embeddings）**：本地语义搜索，无需外部服务
- **多提供商支持**：支持 OpenRouter、OpenAI、Anthropic、Ollama、DeepSeek、Gemini、通义千问/DashScope 等 20+ LLM 提供商，无需修改代码或配置

---

## 二、核心功能特性

### 2.1 SquillaRouter —— 本地模型路由

这是 OpenSquilla 的亮点功能之一。它是一个**纯本地的模型路由层**，根据任务复杂度自动选择合适层级的模型：

- 简单聊天、编辑、摘要等低复杂度任务 → 使用便宜模型
- 复杂推理、恢复处理、长任务 → 分配更强模型

**关键特性：**
- 路由决策完全在设备本地完成，用户的提示词**不会**发送到外部分类器来决定模型
- 支持多个路由器配置文件：`recommended`（推荐）、`openrouter-mix`（混合）、`disabled`（禁用路由，使用单一模型）
- 可根据配置影响：选定模型层级、直接模型回退、推理级别、响应策略、图像模型选择等

```bash
# 启用推荐路由
opensquilla onboard --router recommended

# 重新配置路由器
opensquilla configure router --router recommended
```

### 2.2 工具压缩（Tool Compression）

智能体在执行工具调用时可能产生巨大的输出：日志、网页、搜索结果、JSON、差异对比、文件内容等。工具压缩功能确保这些输出**仍然可用但不会淹没模型上下文**。

**支持的压缩模式：**

| 模式 | 最佳场景 | 权衡 |
|------|---------|------|
| `truncate`（截断） | 快速的确定性预览 | 可能遗漏中间有用内容 |
| `summarize`（摘要） | 慢速/后台工作流，受益于语义摘要 | 需要额外一次模型调用 |
| 结构化投影 | 日志、差异、JSON、表格等已知工具格式 | 取决于该输出类型的缩减器覆盖范围 |

**用户会看到什么：**
- 紧凑预览
- 结果已被缩短的提示
- 指向带外存储结果的 `tool_result_handle`
- 估算的Token节省诊断信息

### 2.3 MetaSkills —— 可复用的多步骤工作流

MetaSkill 允许将**可重复的多步骤工作流程**打包为可检查、可提议、可回放、可复用的技能。适用于：

- 可重复的研究报道
- 文档到决策的工作
- 每日运营简报
- 账户监控
- 求职准备
- 儿童项目规划
- 学术论文撰写
- MetaSkill 提案创建

**内置的稳定 MetaSkill：**
- `meta-web-research-to-report` — 网络研究生成报告
- `meta-daily-operator-brief` — 每日运营简报
- `meta-document-to-decision` — 文档到决策
- `meta-job-search-pipeline` — 求职流水线
- `meta-kid-project-planner` — 儿童项目规划
- `meta-paper-write` — 论文撰写
- `meta-skill-creator` — 技能创建

**使用方式（两种方式）：**

1. **自然委托**：直接描述期望结果，OpenSquilla 根据当前意图自动选择最合适的 MetaSkill。
2. **显式委托**：直接指定技能名称，更加稳定可靠。

```text
使用 meta-skill `meta-web-research-to-report`。
为我父母8天的日本旅行，比较旅行eSIM、运营商漫游和本地SIM方案，并生成来源支持的决策备忘录。
```

### 2.4 持久化记忆系统

OpenSquilla 的记忆系统帮助智能体**跨会话回忆有用的上下文**，而无需重播每段旧对话。

**适合存储的内容：**
- 用户偏好
- 项目约定
- 重复输出的格式
- 重要仓库、目录或服务的名称
- 用户希望复用的决策
- 已完成任务的简要笔记

**不应存储在记忆中的内容：**
- API 密钥或秘密信息
- 不需要长期记忆的原始私人数据
- 当前对话的一次性指令
- 会污染未来检索的杂乱数据

```bash
# 检查记忆健康状态
opensquilla memory status
opensquilla memory status --deep

# 索引和列出记忆源
opensquilla memory index

# 搜索记忆
opensquilla memory search "发布笔记格式"

# 将会话状态刷入记忆
opensquilla memory flush-session <session_id>
```

### 2.5 多通道支持（Channels）

OpenSquilla 支持从多种消息平台运行同一智能体，所有渠道共享相同的主机运行时。

**支持的渠道类型：**

| 类型 | 标签 | 传输方式 | 需要公网URL |
|------|------|---------|------------|
| `dingtalk` | 钉钉 | websocket | 否 |
| `discord` | Discord | websocket | 否 |
| `feishu` | 飞书/Lark | 混合 | 取决于模式 |
| `matrix` | Matrix | websocket | 否 |
| `qq` | QQ Bot | websocket | 否 |
| `slack` | Slack | 混合 | 取决于模式 |
| `telegram` | Telegram | 混合 | 取决于模式 |
| `wecom` | 企业微信 | webhook | 是 |

```bash
# 查看所有支持的渠道类型
opensquilla channels types --json

# 交互配置
opensquilla configure channels

# 添加具体渠道
opensquilla channels add telegram --name personal
```

### 2.6 调度系统（Scheduling）

通过 `cron` 命令组管理计划的 OpenSquilla 运行：

```bash
# 列出所有计划任务
opensquilla cron list

# 添加定时任务
opensquilla cron add \
  --every 1h \
  --text "汇总重要的项目更新" \
  --name hourly-project-check

# 查看任务状态
opensquilla cron status
```

---

## 三、安装与配置

### 系统要求

- Python 3.12 或更高版本
- `uv`（推荐的包管理器）
- 除使用 Ollama 等本地提供商外，需要一个提供商的 API 密钥

### 推荐安装方式

```bash
uv tool install --python 3.12 "opensquilla[recommended] @ \
    git+https://github.com/opensquilla/opensquilla.git@main"
```

### 首次配置

```bash
# 启动配置向导
opensquilla onboard

# 配置提供商
opensquilla configure provider --provider openrouter --api-key-env OPENROUTER_API_KEY

# 配置路由器
opensquilla configure router --router recommended

# 配置搜索
opensquilla configure search --search-provider brave --api-key-env BRAVE_SEARCH_API_KEY

# 启动网关
opensquilla gateway run
```

### 配置加载顺序

1. `OPENSQUILLA_GATEWAY_CONFIG_PATH` 环境变量指定的路径
2. `./opensquilla.toml`（项目本地）
3. `~/.opensquilla/config.toml`（用户配置）
4. 内置默认值

### 启动网关

```bash
# 前台运行
opensquilla gateway run

# 后台启动（带就绪等待）
opensquilla gateway start --json

# 检查状态
opensquilla gateway status

# 停止/重启
opensquilla gateway stop
opensquilla gateway restart
```

默认访问地址：**http://127.0.0.1:18791/control/**

---

## 四、安全与权限

OpenSquilla 默认将网关绑定到 `127.0.0.1`（仅本地回环），这是**安全默认值**。暴露到公共接口需要手动选择加入：

```bash
# 仅在受控网络中
opensquilla gateway run --listen 0.0.0.0 --port 18791
```

**安全特性包括：**
- 敏感工具调用可暂停等待人工审批
- 每个往返和会话的Token及成本汇总（`opensquilla cost`）
- 沙箱隔离执行
- 分层权限控制

---

## 五、产品特性总览

| 能力 | 用户获得什么 |
|------|------------|
| **SquillaRouter** | 本地设备路由，根据每轮任务复杂度选择合适模型层级，简单任务避免使用高级模型 |
| **工具压缩** | 大型工具输出保持可用但不会淹没模型上下文；保留原始结果，发送紧凑预览 |
| **MetaSkills** | 可复用的工作流，将重复的多步骤工作打包为可复用的智能体程序 |
| **持久化会话** | 对话、转录、压缩摘要、产物、成本和回放数据持久保存，可随时检查 |
| **个人记忆** | 通过本地关键词和语义搜索保存和回顾用户事实、笔记和任务轨迹 |
| **多提供商运行时** | 通过统一配置schema配置 OpenRouter、OpenAI、Anthropic、Gemini、DeepSeek、DashScope、Ollama 等后端 |
| **安全的工具使用** | 文件、shell、网络、记忆、git、产物、媒体、渠道和智能体工具，均有策略层和审批面保护 |
| **统一界面** | CLI、Web UI、网关RPC和渠道共享相同的路径、工具、记忆、审批和用量计费 |

---

## 六、状态检查与诊断

安装完成后，运行以下命令检查就绪状态：

```bash
# 诊断检查
opensquilla doctor

# 查看提供商和模型
opensquilla providers list
opensquilla providers status

# 查看搜索配置
opensquilla search list

# 查看渠道类型
opensquilla channels types --json

# 查看网关状态
opensquilla gateway status

# 查看记忆状态
opensquilla memory status
```

---

## 七、总结

OpenSquilla 是一个设计精良的**个人智能体运行时**，它专注于几个关键问题：

1. **成本效率**：通过本地模型路由，让简单任务使用便宜模型，节省Token成本
2. **上下文管理**：通过工具压缩和记忆系统，避免大输出淹没模型上下文
3. **可复用性**：通过 MetaSkills 将重复工作打包为可复用流程
4. **统一体验**：CLI、Web UI、多渠道共享同一运行时，一个入口全场景覆盖
5. **安全可靠**：默认本地绑定、人工审批、沙箱隔离

对于想要**在本地部署一个功能完整、成本可控的AI智能体**的个人开发者和团队来说，OpenSquilla 是目前开源社区中极具竞争力的选择。

---

*原文参考：[OpenSquilla GitHub](https://github.com/opensquilla/opensquilla)*
*本文档基于 0.3.0 版本翻译整理，仅供学习参考。*
