---
title: leetcode_2
date: 2017-02-02 22:08:31
tags: [leetcode]
categories: [leetcode]
---

# 题目大意
https://leetcode.com/problems/add-two-numbers/
给定两个用链表表示的多位十进制数字,低位到高位分别为表头到表尾,计算这个两个数字之和的十进制数组链表.
没多少技术含量.pass

# Solution
```python
# Definition for singly-linked list.
# class ListNode(object):
#     def __init__(self, x):
#         self.val = x
#         self.next = None

class Solution(object):
    def addTwoNumbers(self, l1, l2):
        """
        :type l1: ListNode
        :type l2: ListNode
        :rtype: ListNode
        """
        num1, num2 = 0, 0
        dice = 1
        while l1 or l2 :
            if l1:
                num1 += dice*l1.val
                l1 = l1.next
            if l2:
                num2 += dice * l2.val
                l2 = l2.next
            dice *= 10
        num3 = num1 + num2
        l3 = ListNode(0)
        if num3 == 0:
            return l3
        point = l3
        while num3 != 0:
            point.next = ListNode(num3 % 10)
            num3 /= 10
            point = point.next
        return l3.next
```
