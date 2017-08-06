---
title: linux 指令小记
subtitle:   linux command
date: 2016-09-30 12:27:44
tag: [Linux]

categories: [Linux]
photos: /images/linux_command.jpeg
---

<iframe frameborder="no" border="0" marginwidth="0" marginheight="0" width=330 height=86 src="http://music.163.com/outchain/player?type=2&id=193373&auto=1&height=66"></iframe>

# ubuntu下安装 deb 软件
```
sudo dpkg -i xxx.deb
sudo apt-get -f install
```

# jobs
  当 __命令行__ 在执行一个任务时候，可以用 __Crtl+Z__ 中断，如果需要恢复任务或者停止任务，需要用到 __jobs__ 指令。

  ## - 查jobs：

  ```
  jobs
  jobs -l
  ```

  >-l ：表示list，能罗列jobs的ids

  >-p :只罗列ids

  >-r :只罗列running的jobs

  >-s ：只罗列stopped

  ##  - fg  :后台进程转到 **前台**

  ```
  fg %1
  ```

  1为jobs查得的jobs编号

  ## - ctrl + z :可以将一个正在前台执行的命令放到后台，并且暂停

  ```
  ctrl + z
  ```

  ## - bg :改变 **后台** 工作为running
  ```
  bg %1
  ```

  ---
# 图形界面与命令行界面切换
```
Ctrl + Alt +F1~F6   会进入6个Terminal让用户登录
Ctrl + Alt +F7      回到图形界面桌面
quit                退出登录的帐号
```

# 查看主机名

```
hostname  或者 uname –n
```

# linux 中大小写不一样
```
指令格式为            command [-option] paraments ...
短参数               -  “”
长参数               --date=“ ”
格式化输出前面加‘+’    date +a
```

# 查看日期  date
```
查看日历  cal
计算器    bc   /将输出设置为小数， scale=number（number是小数点后的位数）
```

# 快捷键
```
Tab      键为补全键
Ctrl c   中断当前程序
Ctrl d   代表这EOF的意思
```

# apt get 解锁：

##  - 终端输入 sudo ps aux|grep apt-get

###  + ps

ps   : report a snapshot of the current processes
ps a : 显示现行终端机下的所有程序，包括其他用户的程序。
ps u : 以用户为主的格式来显示程序状况
ps x : 显示所有程序，不以终端机来区分。

### +  grep

global search regular expression(RE) and print out the line

全面搜索正则表达式并把行打印出来)是一种强大的文本搜索工具，它能使用正则表达式搜索文本，并把匹配的行打印出来。

grep searches the named input FILEs for lines containing a match to the
given PATTERN.  If no files are specified, or if the file “-” is given,
grep  searches  standard  input.   By default, grep prints the matching
lines.

### + kill -9  PID

很多时候，会有人建议你，如果kill杀不掉一个进程，就用kill -9
kill是Linux下常见的命令。其man手册的功能定义如下：
kill – send a signal to a process
明朗了，其实kill就是给某个进程id发送了一个信号。默认发送的信号是SIGTERM，而kill -9发送的信号是SIGKILL，即exit。exit信号不会被系统阻塞，所以kill -9能顺利杀掉进程。

