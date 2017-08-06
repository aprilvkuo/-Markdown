---
title: leetcode_3
date: 2017-02-02 22:34:36
tags: [leetcode]
categories: [leetcode]
---

# 题目大意:
https://leetcode.com/problems/longest-substring-without-repeating-characters/
从一个字符串中找到最大不出现重复数字的字符串.

# 解题思路:
对于字符串的第i个位置ch[i],以ch[i]结尾的最大不重复子字符串为MaxS[i],求 MaxS[i]:
1. 如果MaxS[i-1]中出现ch[i]且在j位置,则MaxS[i] = ch[j:i]
2. else, MaxS[i] = MaxS[i-1] + 1
过程中记录比较得到最大的MaxS
时间复杂度为O(n^2)

# 进阶想法:
在上面的想法中,判断MaxS[i-1]是否有ch[i],可以利用Hash表来将时间复杂度从n降到1. 用Hash记录当前状态下字符最后出现的位置Hash(ch[i]).
同时记录MaxS[i-1]的开始位置 begin,如果 Hash值出现在begin之后,则满足上面的条件1,其他则跳转至条件二.

# 总结
参考:http://blog.jobbole.com/83949/
时间换空间,Dp动态规划,记录下前面的状态.
动态规划的本质，是对问题状态的定义和状态转移方程的定义。
满足
最优子结构:
当问题的最优解包含了其子问题的最优解
每个阶段的最优状态可以从 __之前__ 某个阶段的某个或某些状态直接得到

重叠子问题:
对每个子问题只解一次，而后将其保存在一个表格中，当再次需要的时候，只是简单的用常数时间查看一下结果。

无后效性：
即某阶段状态一旦确定，就不受这个状态以后决策的影响。也就是说，某状态以后的过程不会影响以前的状态，只与当前状态有关。

每个阶段的状态或许不多，但是每个状态都可以转移到下一阶段的多个状态，所以解的复杂度就是指数的，因此时间复杂度也是指数的。哦哦，刚刚提到的之前的路线会影响到下一步的选择，这个令人不开心的情况就叫做有后效性。

为什么需要dp?
在初等算法中，算法设计的思路一般如下，首先尝试穷举法；然而如何穷举？
此时往往要用到分治法——而归递，在绝大多数时候仅仅是分治法的一种表现形式而已；
在递归和分治法的基础上，往往会用动态规划来优化——动态规划，实际上是一种升级版的分治法。
当然，不是所有的穷举都能使用分治法；不是所有的分治法都能优化成动态规划。此时，就是上文提到的:只有一个问题是可分的，才可以使用分治法；只有分治出来的子问题有重叠，才可以使用DP；只有子问题具有最优子结构，DP才具有意义。

# Solution

``` python
class Solution(object):
    def lengthOfLongestSubstring(self, s):
        """
        :type s: str
        :rtype: int
            """
        count=0
        char = 0
        max = 0
        dict = {}
        for i in range(len(s)):
            tmp = dict[s[i]] if dict.has_key(s[i]) else -1    
            if tmp < char:
                count +=1
            else:
                count = i-tmp
            char = i-count+1
            if count > max:
                max = count
            dict[s[i]] = i
        return max

Solution().lengthOfLongestSubstring("abcabcbb")

```
