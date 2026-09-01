---
title: RouterOS 7.X IPV6 设置
swiper_index: 10
top_group_index: 10
background: '#fff'
date: 2025-07-12 08:43:13
updated:
tags:
- ros
- routeros
- 软路由
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
## routeros 7.X IPV6设置

##### 1.再确保routeos正常上网后，设置dhcpv6client。用winbox打开ipv6>dhcpv6client，pool name值可以写任意自己熟悉的。

![image-20240520031336215](https://cdn.jsdelivr.net/gh/zz3656/picgo@main/img/2024/05/20/d1ff0caaec78de79120cd7b4d3ccd475-image-20240520031336215-5adcbd.png)

##### 2.给内网网卡设置ipv6地址

![image-20240520031722408](https://cdn.jsdelivr.net/gh/zz3656/picgo@main/img/2024/05/20/aa715ad4aad6cf18adc31a744327101a-image-20240520031722408-603ac9.png)

##### 3.设置内网ipv6地址分配，打开ipv6>dhchv6 server。具体设置参照下图

![image-20240520031903900](https://cdn.jsdelivr.net/gh/zz3656/picgo@main/img/2024/05/20/5ac14c3551e9e4801d7e0f81706fca8f-image-20240520031903900-963211.png)

##### 4.设置ND，打开ipv6>neighbor discovery

![image-20240520032616623](https://cdn.jsdelivr.net/gh/zz3656/picgo@main/img/2024/05/20/449f6d8ff8f6413603dcf11404f7f073-image-20240520032616623-89b02b.png)

##### 5.这时候实际上已经可以上网了，但是打开IPV6网页的时候特别慢。我们需要添加一条防火墙规则改变一下MSS，打开ipv6>ipv6 firewall 再mangle下新建一条规则

![image-20240520032758913](https://cdn.jsdelivr.net/gh/zz3656/picgo@main/img/2024/05/20/2843be459341759ac68c99cd8eb8887b-image-20240520032758913-8131d6.png)

![image-20240520032809483](https://cdn.jsdelivr.net/gh/zz3656/picgo@main/img/2024/05/20/80b16f4c954f673a951372ddcde8f6b7-image-20240520032809483-6eb283.png)

![image-20240520032820373](https://cdn.jsdelivr.net/gh/zz3656/picgo@main/img/2024/05/20/cbb078bc804999ddc553d92033964b44-image-20240520032820373-0d243b.png)

##### 完结，至此可以愉快的进行上网了。