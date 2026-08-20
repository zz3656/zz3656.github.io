---
title: Truenas scale 虚拟机安装istoreos
cover: https://img.090227.xyz/file/ae62475a131f3734a201c.png
swiper_index: 10
top_group_index: 10
background: '#fff'
date: 2025-07-12 08:28:04
updated:
tags:
- truenas
- linux
categories:
- 操作系统
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
# Truenas scale 虚拟机安装istoreos

1. 先去 iStoreOS 官网下载 img.gz 格式的包（推荐 x86 efi ），解压得到 img 文件 istoreos.img 。然后将文件上传到 NAS ，我是上传到 `/mnt/pool4/personal`。

2. 在 TrueNAS 网页 **Datasets** 页面内 **Add Zvol** ，名字自取，大小 5GiB 就够了。(我在 pool4 下创建了名为 istoreos 的 zvol）

3. 进入 TrueNAS Shell ，执行 `ls /dev/zvol/[zvol 所在存储池]` ，（比如我的是：`ls /dev/zvol/pool4`）可以看到刚才创建的名为 istoreos 的 zvol ，那么我的 zvol 路径就是 `/dev/zvol/pool4/istoreos` 。

4. 执行 `dd if=[img文件路径] of=[zvol路径] bs=1M` ，（比如我的是：`dd if=/mnt/pool4/personal/istoreos.img of=/dev/zvol/pool4/istoreos bs=1M` ）

5. 最后安装虚拟机的时候磁盘选择这个 zvol 就行了。

6.
```
dd if=/mnt/share/openwrt/istoreos.img of=/dev/zvol/share/openwrt/isdisk bs=1M
```



```bash
docker run -itd --restart=always -p 6080:80 -e HTTP_PASSWORD=mypassword -v /root/data/docker_data/Ubuntu_desktop/dev/shm:/dev/shm dorowu/ubuntu-desktop-lxde-vnc
```

