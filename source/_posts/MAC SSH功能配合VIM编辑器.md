---
title: MAC SSH功能配合VIM编辑器
date: 2025-07-12
categories:
  - 编程开发

tags:
  - Mac
  - SSH
---

# MAC SSH功能，配合VIM编辑器对编程十分有帮助。
爱咖啡2025-07-122025-07-12# MAC SSH功能，配合VIM编辑器对编程十分有帮助。
本文来源自网络

原文链接：[https://blog.csdn.net/xcg132566/article/details/78797339](https://blog.csdn.net/xcg132566/article/details/78797339)

MAC作为程序员的神器，在编程上的使用远超window的电脑，而MAC本身提供了SSH功能，配合VIM编辑器对编程十分有帮助。
使用ssh连接远程主机

1
ssh [[email protected]](/cdn-cgi/l/email-protection)

其中，username是登录用户名，@后接ip地址，点击确定之后输入密码即连接到远程主机。要查看当前有多少个处于登录状态的用户，可以使用who命令查看。

使用scp命令实现上传下载

## 1、从服务器上下载文件
1
scp username@servername:/path/filename /Users/mac/Desktop（本地目录）

例如:scp [[email protected]](/cdn-cgi/l/email-protection#91b7b2a0a0a5aab7b2e9a7f7aab7b2e9a7f7aab7b2a0a0a7aab7b2e9a5a1aab7b2a5a8aab7b2e9a2a3aab7b2a4a0aab7b2e9a3f4aab7b2e9a2a3aab7b2e9a2a1aab7b2a4a4aab7b2e9a3f4aab7b2a5a8aab7b2e9a2a6aab7b2a5a9aab7b2a5a7aab7b2e9a2a5aab7b2a5a9aa):/root/test.txt /Users/mac/Desktop就是将服务器上的/root/test.txt下载到本地的/Users/mac/Desktop目录下。注意两个地址之间有空格！

## 2、上传本地文件到服务器
1
scp /path/filename username@servername:/path ;

例如scp /Users/mac/Desktop/test.txt [[email protected]](/cdn-cgi/l/email-protection#587e7b69696c637e7b206e3e637e7b696969637e7b206f6c637e7b206c68637e7b6c61637e7b206b6a637e7b206b6b637e7b6c6e637e7b206b6a637e7b206b68637e7b6d6d637e7b206a3d637e7b6c61637e7b206b6f637e7b206b68637e7b6c6e637e7b206b6c637e7b6c6063):/root/

## 3、从服务器下载整个目录
1
scp -r username@servername:/root/（远程目录） /Users/mac/Desktop（本地目录）

例如:scp -r [[email protected]](/cdn-cgi/l/email-protection#efc9cc97d8ddd4c9ccdededed4c9ccdededed4c9ccdeded9d4c9ccd9dbd4c9cc97dcded4c9ccdad8d4c9cc97dcddd4c9cc97dd8ad4c9ccdbd6d4c9cc97dcd9d4c9cc97dcd7d4c9cc97dd8ad4c9cc97dcdfd4c9cc97dd8ad4c9cc97dcded4c9ccdbd7d4c9ccdbd6d4):/root/ /Users/mac/Desktop/

## 4、上传目录到服务器
1
scp -r local_dir username@servername:remote_dir

例如：scp -r test [[email protected]](/cdn-cgi/l/email-protection#a187829090959a8782d997c79a87829090909a87829090979a878297959a878295989a878294969a8782d992939a8782d993c49a878295989a878294959a878294979a878295979a878295999a8782d993c49a8782d992909a878295999a8782d992909a):/root/ 把当前目录下的test目录上传到服务器的/root/ 目录

注：目标服务器要开启写入权限。
————————————————