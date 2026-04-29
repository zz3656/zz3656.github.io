---
title: VPS 安装 ros 系统
date: 2025-07-12
categories:
  - 工作笔记
tags:
  - ros
  - VPS
---

VPS预装一个centos7系统，安装wget命令

1
yum install wget -y

通用单网卡方案	 (适应于绝大多数VPS)

下载镜像

1
wget https://download.mikrotik.com/routeros/6.45.8/chr-6.45.8.img.zip -O chr.img.zip

解压缩

1
gunzip -c chr.img.zip > chr.img

挂载镜像

1
2
3
fdisk -lu chr.img  #查看img得start值
mount -o loop,offset=512 chr.img /mnt
mount -o loop,offset=17408 chr.img /mnt

获取地址与网关 与 赋入变量

1
2
3
ifconfig  #查看网卡名字
ADDR0=`ip addr show eth0 | grep global | cut -d' ' -f 6 | head -n 1`
GATE0=`ip route list | grep default | cut -d' ' -f 3`

新建mnt目录下rw文件夹

1
mkdir -p /mnt/rw

把变量ADDR0和GATE0写入到/mnt/rw/autorun.scr文件

1
2
3
echo "/ip address add address=$ADDR0 interface=[/interface ethernet find where name=ether1]
/ip route add gateway=$GATE0
" > /mnt/rw/autorun.scr

卸载镜像

1
umount /mnt

立即重新挂载所有的文件系统为只读

1
echo u > /proc/sysrq-trigger

DD ros镜像

1
2
3
fdisk -lu  #查看磁盘名字
dd if=chr.img bs=1024 of=/dev/sda && reboot
dd if=chr.img bs=1024 of=/dev/vda && reboot

立即重新启动机器

1
echo "b" > /proc/sysrq-trigger

另一款 双网卡的样本	(注意分清 内外 网卡)

1
2
3
4
5
196.10.68.0/24 dev eth0  proto kernel  scope link  src 196.10.68.24 
169.254.0.0/16 dev eth0  scope link  metric 1002 
169.254.0.0/16 dev eth1  scope link  metric 1003 
10.0.0.0/8 dev eth1  proto kernel  scope link  src 10.0.87.152 
default via 196.10.68.1 dev eth0

下载roschr镜像

1
wget https://download.mikrotik.com/routeros/6.45.8/chr-6.45.8.img.zip -O chr.img.zip

解压镜像

1
gunzip -c chr.img.zip > chr.img

挂载镜像到/mnt目录

1
mount -o loop,offset=512 chr.img /mnt

获取本机IP和网关信息并赋予变量

1
2
3
4
ADDR0=`ip addr show eth0 | grep global | cut -d' ' -f 6 | head -n 1`			
ADDR1=`ip addr show eth1 | grep global | cut -d' ' -f 6 | head -n 1`			
GATE0=`ip route list | grep default | cut -d' ' -f 3`
GATE1=`ip route list | grep '10.0.0.0/8' | cut -d' ' -f 9`

给mnt目录新建rw文件夹

1
mkdir -p /mnt/rw

把刚才获取的变量信息写入到/mnt/rw/autorun.scr文件

1
2
3
4
5
echo "/ip address add address=$ADDR0 interface=[/interface ethernet find where name=ether1]
/ip address add address=$ADDR1 interface=[/interface ethernet find where name=ether2]
/ip route add gateway=$GATE0
/ip route add dst-address=10.0.0.0/8 gateway=$GATE1
" > /mnt/rw/autorun.scr

卸载镜像

1
umount /mnt

立即重新挂载所有的文件系统为只读

1
echo u > /proc/sysrq-trigger

DD ros镜像

1
dd if=chr.img bs=1024 of=/dev/vda && reboot

Ros 授权相关

Ros 系统是商业软件 ，本身是需要授权的，在没有授权的情况下使用，网卡限制速率(1Mbps)，不过Ros CHR版本是支持免费试用的，只需要去官方网站 [https://mikrotik.com/client](https://mikrotik.com/client) 注册一个帐号，然后去邮箱获取帐号通过验证，接着返回到Ros系统  进入 System > License  填入你刚刚注册的帐号登录即可，试用期是两个月时长，但根据我的使用情况来看，只要系统不进行更新，是可以一直免费试用下去的，功能不受限制。

pve 安装roschr

1
qm importdisk 104 /var/lib/vz/template/iso/chr-7.14.3.img local-lvm