---
title: Algorithm-搜索策略实现
date: 2017-06-07 17:36:47
tags: [Algorithm]
categories: [Algorithm]
---

## DFS
1. 数据结构

	    class Node(object):
	    	def __init__(self):
	    		self.way= None
	    		self.node= None

2. 步骤
	1. 构建一个栈S，栈中初始状态只含有初始节点0的节点类(Node(0,[])).
	2. 每次从栈顶弹出一个节点 i。
  		1. 当节点i的编号为0，回到出发节点，而且i.way符合要求（每个节点只经过一次，最后回到初始点0），输出路径。如果i.way不符合要求，舍弃不操作。
   		2. 当节点i的编号不为0，如果i.way符合要求(每个节点经过一次)，则将i的孩子节点以及路径压入栈中。如果i.way不符合要求，舍弃不操作。
	3. 重复2的操作，当栈为空时候，说明没有可行解，程序终止。

## BFS

1. 数据结构

	    class Node(object):
	    	def init(self):
	    		self.way= None
	    		self.node= None
    

2. 步骤：
	1. 构建一个队列Q，队列中初始状态只含有初始节点0的节点类(Node(0,[])).
	2.  每次取队头的第一个节点 i。
	   1. 当节点i的编号为0，回到出发节点，而且i.way符合要求（每个节点只经过一次，最后回到初始点	0），输出路径。如果i.way不符合要求，舍弃不操作。
	   2. 当节点i的编号不为0，如果i.way符合要求(每个节点经过一次)，则将i的孩子节点以及路径压入队列Q中。如果i.way不符合要求，舍弃不操作。
	3. 重复2的操作，当队列为空时候，说明没有可行解，程序终止。

## 爬山法

1. 数据结构

	       class Node(object):
	       	def init(self):
	       		self.way= None
	               self.cost = 0
	       		self.node= None
	       		
2. 步骤

	1. 构建一个栈S，栈中初始状态只含有初始节点0的节点类(Node(0,[])).
	2.  每次从栈顶弹出一个节点 i。
	   1. 当节点i的编号为0，回到出发节点，而且i.way符合要求（每个节点只经过一次，最后回到初始点0），输出路径。如果i.way不符合要求，舍弃不操作。
	   2. 当节点i的编号不为0，如果i.way符合要求(每个节点经过一次)，将i的孩子节点按照路径加权距离大到小排序，然后依次将i的孩子节点压入栈中。如果i.way不符合要求，舍弃不操作。
	3. 重复2的操作，当栈为空时候，说明没有可行解，程序终止。

# 最小哈密顿环

## 分支界限法

1. 分支界限法可以用于求解优化问题。  特点：利用已经得到的可行解，剪除不能得到优化解的分支。
2. 两个要素：
   1. 产生可行解的策略：使用采用爬山法得到第一个可行解，整个过程采用最佳优先策略。
   2. 剪除分支的策略： 判断以x为根节点可行解代价是否大于已知可行解的最小代价。绑定函数，具体判断。
3. 数据结构
	
		   class Node(object):
	       	def init(self):
	       		self.way= None
	               self.cost = 0
	       		self.node= None
	       		
5. 步骤：
   1. 哈密顿环的可行解方法得到一个可行解，记录其代价为C*。
   2. 构建一个最小堆Heap，按照节点类的cost进行排序调整，初始状态只含有开始节点0的节点类。
   3. 每次从Heap弹出最小的节点i
 		1. 当节点i的编号为0，回到出发节点，而且i.way符合要求（每个节点只经过一次，最后回到初始点0），记录输出路径和代价C'，更新可行解代价C* = min（C*，C'）。如果i.way不符合要求，舍弃不操作。
	   2. 当节点i的编号不为0，如果i.way符合要求(每个节点经过一次)，将i的孩子节点，然后依次将i的孩子节点压入最小堆中，并对堆进行调整。如果i.way不符合要求，舍弃不操作。
	4. 重复步骤3， 直至最小堆为空，输出记录下来的最小代价C*以及对应的路径。 

# 关键代码
##DFS：

```pythondef DFS(s,cur,way,M,n):    ham = False    if (M[cur][s] == 1) and isall(n,way):        print way        return True    for i in range(n):        #未访问过的一个邻结点        if (M[cur][i]) and (isvi(i,way) == False):            way.append(i)            print way            #递归搜索         ham=DFS(s,i,way,M, n)            if ham:                break            way.pop()    return ham
```

## BFS:

```python
def BFS(s,M,n):    Q = deque()    Q.append(s)    while len(Q) != 0:        cur = Q.popleft()        if (s.data == cur.data) and isall(n,cur.pathway):            print cur.pathway            return True        for i in range(n):            if M[cur.data][i] and isvi(i,cur.pathway) == False:               way=cur.pathway            way.append(cur.data)               t=Node_a(i, way)                Q.append(t)    return False    
```    

##爬山法：

```
def Climb_DMF(curPath, curCost):    global minPath, minCost, disMa, priMa    n = len(disMa[0])    #当前代价超过最小代价剪枝    if curCost >= minCost:        return    #与（a）不同，当走过所有节点后还需回到初始节点！！!    if len(curPath) == n:        e = curPath[-1]        nexPath = curPath[:]        nexPath.append(curPath[0])        Climb_DMF(nexPath, disMa[e][curPath[0]]+curCost)    #构成哈密顿环    elif len(curPath) > n:        minCost = curCost        minPath = curPath[:]        return    #未遍历完，选择节点    else:        #爬山法，优先选择代价小的候选节点        for i in range(n):            e = curPath[-1]            index = priMa[e][i]            if index not in curPath:                nexPath = curPath[:]                nexPath.append(index)                Climb_DMF(nexPath, disMa[e][index]+curCost)
```

##分支界限法：

```
def __build__(self, cur):        print '当前边集:',cur.edge,'\t当前最小代价:',        if self.minNode == None:            print float('inf'),        else:            print self.minNode.cost,        edge = cur.selectCandidate()        #叶节点        if len(edge) == 0:            #哈密顿环            if cur.graph.size == 0:            #if cur.isCircle:                print '\t形成哈密顿环：','代价：',cur.cost,                if self.minNode == None:                    self.minNode = cur.copy()                    print '\t获得第一个可行解'                elif self.minNode.cost > cur.cost:                    self.minNode = cur.copy()                    print '\t更新当前最小哈密顿环'                else:                    print '\t代价大于当前最优解，剪枝'        #非叶节点,递归建立        else:            print '未形成哈密顿环','代价：',cur.cost,            if cur.cost==float('inf'):                print '不能构成哈密顿环，剪枝'            #未找到解或当前代价低于最小代价            elif self.minNode == None or self.minNode.cost > cur.cost:                cur.left = cur.copy()                cur.right = cur.copy()                cur.left.includeEdge(edge)                cur.right.notIncludeEdge(edge)                #print '递归建树'                self.__build__(cur.left)                self.__build__(cur.right)            else:                print '当前代价大于最小代价，剪枝'
```


    