---
title: ml-6----贝叶斯学习
date: 2017-01-10 14:11:21
tags: [Maching Learning]
categories: [机器学习]
---
极大后验(MAP)假设:
> 考虑假设集合H并在其中寻找给定数据D时可能性最大的假设h.

$ h_{MAP} = argmax P(h|D) = argmax P(D|h)P(h)$

极大似然(maximum likelihood):
> 在已知试验结果（即是样本）的情况下，用来估计满足这些样本分布的参数，把可能性最大的那个参数 $ \theta $ 作为真实 $ \theta $ 的参数估计。
设参数为已知数,然后求结果的概率,得到参数的函数,再求函数的最大值.

$ h_{ML} = argmax P(D|h)$