参考：[Linux kill -9 和 kill -15 的区别](http://www.cnblogs.com/liuhouhou/p/5400540.html)



## 强制解锁--命令:

```
sudo rm /var/cache/apt/archives/lock
sudo rm /var/lib/dpkg/lock
```
---

# man，help，info

```
man    command #查看说明，using '/word' to search
help   command
info   fdisk
```

help 是内部命令的帮助,比如cd命令
man 是外部命令的帮助，比如ls命令
info 显示工具信息
info工具是一个基于菜单的超文本系统，由GNU项目开发并由Linux发布。info工具包括一些关于Linux shell、工具、GNU项目开发程序的说明文档。


# rm  删除文件或者文件夹

删除文件夹时候，用 __-r__  (recursive)


# who(查看系统登陆的用户) netstat(查看网络状态)

```
to make sure who are online                   who
to make sure the state of using internet      netstat -a
```

# 7 states of linux system

```
level 0: power off
level 3: command mode
level 5: gui
level 6: reboot
```

using 'init num' to change the mode

> 最好别切换 切换为0 或者6 ，估计系统就gg了

# ls -al：  list

>to show the propertity and pession of all the files


# ch***  :修改权限

```
chgrp:change user group
chown:change ower
chmod:change file mode bits
```

# 关于文件夹的指令 cd，pwd，mkdir，rmdir

```
cd : change dir
pwd: print working dir
mkdir: make dir
rmdir: remove dir
```

# cp  ：copy  

```
cp  soure_file  dest_file
```

# cd 的一些符号代表文件目录

```
.   represents the preset dir
..  represents the higher dir
-   represenrs the former dir
~   account  the main dir of account
```

# 解压与压缩指令

一般通过默认安装的ubuntu是不能解压rar文件的，只有在安装了rar解压工具之后，才可以解压。其实在ubuntu下安装rar解压工具是非常简单的，只需要两个步骤就可以迅速搞定。

ubuntu 下rar解压工具安装方法：

- 压缩功能

安装 sudo apt-get install rar
卸载 sudo apt-get remove rar

- 解压功能

安装 sudo apt-get install unrar
卸载 sudo apt-get remove unrar



ubuntu解压命令全览

.tar

解包：tar xvf FileName.tar

打包：tar cvf FileName.tar DirName

注：tar是打包，不是压缩！

~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~

.gz

解压1：gunzip FileName.gz

解压2：gzip -d FileName.gz

压缩：gzip FileName

~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~

.tar.gz 和 .tgz

解压：tar zxvf FileName.tar.gz

压缩：tar zcvf FileName.tar.gz DirName

~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~

.bz2

解压1：bzip2 -d FileName.bz2

解压2：bunzip2 FileName.bz2

压缩： bzip2 -z FileName

~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~

.tar.bz2

解压：tar jxvf FileName.tar.bz2

压缩：tar jcvf FileName.tar.bz2 DirName

~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~

.bz

解压1：bzip2 -d FileName.bz

解压2：bunzip2 FileName.bz

压缩：未知

.tar.bz

解压：tar jxvf FileName.tar.bz

压缩：未知

~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~

.Z

解压：uncompress FileName.Z

压缩：compress FileName

.tar.Z

解压：tar Zxvf FileName.tar.Z

压缩：tar Zcvf FileName.tar.Z DirName

~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~

.zip

解压：unzip FileName.zip

压缩：zip FileName.zip DirName

~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~

.rar

解压：rar x FileName.rar

压缩：rar a FileName.rar DirName

rar请到：http://www.rarsoft.com/download.htm 下载！

解压后请将rar_static拷贝到/usr/bin目录（其他由$PATH环境变量指定的目录也可以）：

[root@www2 tmp]# cp rar_static /usr/bin/rar

~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~

.lha

解压：lha -e FileName.lha

压缩：lha -a FileName.lha FileName

lha请到：http://www.infor.kanazawa-it.ac.jp/~ishii/lhaunix/下载！

>解压后请将lha拷贝到/usr/bin目录（其他由$PATH环境变量指定的目录也可以）：

[root@www2 tmp]# cp lha /usr/bin/

~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~

.rpm

解包：rpm2cpio FileName.rpm | cpio -div

~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~

.deb

解包：ar p FileName.deb data.tar.gz | tar zxf -

~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.

tar .tgz .tar.gz .tar.Z .tar.bz .tar.bz2 .zip .cpio .rpm .deb .slp .arj .rar .ace .lha .lzh .lzx .lzs .arc .sda .sfx .lnx .zoo .cab .kar .cpt .pit .sit .sea

解压：sEx x FileName.*

压缩：sEx a FileName.* FileName



Finally install TensorFlow:

# Python 2
(tensorflow)$ pip install --upgrade $TF_BINARY_URL

# Python 3
(tensorflow)$ pip3 install --upgrade $TF_BINARY_URL
With the Virtualenv environment activated, you can now test your installation.

When you are done using TensorFlow, deactivate the environment.

(tensorflow)$ deactivate

$  # Your prompt should change back
To use TensorFlow later you will have to activate the Virtualenv environment again:

$ source ~/tensorflow/bin/activate  # If using bash.
$ source ~/tensorflow/bin/activate.csh  # If using csh.
(tensorflow)$  # Your prompt should change.
# Run Python programs that use TensorFlow.
...
# When you are done using TensorFlow, deactivate the environment.
(tensorflow)$ deactivate
