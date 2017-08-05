---
title: nodejs
date: 2017-04-30 13:32:10
tags: [blog]
categories: [Markdown]
---
经过几天的尝试，终于装好了：

1. nodejs官方推荐一下安装方式：

NodeSource的二进制安装脚本NodeSource

Using Ubuntu

```curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -y nodejs```
试了，不行，然后terminal提示我用：```apt install nodejs```

2. nvm 切换用户的话，安装好的node，就不见了

3. 最后使用Ubuntu提示的方式安装:
```
apt install nodejs
apt all npm
```
成功安装，但是版本很老，
node4.2.6
npm -v 3.2

> 终于发现了一个可以管理node版本的第三方库，n来自tj大神。
安装n有几种方式，最快捷的是用npm安装，前面的安装已经为这里打好了铺垫，现在只需要运行npm install -g n，安装好后升级nodejsn latest

>Use or install the latest official release:

>$ n latest
>Use or install the stable official release:

>$ n stable