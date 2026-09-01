---
title: 各云盘VPS写入ROS方法
cover: https://img.090227.xyz/file/ae62475a131f3734a201c.png
swiper_index: 10
top_group_index: 10
background: '#fff'
date: 2025-07-12 08:08:02
updated:
tags: [routeros, ros, 软路由]
_img:
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
# 各云盘VPS写入ROS方法

 转自：2023/12/08 12:34 [无线路由类](http://a57068368.3322.org:880/category-2.html) 43 0

先在VPS上安装debian12
下载routeros的CHR镜像

代码:

```bash
wget https://download.mikrotik.com/routeros/7.15.2/chr-7.15.2.img.zip
```

 说明，最新的下载地址请参考

https://mikrotik.com/download
需要下载 Cloud Hosted Router类别下的 Raw disk image

解压镜像

```bash
unzip chr-7.15.2.img.zip
```

 把chr-6.48.3.img文件名改为为chr.img

```bash
mv chr-7.15.2.img chr.img
```

 查看镜像的Start值

```bash
fdisk -lu chr.img
```

 如果Start值不是1， 那么请注意下面的命令.

挂载镜像

```bash
mount -o loop,offset=512 chr.img /mnt
```

 如果上面Start值不是1, 那么请用值乘以512.

如果是2, 那么offset=1024
RouterOS v7.x的Start值为34
那么代码应该是

代码:

```bash
mount -o loop,offset=33571840 chr.img /mnt
```

 获取IP信息和设置变量

```bash
ADDR0=`ip addr show ens3 | grep global | cut -d' ' -f 6 | head -n 1`

GATE0=`ip route list | grep default | cut -d' ' -f 3`
```

 注意，这里的网卡名称是eth0, 如果不是eth0, 那么根据自己的VPS网卡信息更改.

查询方法, ifconfig, 看看这个网卡名称

创建目录

```bash
mkdir -p /mnt/rw
```

 设置routeros开机的时候自动设置网络信息

```bash
echo "/ip address add address=$ADDR0 interface=[/interface ethernet find where name=ether1]
/ip route add gateway=$GATE0
" > /mnt/rw/autorun.scr
```

验证设置信息

```bash
cat /mnt/rw/autorun.scr
```

卸载镜像

```bash
umount /mnt
```

 设置文件系统为只读

```bash
echo u > /proc/sysrq-trigger
```

 查看硬盘路径

```bash
fdisk -lu
```

 以本次操作为例, 我的VPS硬盘路径是

/dev/vda
DD RouterOS系统镜像

```bash
dd if=chr.img bs=1024 of=/dev/vda && reboot
```

 如果硬盘路径不同，请根据自己的情况修改.

有些机器不会自动重启, 那么运行

```bash
echo "b" > /proc/sysrq-trigger
```

