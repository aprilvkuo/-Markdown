---
title: project_qa_1
date: 2017-03-19 17:16:50
tags: [CQA]
categories: [QA]
---
# 答案摘要
1. 段落中心句
2. 基于自适应最大间隔相关模型的答案文摘[面向网络社区问答对的语义挖掘研究,王宝勋]

# 问句模板评估质量的评估.
特征的选择,最后融合并选择合适的模型.
## 语义
1. 浅层语义相似度[1]
通过依存句法分析得到浅层语义结构树以及语义角色标注:
在比较候选问题和候选句时，两种结构的相似度不仅体现在单个的语义角色匹配数目上，也体现在语义角色的整体结构上。
比较两个树状结构时，可将树T表示成全部子树类型的向量形式：h(T)=(h1(T)，h2(T)，…，),hN(T)为第T个子树的类型以及在T出现的次数,然后转化为点积计算相似度.
ps: (1) 保留核心词最关键部分,去掉修饰成分
    (2) 不同的动词或者名词间的比较，判断它们在howNet中是否是同义词，如果是，则匹配；
    (3)对于问题中某个角色下的特殊词“TIME”、"ENTITY”与候选句中同样角色下的名词进行比较时，如果它们在WordNet中有相同的上位词，则匹配。
    (4)对于中间节点的判断，如果问题中节点的所有产生部分都在候选句中节点的所有产生部分中，则匹配。
2. 主题相似度
3. 利用howNet计算document embeddings相似度
4. 基于 Word2Vector语义相关度和基于汉语框架网（ CFN）语义场景相关度
5. 词袋模型关键字匹配改进:问句的关键字可以是答案的母类
6. ESSK,本来是计算字符串之间的匹配度,利用howNet之类将同义词映射到一样的字符,再算匹配程度

## 语法
1. n-gram 计算问句流畅度

## 提取各种特征,建立逻辑回归模型 [2]
特征为:
1. 问句和答案的长度特征,以及答案短语的长度
2. 问句中是否含有疑问词
3. 否定词
4. n-gram的模型特征: 对数似然和长度标准化对数似然
5. 语法特征: (数量)专有名词,代词,形容词,副词,连词,数次,名词,介词短语,从句,答案短语
6. 是否存在同位语,是否将主语作为答案主语
7. 是否存在模棱两可的词语(指代不明)


# deep learning 方法
##idea 1: 特征词 + 模板
word embedding,cnn特征提取,lstm train

train data:  answer->  keywords  (templet)
##idea 2: seq2seq + 网页检索
word embedding,cnn特征提取,encoder,decoder:lstm
train data:  answer-> questions
putting the question generation into search engin, and returns the best question.

 参考论文:
 1.基于浅层语义树核的阅读理解答案句抽取-张志昌，张宇，刘挺，李生
(哈尔滨工业大学计算机学院信息检索研究室，黑龙江哈尔滨150001)
 2.Good Question! Statistical Ranking for Question Generation
Michael Heilman Noah A. Smith
