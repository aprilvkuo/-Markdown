---
title: project_qa_2
date: 2017-03-19 17:17:40
tags: [CQA]
categories: [QA]
---
# 一
思路是通过分类的方法,以特征(问答对之间的语法,语义相似度,以及一些语法特征)作为输入,建立了逻辑回归,判断问答对(模板,答案)是否匹配
然后进行特征融合,对每个特征进行加权,得到一个最佳的组合特征(有待研究,初期想法想到boost对分类器进行组合,类比对特征进行组合).

# 二
这几天也在看deep learning 和 tensorflow的东西, 大概分为以下两种方法进行解决问题.

## idea 1:
结合了之前的模板方法,用dnn进行关键词提取,但是可能需要自己标注一些语料,而将关键词提取出来.
然后由关键词找到模板, 模板中对应于每个空的词性应该是有要求的, 将模板与(填空数和词性)一块存储.

对于 Entity,Human,Location,Time,Definition 可以看作是关键词的提取. 再套用模板填词
对于 How,Judge,Why,Number (可能是重句或者是关键词)更多进行语义角色标注或者就直接进行词性标注(用阅读理解的方法,看成是输出替代词语首尾不知道可行吗?),然后用疑问词替代,在进行句子调序.

## idea 2:
以现成的问答对进行训练, 答案作为输入,问题作为输出.建立seq2seq模型,encoder和decoder分别为lstm.  adding attention and copynet
input the answer and generate the question.  judge the question whether matching to the answer or not.  if matching ,put into search engin, and returns the best question.



ps:
对问题的分类有不同的维度，可以单纯根据问题类型分。我之前做过一个工作，对141670个真实问题进行分析，根据问句的形式和提问的内容将问句分为10大类，类型和比列如表1所示。

表1 问句类型和比例
类型	实体(Entity)	方式(How)	判断(Judge)	原因(Why)	数字(Number)
比例	32.10%	26.0%	13.72%	7.12%	6.45%
类型	人物(Human)	地点(Location)	时间(Time)	定义(Definition)	其他(Other)
比例	5.63%	2.40%	2.22%	1.32%	2.87%
从答案类型的角度分，可以把问题分为事实型问题、列举型问题、定义型问题和交互型问题，限于篇幅，这里不对每种问题类型举例。问题分类可看作是特殊的文本分类。相对于文本，问句一般比较简短，可采用的特征较少，但更容易进行深层的语法和语义分析。现有问题分类的方法主要有两基于规则的方法和基于统计机器学习的方法，这里不做展开介绍。



deep learning 方法
idea 1: 特征词 + 模板
word embedding,cnn特征提取,lstm train

train data: answer-> keywords (templet)

idea 2: seq2seq + 网页检索
word embedding,cnn特征提取,encoder,decoder:lstm
train data: answer-> questions
putting the question generation into search engin, and returns the best question.
