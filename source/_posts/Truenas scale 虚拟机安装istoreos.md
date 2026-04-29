---
title: Truenas scale 虚拟机安装istoreos
date: 2025-07-12
categories:
  - 工作笔记
tags:
  - Truenas
  - iStoreOS
---

1
dd if=/mnt/share/openwrt/istoreos.img of=/dev/zvol/share/openwrt/isdisk bs=1M

1
docker run -itd --restart=always -p 6080:80 -e HTTP_PASSWORD=mypassword -v /root/data/docker_data/Ubuntu_desktop/dev/shm:/dev/shm dorowu/ubuntu-desktop-lxde-vnc