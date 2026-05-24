---
title: 【CCIE学习日记】2026-05-24 | 第144天
date: 2026-05-24 21:00:00
categories: 学习笔记
tags: [CCIE, 网络, Lab]
cover: /medias/featureimages/8.jpg
---
# 【CCIE学习日记】2026-05-24 | 第144天

**阶段：Phase 3 — Lab冲刺期（第1周）**  
**今日主题：IGP配置（OSPF + EIGRP双协议融合）**  
**预计时长：2小时（完整8小时实验题的第1-2小时）**  
**学习管家：小马（Hermes Agent 智能体）**

---

## 📖 今日学习内容

### 核心知识点

1. **OSPF单区域配置**：Router-ID手动指定、邻居建立验证、DR/BDR选举规则
2. **EIGRP等价负载均衡（unequal-cost负载）**：FD/Successor/Feasible Successor分析，可变度量计算
3. **OSPF与EIGRP双向路由重分发**：seed metric设置、route-map路由控制、度量值转换
4. **RID冲突检测与解决**：虚链路解决跨区域RID问题
5. **末节网络配置**：stub/totally stub区域的区别与配置

### 重点实验拓扑

```
[R1]---[R2]---[R3]
 |       |       |
[Sw1]  [Sw2]  [Sw3]
```

- R1/R2/R3运行OSPF Area 0
- R2额外连接SW1，运行EIGRP AS 200
- 要求双向重分发，验证路由选择与 failover

---

## 📝 小测验（3题）

**Q1 [单选题]** 在OSPF邻居建立过程中，以下哪个状态表示邻居关系已经成功建立且可以交换LSA？
   A. Init  
   B. 2-way  
   C. Full  
   D. ExStart

---

**Q2 [简答题]** 描述EIGRP中Feasible Successor（可行后继路由器）的入选条件，并说明当Successor失效时，路由器的收敛过程是怎样的。

---

**Q3 [配置题]** 在Router-A上配置OSPF与EIGRP双向重分发，要求：
   - OSPF进程号=100，EIGRP AS号=200
   - 重分发时将EIGRP路由的种子metric（seed metric）设为10000
   - 只重分发子网掩码大于/24的路由
   请写出相关配置命令。

---

> 📌 答案将在明天公布。