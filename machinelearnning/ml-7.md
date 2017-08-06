---
title: ml-7----基于实例的学习
date: 2017-01-10 14:46:08
tags: [Maching Learning]
categories: [机器学习]
---

# k-近邻算法

设带预测节点为x, 选择离x节点最近的k个节点中的最普遍的值作为预测的值.  (预测类别时)

选择离k最近的k个节点属性值的平均值作为预测的值.(预测连续属性时)

(加权)  $ f(x) \lefrarrow argmax \sum{\omega f(x_i)}$
其中 $ \omega $ 为权值,与距离相关,成反比.

## 说明

k近邻是一种很有效的归纳推理方法,对噪声有很好的健壮性,对于足够大的训练数据很有效.

当维度过高时,会引起维度灾难,,会存在很多不相关的属性.

解决方法(可能造成过拟合)
1. 计算距离时候,对不同属性加权.(由交叉验证确定)
2. 消除不相关的属性


# 回归
  __局部加权回归__ 局部是因为目标函数的逼近仅仅根据查询点附近的数据,加权是因为每一个训练样例的贡献是由他与查询点间的距离加权的.

  局部加权线性回归升级:
  一般形式,损失函数为: $ E = {1 \over 2} \sum( \delta f(x))$
  1. 可以用 k 近邻代替所有误差项之和.
  2. 可以增加惩罚项,即与待预测节点有关的距离函数,反比.
## 说明
一般用常量,线性函数.或者二次函数.
复杂函数不常见.原因:1.代价高. 2.在晓得实例空间这些函数已经能够很好的拟合.

# 积极学习消极学习

消极学习:延迟了从训练数据中泛化的决策,直至遇到一个新的查询案例时才执行.通过很多局部逼近的组合表示目标函数.
积极学习:学习器在训练时提交了单个全局逼近.