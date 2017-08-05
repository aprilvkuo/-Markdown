---
title: leetcode_1
date: 2017-02-02 21:42:37
tags: [leetcode]
categories: [leetcode]
---

https://leetcode.com/problems/two-sum/
# 题目大意:
给定一个数组 nums 和一个目标值 target,从数组中找到i和j,使得nums[i] + num[j] = target.而且题目确保只有一种解法,所以不需要考虑边缘条件情况.

# Example:
> Given nums = [2, 7, 11, 15], target = 9,
Because nums[0] + nums[1] = 2 + 7 = 9,
return [0, 1].

# 解题思路:
题目主要是从数组中里面找到两个数的值之和为target.

题目很简单,对于每一个值v1,需要确定数组是否含有另外一个值v2,使得v1+v2=target.对于每一个数v1需要进行O(n)次运算,总的时间复杂度为O(n^2).

进阶想法:利用空间换时间,对数组进行遍历一遍,可以记录下数组值与数组之间的关系,自然可以想到可以用hash表的方法(key,value)<-(v,position)进行记录,然后再一次对数组进行遍历,对于每一个值v1,需要确定数组是否含有另外一个值v2,使得v1+v2=target.
总的时间复杂度为O(2n),第一次记录位置,第二次对每一个数进行判断.

进一步想法:在上一条想法的基础上,其实第一次遍历数组的过程中,会得到更新状态的Hash(dic),对于每一个访问的数值v0,只需要确定此时Hash是否存在一个v1满足条件:
如果数组中确实存在v1,
1. 如果v1在v0的左边,在访问v0时候可以通过hash判断.
2. 如果v1在v0的右边,在访问v0时候并不会发掘序列,但是在访问v1时候,v0已经在Hash中,可以发掘出序列.

# Tips
利用Hash对位置进行记录,很多时候可以很好的降低程序的时间复杂度.原理是空间换取时间,对访问过的状态以及有用信息进行记录.

#Solution

``` python
class Solution(object):
    def twoSum(self, nums, target):
        """
        :type nums: List[int]
        :type target: int
        :rtype: List[int]
        """
        dict={}
        for index,item in enumerate(nums):
            dict[item]=index
        for index, item in enumerate(nums):
            com= target - item
            if com in dict.keys() and dict[com]!=index:
                return index,dict[com]
```
