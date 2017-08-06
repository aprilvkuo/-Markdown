---
title: leetcode-5_ Longest Palindromic Substring
date: 2017-02-02 23:31:47
tags: [leetcode]
categories: [leetcode]
---

https://leetcode.com/problems/longest-palindromic-substring/
# 题目大意
输入一个字符串,返回最长的回文子串

# 解题思路
很容易想到用DP来求解.
状态定义为:  字符串中的每一个字符结尾的最大回文串长度.(>=1)

最优子结构: 问题的最优解包含的子问题的解也是最优解.
最长的回文串中的每一位,都包含有以该字符结尾的最大回文串长度.

重叠子问题:当计算dp[n],其实是可以利用dp[n-1]的,子问题见有重复,可以存储子问题解决方案

无后效性:即dp[n] 不受n之后的字符影响.

状态转移方程:
dp[n] = dp[n-1] + 2,如果第n位与dp[n-1]的前一位相同.
        dp[n-1] + 1,dp[n-1]的所有元素与第n位相同.
        1          ,其他

# Solution
``` python
class Solution(object):
    def longestPalindrome(self, s):
        """
        :type s: str
        :rtype: str
        """
        count = 1
        str = s[0]
        start = 0
        for i in range (0,len(s)):
            if len(s) == 1:
                return str
            if i-count-1 >= 0 and s[i-count-1:i+1] == s[i-count-1:i+1][::-1]:
                count += 2
                start = i -count+1
            elif i-count >= 0 and s[i-count:i+1] == s[i-count:i+1][::-1]:
                count += 1
                start = i - count+1




        return  s[start:start+count]


```
