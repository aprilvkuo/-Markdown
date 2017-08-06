---
title: data_reduction
date: 2016-10-15 17:22:29
tags: [DataMining]
categories: [数据挖掘]
---


# Data Reduction

## Numerosity Reduction---Regression and Log-Linear Models

### Regression Analysis
对于含有自变量和因变量数据的一种建模和分析手段.
最常用的拟合方法是用最小二乘法

### Regression and Log-Linear Models
A log-linear model is a mathematical model that takes the form of a function whose logarithm is a linear combination of the parameters of the model, which makes it possible to apply (possibly multivariate) linear regression.

## Numerosity Reduction---Non-Parametric Methods

- 直方图分析
- Clustering

###  Sampling 采样

  + 原则:选择代表性的数据子集
  + 可以让数据挖掘算法,比原数据集复杂度更低的运行结果
  + 简单的随机采样方法可能效果特别差,有一些更加合适的采样方法,如:分层采样
  + 采样是用来数据选择的一种主要技术.通常用于初始的数据处理和最后的数据分析.
  + 如果对于整个数据集进行处理的话往往很费时
  + 判断采样是否有效:采样数据和原数据集合能一样进行工作;采样数据和原数据集合有大体一致的属性.

#### 采样类型

- 简单随机采样
- Sampling without replacement(不放回采样)
- Sampling with replacement(放回采样)
- Stratified sampling(分层采样)
    将数据集进行划分,然后从每个子数据集中进行采样
    Used in conjunction with skewed data(适用于偏斜数据整合)

## Data Compression(数据压缩)

- 字符串压缩(典型无损)
- 音频视频压缩(有损)
- 时间序列压缩
- Dimensionality and numerosity reduction may also be
considered as forms of data compression

## Data Transformation(数据转化)

通常将一系列属性值映射到一个新的值,每一个旧的属性值对应着新属性值中的一个
### Data Transformation Methods

- 平滑:从数据中出去噪音
- 属性/特征重建
- Aggregation:Summarization, data cube
construction
- Normalization(归一化)
- Discretization(离散化)

#### 归一化

- Min-Max Normalization
- Z-Score Normalization
- Normalization by Decimal Scaling

### Discretization(离散化)
- 属性的类别
    1. Nominal—values from an unordered set, e.g., color, profession
    2. Ordinal—values from an ordered set, e.g., military or academic rank
    3. Numeric—real numbers, e.g., integer or real numbers
- 离散化:将连续的属性划分为区间
    + 区间标签可以用真实数据值替换
    + 可以递归地对一个属性值进行离散化
- 离散化工具
    + Binning
    + 直方图分析
    + 聚类分析
    + 决策树分析
    + 相关性分析
        + 自底向上
    + 分类分析
        + 使用熵

# Similarity and Dissimilarity

## 欧拉距离
## Minkowski Distance
