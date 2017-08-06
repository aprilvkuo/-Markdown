---
title: project_qa_4---寒假小结
date: 2017-01-31 14:13:59
tags: [CQA]
categories: [QA]
---
> 寒假主要看deep learning的一些东西

# 项目进一步:
## 生成模型:->问题生成
>建立seq2seq的答案和段落到问题的生成模型  P(q|p,a)  [答案可以看作是段落的子字符串]

1. encoder 和 decoder都是 GRU(Gated Recurrent Unit,对当前隐层影响加了权重,离当前位置越远的权重越低)
2. encoder: 先将原始输入信息进行词向量化处理
3. decoder: 利用attention机制(在rnn基础上进行改进,对于每一个时刻的隐状态,源输入文本对它的影响存在一个分布,即注意力不集中),然后在copy net的基础上,得到该时刻所有输出的概率(copy net,输出序列有两种可能,一种是此表中的vocabulary , 一种是输入序列中的子串,即将它copy过来).

## 辨别模型:->答案生成
>通过段落和问题生成答案   P(a|p,q)  [答案可以看作是段落的子字符串]

1. gated-attention reader(在整个模型中，每一轮迭代，将query中的词向量通过双向的GRU，并分别将前后方向上的最后的隐层状态拼接合成query的表示),可以用于阅读理解.
2. 利用GA模型,得到两个softmax,分别表示answer的头尾单词,得到答案.

## 两者结合:
  强化学习,利用生成对抗网络,使目标函数最大化(还没细看)
  >Generative Adversarial Networks对抗网络GAN是2014年的10佳论文之一，是一种新的生成模型。本质是对训练数据的概率分布进行建模，并且可以用来生成样本，如一张图像。对抗网络可以用一个简单的实际例子来说明，如艺术画的伪造者和鉴别者。一开始伪造者和鉴别者的水平都不高，但是鉴别者还是比较容易鉴别出伪造者伪造出来的艺术画。但随着伪造者对伪造技术的学习后，其伪造的艺术画会让鉴别者识别错误；或者随着鉴别者对鉴别技术的学习后，能够很简单的鉴别出伪造者伪造的艺术画。这是一个双方不断学习技术，以达到最高的伪造和鉴别水平的过程。对抗网络其实并不是一个新的网络结构，而是一个训练框架。框架中有两个网络，生成网络和判别网络（生成网络和判别网络可为MLP或CNN等其他网络结构），分别对应伪造者和鉴别者。在mnist数据集中，生成网络用来生成一张手写图像，而判别网络则负责判断该张图片是机器生成还是人手写的。

 参考论文:
 1.Semi-Supervised QA with Generative Domain-Adaptive Nets
 2.Generative adversarial nets. In NIPS. pages 2672–2680
 3.Incorporating copying mechanism in sequence-to-sequence learning.
 4.Gated-attention readers for text comprehension
