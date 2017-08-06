---
title: tensorflow_ptb
date: 2017-05-01 10:56:20
tags: Tensorflow
categories: [Tensorflow]
---
# PTB 数据集
NLP中常用的PTB语料库，全名Penn Treebank。

Penn Treebank是一个项目的名称，项目目的是对语料进行标注，包括词性标注以及句法分析。

语料来源为：1989年华尔街日报

语料规模：1M words，2499篇文章

语料价格：$1700

Penn Treebank项目有两个发行版，Treebank-2与Treebank-3，委托Linguistic Data Consortium (LDC) 发行与收费。

这两个版本的语料内容是一样的，除了发行时间不清楚还有啥区别……
# 论文: RNN 的正则化---DropOut
用上标表示层数，下标表示时间。
RNN可以用下面公式表示： $$h_t^{l-1} , h_{t-1}^l -> h_t^l$$
传统的RNN即： $h_t^l = f(T_{n,n}h_t^{l-1} + T_{n,n}h_{t-1}^l)$,T为仿射变换wx+b。
LSTM 将long-term-memory存储于 记忆元 $c_{t-1}^l$
公式为： $h_t^{l-1} , h_{t-1}^l，c_{t-1}^l -> h_t^l$
       $c_{t}^l = f × c_{t-1}^l + i × g$

# 困惑度
![公式](http://52opencourse.com/?qa=blob&qa_blobid=2301630441467725164)

其中$ P(w_1w_2...w_n) $ 为ngram计算一个句子出现的概率。
$PP(W) = P(w_1w_2...w_n)^{1 /over n}$

> 
> 扩展： ngram中的平滑技术： 
> 1. plus 1 平滑，分子加一，分母加V（词表大小）
> 2. Good-Turing Smoothing
> 

# 模型分析
[tensorflow笔记：多层LSTM代码分析](http://blog.csdn.net/u014595019/article/details/52759104)
