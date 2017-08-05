---
title: project_qa_1
date: 2017-01-16 20:20:25
tags: [CQA]
categories: [QA]
---
Domain-specific Question Generation from a Knowledge Base
基于知识库面向特殊领域的问题生成

摘要:
为了生成自然而有深度的问题,本文提出了一种利用丰富的网络资源生成问题的方法.
首先知识库中有小数量的问题模板,并实例化.然后将这些作为种子集,通过web进行扩展得到更多的候选问题.
然后用一个filtering模型从中选出语法准确度高而且领域相关性高的问句.本文的系统能够生成大量领域相关的语义不同的自然语言问题,而且容易用于其他领域.最后通过人工判断的方法评估生成问题的质量.

对于问题生成,大多数是从文本出发(句法规则,语义角色标注,),随着大规模结构化的知识库出现,有些人开始用知识库的方法.
给定特定领域的知识库,我们用一个基于知识库关系人工书写的小模板集.这些模板包含了placeholders来填充主语或者宾语.
并用这些模板生成种子集,将种子集输到搜索引擎,会的到更加相关的问题候选.
最后用基于语言模型的过滤器评估候选集的流畅性.以及它的语义分布上与领域的相关性

人工的地方是生成种子模板,但是不需要大量的.知识库中每一个主要领域只需要一个或者几个常见的问题模板
通过网络数据,我们能得到更多自然的问题,而且更加贴近用户所需要的问题.


问题生成现在主要的方法是基于文本:从一个简单句子出发,并从中抽取问题的关键元素,然后通过规则生成问句.
主要的方法有:句法分析,语义分析(语义角色标注)
局限:从文本的表层出发,生成的问题很有限.
有些人尝试从文档层次更深的挖掘问题,
discourse connectives(话语联系语,插入语) to generate questions from selected text segments for different question types.
converts the text into concept maps(概念图) from which questions are generated.
generate deep open-ended questions from Wikipedia text (用众包方法得到模板)


另一种方法基于知识库:
- 知识图谱Seyler et al. (2015)generates quiz questions from knowledge graphs,where for each target entity, a SPARQL query isgenerated as an intermediate representation andturned into a natural language question by a simple predefined template. Because of the fixedtemplate used, the type of question is limited to quiz question

- rnn  has constructed
a corpus of 30M factoid question and answer pairs by training a recurrent neural network
to map KB facts into corresponding natural language
questions. However, their approach needs
large amount of fact-question pairs as training data
which is not necessarily available for each domain.
Also the trained model only works for a single
KB fact, which restricts the scope of the generated
questions(需要训练集合基于针对与特定领域)


本文的优点:无监督,问题更有多样性

步奏:
1.领域的知识库处理
2.问题模板的建立
3.种子问题生成
4.问题的扩展以及评估  :带入搜索引擎,迭代得到所有获选问题模板.

Knowledge Questions from Knowledge Graphs
1. 从知识图谱中选择一个名实体作为答案.
2. 生成结构化的三元问题组以及其对应的唯一答案
3. 基于模板的方法生成对应的问句
