---
title: leetcode-4-median-of-two-sorted-arrays
date: 2017-02-02 23:31:44
tags: [leetcode]
categories: [leetcode]
---

# 题目大意:
https://leetcode.com/problems/median-of-two-sorted-arrays/
给定两个排好序的数组,找到这两个数组所有数的中位数.
对于中位数,要讨论元素总个数的奇偶性.
当为奇数时候,为最中间的数;
当为偶数时候,为中间两个数的平均数.

# 解题思路
由于题目要求的是在Log(n)的时间内完成,很自然的想到了二分查找,然而如何运用二分查找.

常规思路,可以通过遍历两个数组,可以找到的中间的一位数或者两位数,但是时间复杂度为O(n),并不符合要求.

二分查找:  
已知条件,数组A和数组B都为有序.
假设总的有偶数位数,当把数组A和数组B合在一块,总共有2n位,则肯定是在数组里面切一刀,左边有n位,右边有n位.

>       left_A             |        right_A
  A[0], A[1], ..., A[i-1]  |  A[i], A[i+1], ..., A[m-1]

>       left_B             |        right_B
  B[0], B[1], ..., B[j-1]  |  B[j], B[j+1], ..., B[n-1]
等价于分别在A与B之间切两刀,使得左边总共有n位.

需要满足条件:  1.左边有n位;
             2.左边的数都小于右边的数. left < right.设此时左边数的总个数为f(x),x为A切的位置

第一个条件 => A的一刀切能确定B的一刀切位置

__由题意可以,f(x)是递增的.问题转换为当f(x)== n时候的x值__

如果不满足第二个条件,有如下两种情况:
1. 如果max_leftA的最大数>min_rightB, 则说明此时f(x) >n
2. 如果max_leftB的最大数>min_rightA, 则说明此时f(x) <n

# Solution

``` python
class Solution(object):
    def findMedianSortedArrays(self,A, B):
        m, n = len(A), len(B)
        if m > n:
            A, B, m, n = B, A, n, m
        if n == 0:
            raise ValueError

        imin, imax, half_len = 0, m, (m + n + 1) / 2
        while imin <= imax:
            i = (imin + imax) / 2
            j = half_len - i
            if i < m and B[j - 1] > A[i]:
                # i is too small, must increase it
                imin = i + 1
            elif i > 0 and A[i - 1] > B[j]:
                # i is too big, must decrease it
                imax = i - 1
            else:
                # i is perfect

                if i == 0:
                    max_of_left = B[j - 1]
                elif j == 0:
                    max_of_left = A[i - 1]
                else:
                    max_of_left = max(A[i - 1], B[j - 1])

                if (m + n) % 2 == 1:
                    return max_of_left

                if i == m:
                    min_of_right = B[j]
                elif j == n:
                    min_of_right = A[i]
                else:
                    min_of_right = min(A[i], B[j])

                return (max_of_left + min_of_right) / 2.0




```
