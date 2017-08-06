---
title: git的使用
date: 2016-10-01 11:27:50
tags: [git]
categories: [github]
photos: /images/git.jpg

---


收录一下使用过程中遇到的陌生操作指令.

# git设置设置不需要输入密码

> 经常需要 `git push` 东西,发现每次都需要输入账号和密码,疼疼的密码很蛋疼,很长.所以就收录了一下git自动记录账号密码的方法.

## git config

默认记住15分钟:

    git config --global credential.helper cache

自己设置时间:

    git config credential.helper 'cache --timeout=3600'

长期存储密码：

    git config --global credential.helper store

## 'git remote add' with your password

    git remote add origin
    http://yourname:password@github.com/aprilvkuo/_posts.git

# git 远程分支的合并
>在对本地库中的文件执行修改后，想Git push推送到远程库中，结果在git push的时候提示出错：
>! [rejected]        master -> master (non-fast-forward)
>error: 无法推送一些引用到 'git@github.com:GarfieldEr007/XXXX.git'
提示：更新被拒绝，因为您当前分支的最新提交落后于其对应的远程分支。
提示：再次推送前，先与远程变更合并（如 'git pull ...'）。详见
提示：'git push --help' 中的 'Note about fast-forwards' 小节。

    git remote add origin https://github.com/username/test.git    
    git fetch origin  
    git merge origin/maste

# 本地库推送到远程库
``` python
git remote add origin git@github.com:conlin/youmi.git
git push -u origin master

//报错了：
提示：更新被拒绝，因为远程版本库包含您本地尚不存在的提交。这通常是因为另外
提示：一个版本库已向该引用进行了推送。再次推送前，您可能需要先整合远程变更
提示：（如 'git pull ...'）。
提示：详见 'git push --help' 中的 'Note about fast-forwards' 小节。

//强制推送
git push origin +master
```

# 分支
``` python
git branch  name#新建分支
git checkout B1#切换到分支B1
git merge C4 #将C4分支合并到当前分支
git branch --merged #查看当前分支合并的分支
git branch --no--merged #查看当前分支没有合并的分支
git branch -d C4#删除C4分支
git branch -a #查看分支详情

```

# 查看commit 记录
``` python
git log:可以看到当前提交历史
git reflog:可以看到命令历史
git show commit_id#查看这次commit的信息
git revert c011eb3c20ba6fb38cc94fe5a8dda366a3990c61
'''
git revert用于反转提交,执行evert命令时要求工作树必须是干净的.
git revert用一个新提交来消除一个历史提交所做的任何修改.
revert 之后你的本地代码会回滚到指定的历史版本,这时你再 git push 既可以把线上的代码更新.(这里不会像reset造成冲突的问题)
'''
git reset –soft#回退到某个版本，只回退了commit的信息，不会恢复到index file一级。如果还要提交，直接commit即可
git reset –hard#彻底回退到某个版本，本地的源码也会变为上一个版本的内容

```

#查看版本变迁树
``` python
git log --graph --oneline
git blame filename#执行git blame;命令时，会逐行显示文件，并在每一行的行首显示commit号,提交者,最早的提交日期
```

# 比较不同
``` python
git diff commit_id1  commit_id2
```
