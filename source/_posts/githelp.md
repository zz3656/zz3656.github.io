---
title: 利用GIt命令上传项目到GitHub指定仓库
top_img: 
swiper_index: 10
top_group_index: 10
background: '#fff'
date: 2020-02-23 07:01:47
updated:
tags:
- Git
- Github
- 教程
categories:
- 工作笔记
keywords:
description:
top:
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
利用GIt命令上传项目到GitHub指定仓库
1.建立GIt可管理的仓库 cd到本地项目根目录下，执行 git init 命令：

  git init
2.将项目的所有文件添加到仓库中(注意add后面有一个“ . ”)

  git add .
3.将上一步add的文件commit到仓库

  git  commit -m "提交的说明注释"
4.到GitHub官网新建一个仓库（Create repository）,并复制仓库地址

5.将本地仓库关联到GitHub新建的仓库上

  git remote add origin https://github.com/Love-LG/Javaweb-firstcup-war  
6.使用pull命令

  git pull origin master
7.将本地仓库的文件上传到GitHub远程仓库

  git push -u origin master  
总结：
在最后使用命令“git push -u origin master”将本地仓库的文件上传的远程的GitHub仓库时可能会遇到如下错误

提示上面错误信息的主要原因是我们在GitHub上新建仓库时一般会选择生成一个README.md的说明文档，因此我们必须使用以下命令将README.md下载到我们的本地仓库再使用
git push -u origin master命令就能成功将代码上传到GitHub的远程仓库。
