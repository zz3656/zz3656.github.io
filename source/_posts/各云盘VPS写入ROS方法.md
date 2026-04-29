---
title: 各云盘VPS写入ROS方法
date: 2025-07-12
categories:
  - 工作笔记
tags:
  - ros
---

转自：2023/12/08 12:34 [无线路由类](http://a57068368.3322.org:880/category-2.html) 43 0

先在VPS上安装debian12
下载routeros的CHR镜像

代码:

1
wget https://download.mikrotik.com/routeros/7.15.2/chr-7.15.2.img.zip

 说明，最新的下载地址请参考

[https://mikrotik.com/download](https://mikrotik.com/download)
需要下载 Cloud Hosted Router类别下的 Raw disk image

解压镜像

1
unzip chr-7.15.2.img.zip

 把chr-6.48.3.img文件名改为为chr.img

1
mv chr-7.15.2.img chr.img

 查看镜像的Start值

1
fdisk -lu chr.img

 如果Start值不是1， 那么请注意下面的命令.

挂载镜像

1
mount -o loop,offset=512 chr.img /mnt

 如果上面Start值不是1, 那么请用值乘以512.

如果是2, 那么offset=1024
RouterOS v7.x的Start值为34
那么代码应该是

代码:

1
mount -o loop,offset=33571840 chr.img /mnt

 获取IP信息和设置变量

1
2
3
ADDR0=`ip addr show ens3 | grep global | cut -d' ' -f 6 | head -n 1`

GATE0=`ip route list | grep default | cut -d' ' -f 3`

 注意，这里的网卡名称是eth0, 如果不是eth0, 那么根据自己的VPS网卡信息更改.

查询方法, ifconfig, 看看这个网卡名称

创建目录

1
mkdir -p /mnt/rw

 设置routeros开机的时候自动设置网络信息

1
2
3
echo "/ip address add address=$ADDR0 interface=[/interface ethernet find where name=ether1]
/ip route add gateway=$GATE0
" > /mnt/rw/autorun.scr

验证设置信息

1
cat /mnt/rw/autorun.scr

卸载镜像

1
umount /mnt

 设置文件系统为只读

1
echo u > /proc/sysrq-trigger

 查看硬盘路径

1
fdisk -lu

 以本次操作为例, 我的VPS硬盘路径是

/dev/vda
DD RouterOS系统镜像

1
dd if=chr.img bs=1024 of=/dev/vda && reboot

 如果硬盘路径不同，请根据自己的情况修改.

有些机器不会自动重启, 那么运行

1
echo "b" > /proc/sysrq-trigger