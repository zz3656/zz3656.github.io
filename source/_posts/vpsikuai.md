---
title: VPS安装爱快
cover: https://img.090227.xyz/file/ae62475a131f3734a201c.png
swiper_index: 10
top_group_index: 10
background: '#fff'
date: 2025-07-12 08:34:52
updated:
tags:
- vps
- ikuai
- 爱快
- 软路由
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
### VPS安装爱快

###### 步骤1:下载爱快ISO并重命名为ikuai8.iso

```
wget https://www.ikuai8.com/download.php?n=/3.x/iso/iKuai8_x32_3.7.11_Build202403051040.iso -O ikuai8.iso
```

###### 步骤2: 挂载ISO镜像

```
sudo mount ikuai8.iso /mnt
```

###### 步骤3: 复制ISO镜像启动文件

```
sudo cp -rpf /mnt/boot /
```

###### 步骤4: 重启

```
reboot
```

###### 步骤5: 在腾讯云/阿里云的操作页面打开VNC界面: 登录/远程登录 --> VNC登录，正常ISO安装爱快系统

###### 步骤6: 进入控制台"开启外网访问WEB"

o、其他选项 --> 2、开启外网访问web