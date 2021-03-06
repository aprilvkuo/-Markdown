# FM 模型

Factorization Machine，将类别特征通过onehot转化为数值特征。

多项式模型是包含特征组合的最直观的模型。在多项式模型中，特征 $x_i$ 和 $x_j$ 的组合采用 $x_ix_j$ 表示，即 $x_i$ 和 $x_j$都非零时，组合特征 $x_ix_j$ 才有意义。从对比的角度，本文只讨论二阶多项式模型。模型的表达式如下

$y(x)=w_0+∑_{i=1}^nw_ix_i+∑_{i=1}^n∑_{j=i+1}^nw_{ij}x_ix_j$

$w_{ij}$ 有 n*(n-1)/2个。每个$w_{ij}$需要大量非零的$w_i,w_j$样本。样本会特别少。

需要解决二次参数训练的问题	-》 协同过滤

# 协同过滤

Collaborative Filtering,

​	首先想一个简单的问题，如果你现在想看个电影，但你不知道具体看哪部，你会怎么做？大部分的人会问问周围的朋友，看看最近有什么好看的电影推荐，而我们一般更倾向于从口味比较类似的朋友那里得到推荐。这就是协同过滤的核心思想。

​	换句话说，就是借鉴和你相关人群的观点来进行推荐，很好理解。过程主要有

## 收集数据

这里的数据指的都是用户的历史行为数据，比如用户的购买历史，关注，收藏行为，或者发表了某些评论，给某个物品打了多少分等等，这些都可以用来作为数据供推荐算法使用，服务于推荐算法。需要特别指出的在于，不同的数据准确性不同，粒度也不同，在使用时需要考虑到噪音所带来的影响。

## 相似用户和物品

计算相似度

## 进行推荐

在协同过滤中，有两种主流方法：基于用户的协同过滤，和基于物品的协同过滤。

1. 基于用户的 CF 的基本思想相当简单，基于用户对物品的偏好找到相邻邻居用户，然后将邻居用户喜欢的推荐给当前用户。计算上，就是将一个用户对所有物品的偏好作为一个向量来计算用户之间的相似度，找到 K 邻居后，根据邻居的相似度权重以及他们对物品的偏好，预测当前用户没有偏好的未涉及物品，计算得到一个排序的物品列表作为推荐。 下图给出了一个例子，对于用户 A，根据用户的历史偏好，这里只计算得到一个邻居 - 用户 C，然后将用户 C 喜欢的物品 D 推荐给用户 A。
2. 基于物品的 CF 的原理和基于用户的 CF 类似，只是在计算邻居时采用物品本身，而不是从用户的角度，即基于用户对物品的偏好找到相似的物品，然后根据用户的历史偏好，推荐相似的物品给他。从计算的角度看，就是将所有用户对某个物品的偏好作为一个向量来计算物品之间的相似度，得到物品的相似物品后，根据用户历史的偏好预测当前用户还没有表示偏好的物品，计算得到一个排序的物品列表作为推荐。下图给出了一个例子，对于物品 A，根据所有用户的历史偏好，喜欢物品 A 的用户都喜欢物品 C，得出物品 A 和物品 C 比较相似，而用户 C 喜欢物品 A，那么可以推断出用户 C 可能也喜欢物品 C。



　Item CF 和 User CF 是基于协同过滤推荐的两个最基本的算法，User CF 是很早以前就提出来了，Item CF 是从 Amazon 的论文和专利发表之后（2001 年左右）开始流行，大家都觉得 Item CF 从性能和复杂度上比 User CF 更优，其中的一个主要原因就是对于一个在线网站，用户的数量往往大大超过物品的数量，同时物品的数据相对稳定，因此计算物品的相似度不但计算量较小，同时也不必频繁更新。但我们往往忽略了这种情况只适应于提供商品的电子商务网站，对于新闻，博客或者微内容的推荐系统，情况往往是相反的，物品的数量是海量的，同时也是更新频繁的，所以单从复杂度的角度，这两个算法在不同的系统中各有优势，推荐引擎的设计者需要根据自己应用的特点选择更加合适的算法。