---
title: MAC SSH功能，配合VIM编辑器对编程十分有帮助。
swiper_index: 10
top_group_index: 10
background: '#fff'
date: 2025-07-12 08:20:48
updated:
tags:
- macos
- linux
- ssh
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
# MAC SSH功能，配合VIM编辑器对编程十分有帮助。

本文来源自网络

原文链接：https://blog.csdn.net/xcg132566/article/details/78797339

MAC作为程序员的神器，在编程上的使用远超window的电脑，而MAC本身提供了SSH功能，配合VIM编辑器对编程十分有帮助。
使用ssh连接远程主机

``````bash
ssh username@192.168.100.100
``````

其中，username是登录用户名，@后接ip地址，点击确定之后输入密码即连接到远程主机。要查看当前有多少个处于登录状态的用户，可以使用who命令查看。

使用scp命令实现上传下载

## 1、从服务器上下载文件 

```bash
scp username@servername:/path/filename /Users/mac/Desktop（本地目录）
```



例如:scp root@123.207.170.40:/root/test.txt /Users/mac/Desktop就是将服务器上的/root/test.txt下载到本地的/Users/mac/Desktop目录下。注意两个地址之间有空格！

## 2、上传本地文件到服务器 

```bash
scp /path/filename username@servername:/path ;
```



例如scp /Users/mac/Desktop/test.txt root@123.207.170.40:/root/

## 3、从服务器下载整个目录 

```bash
scp -r username@servername:/root/（远程目录） /Users/mac/Desktop（本地目录）
```



例如:scp -r root@192.168.0.101:/root/ /Users/mac/Desktop/

## 4、上传目录到服务器 

```bash
scp -r local_dir username@servername:remote_dir
```



例如：scp -r test root@192.168.0.101:/root/ 把当前目录下的test目录上传到服务器的/root/ 目录

注：目标服务器要开启写入权限。
————————————————

