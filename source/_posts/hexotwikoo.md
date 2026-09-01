---
title: hexo 添加第三方评论模块 twikoo
swiper_index: 10
top_group_index: 10
background: '#fff'
date: 2025-07-14 05:23:30
updated:
tags:
- hexo
- twikoo
- 博客搭建
categories:
- 工作笔记
keywords:
description:
top:
top_img:
comments:
toc:
toc_number:
toc_style_simple:
copyright:
copyright_author:
copyright_author_href:
copyright_url:
copyright_info:
mathjax:
katex:
aplayer:
highlight_shrink:
aside:
ai:
---
# hexo 添加第三方评论模块 twikoo

注意

Vercel 部署的环境需配合 1.4.0 以上版本的 twikoo.js 使用

默认域名 `*.vercel.app` 在中国大陆访问速度较慢甚至无法访问，绑定自己的域名可以提高访问速度

[查看视频教程](https://www.bilibili.com/video/BV1Fh411e7ZH)

1. 申请 [MongoDB Atlas](https://twikoo.js.org/mongodb-atlas.html) 账号，获取 MongoDB 连接字符串
2. 申请 [Vercel](https://vercel.com/signup) 账号
3. 点击以下按钮将 Twikoo 一键部署到 Vercel

[![Deploy](https://vercel.com/button)](https://vercel.com/import/project?template=https://github.com/twikoojs/twikoo/tree/main/src/server/vercel-min)

1. 进入 Settings - Environment Variables，添加环境变量 `MONGODB_URI`，值为前面记录的数据库连接字符串
2. 进入 Settings - Deployment Protection，设置 Vercel Authentication 为 Disabled，并 Save

[![img](https://cdn.jsdelivr.net/gh/zz3656/picgo@main/img/vercel-1.Czytea8u.jpeg)](https://twikoo.js.org/assets/vercel-1.Czytea8u.png)

1. 进入 Deployments , 然后在任意一项后面点击更多（三个点） , 然后点击 Redeploy , 最后点击下面的 Redeploy
2. 进入 Overview，点击 Domains 下方的链接，如果环境配置正确，可以看到 “Twikoo 云函数运行正常” 的提示
3. Vercel Domains（包含 `https://` 前缀，例如 `https://xxx.vercel.app`）即为您的环境 id