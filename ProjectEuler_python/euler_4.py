#!/usr/bin/python -Wall
# -*- coding: utf-8 -*-
"""
<div id="content">
<div style="text-align:center;" class="print"><img src="images/print_page_logo.png" alt="projecteuler.net" style="border:none;" /></div>
<h2>Largest palindrome product</h2><div id="problem_info" class="info"><h3>Problem 4</h3><span>Published on Friday, 16th November 2001, 06:00 pm; Solved by 254694; Difficulty rating: 5%</span></div>
<div class="problem_content" role="problem">
<p>A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 * 99.</p>
<p>Find the largest palindrome made from the product of two 3-digit numbers.</p>
</div><br />
<br /></div>
"""

# 999 * 999 = 998001
# 998 comp 100

def L_comp(n, s):
    if (n == 2) :
        if (s[0] == s[3] and s[1] == s[2]) :
            return True
        else :
            return False
    elif (n == 3) :
        if (s[0] == s[5] and s[1] == s[4] and s[2] == s[3]) :
            return True
        else :
            return False

def L_mutiple(n, max_num):
    max_range = max_num -1
    min_range = max_num /2
    for i in range(max_range, min_range, -1):
        for j in range(max_range, min_range, -1):
            ret = i * j
            s = "%d" % (ret)
            result = L_comp(n, s)
            if (result):
                return ret

    return -1


def L_plaindrome(n):
    if (n != 2 and n != 3):
        print "invalid input"
        return -1

    max_num = 1
    for i in range (0, n):
        max_num *= 10

    return L_mutiple(n, max_num)

print L_plaindrome(3)
