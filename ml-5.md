---
title: ml-5-----遗传算法
date: 2017-01-10 13:35:11
tags: [Maching Learning]
categories: [机器学习]
---
#遗传算法
答题思路:
p:表示群体中的假设数
fitness():表示假设的适应度,适应度评分函数
fitnesss_threshold:表示适应度阈值
r: 每一步听过交叉取代当前群体的概率
m: 变异率

1. 初始化群体: $ P \leftarrow $随机产生p个假设
2. 评估:  对于每一个假设进行评估,计算fitness(h)
3. 当max(fitness(h))<fitnesss_threshold 时,产生新的后代:
    - 选择: 从 p个假设中按概率选择 p(1-r) 个假设,加入 $ P_s $.从p中选择假设 $ h_j $的概率 $ Pr(h_j) $ 可以用公式:
    $ Pr(h_j) = {fitness(h_j) \over  \sum fitness}$
    - 交叉: 根据上面Pr的公式,从P中选择r*(p/2)对假设,并对于每一对假设,按照交叉算子,产生两个后代,并将后代加入Ps中.
    - 变异: 使用均匀的概率从Ps中选择m%的成员,对于选出的成员,随机选择以为取反.
    - 更新: $P \leftarrow Ps$
    - 评估: 对于P中的每个h计算Fitness
4. 输出最大的的Fitness假设.
