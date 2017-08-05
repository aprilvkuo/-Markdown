---
title: Algorithm-最小生成树和并查集
date: 2017-06-07 17:36:47
tags: [Algorithm]
categories: [Algorithm]
---

# 最小生成树

## Prim

基本思路：将点的集合分为C 和 V-C  ，分别为访问过的。

## Krusal

将每个顶点维护成单顶点连通分量$ C(v_1),…C(v_n)$
1. 先将边进行排序
2. 每次加入权值最小的边，如果两个节点在不同的连通分量，则加入，否则丢弃
最好的实现方式是使用并查集，时间复杂度为$O(|E|log |E|)$
使用链表，算法复杂度$O(|V|^3)$


# 并查集

并查集由一个整数型的数组和两个函数构成。数组pre[]记录了每个点的前导点是什么，函数find是查找，join是合并。

    int pre[1000 ];
    
    int find(int x)                                                                                                         //查找根节点
    { 
    int r=x;
    while ( pre[r ] != r )                                                                                              //返回根节点 r
          r=pre[r ];
    int i=x , j ;
    while( i != r )                                                                                                        //路径压缩
    {
         j = pre[ i ]; // 在改变上级之前用临时变量  j 记录下他的值 
         pre[ i ]= r ; //把上级改为根节点
         i=j;
    }
    return r ;
    }
    
    void join(int x,int y)                                                                                                    //判断x y是否连通，
    //如果已经连通，就不用管了 //如果不连通，就把它们所在的连通分支合并起,
    {
    int fx=find(x),fy=find(y);
    if(fx!=fy)
        pre[fx ]=fy;
        }
路径压缩： 直接存储它的根节点。

[参考]:(http://blog.csdn.net/dellaserss/article/details/7724401/)
​					