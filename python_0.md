---
title: python小计
date: 2016-10-26 10:17:45
tags: [Python]
categories: [Python]
---

# 虚拟环境  virtualenv

```
sudo apt-get install python-virtualenv
#virtualenv [虚拟环境名称] 如，创建**ENV**的虚拟环境
virtualenv ENV

#启动虚拟环境
cd ENV
source ./bin/activate

#退出虚拟环境
deactivate

#列出虚拟环境列表
workon
lsvirtualenv

#新建虚拟环境
mkvirtualenv [虚拟环境名称]

#启动/切换虚拟环境
workon [虚拟环境名称]

#删除虚拟环境
rmvirtualenv [虚拟环境名称]

#离开虚拟环境
deactivate

```

# 正则表达式  

## 正则表达式中的字符编码
对字符串进行正则表达式处理时候,要考虑字符串的编码

## re模块
### re.compile(strPattern[, flag])
这个方法是Pattern类的工厂方法，用于将字符串形式的正则表达式编译为Pattern对象
## 判断字符串是否含有中文
``` python
doc ='中文'.decode('utf-8')
  if  re.compile(u'[\u4e00-\u9fa5]+').search(doc):
      print '中文'
```

# 字符编码

## encoding
将字符串转化为特定的编码

## decoding
将字符串从指定的编码转化为Unicode,可以加入参数'ignore'.
eg:  decoding('utf-8','ignore')

# assert 断言
1、assert语句用来声明某个条件是真的。
2、如果你非常确信某个你使用的列表中至少有一个元素，而你想要检验这一点，并且在它非真的时候引发一个错误，那么assert语句是应用在这种情形下的理想语句。
3、当assert语句失败的时候，会引发一AssertionError。
```
In [6]: assert 1==1

In [7]: assert 1==2
---------------------------------------------------------------------------
AssertionError                            Traceback (most recent call last)
<ipython-input-7-a174714cc486> in <module>()
----> 1 assert 1==2

AssertionError:
```

# dic.setdefault(key, default=None)

- Python 字典(Dictionary) setdefault() 函数和get()方法类似, 如果键不已经存在于字典中，将会添加键并将值设为默认值。
- key -- 查找的键值。
  default -- 键不存在时，设置的默认键值。

# lamada
匿名函数
``` python
def add(x,y):return x+y
add2 = lambda x,y:x+y
print add2(1,2)     #3

def sum(x,y=10):return x+y
sum2 = lambda x,y=10:x+y
print sum2(1)       #11
print sum2(1,100)   #101
```
