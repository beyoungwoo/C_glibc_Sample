#!/usr/bin/python -Wall
# -*- coding: utf-8 -*-
"""
<div id="content">
<div style="text-align:center;" class="print"><img src="images/print_page_logo.png" alt="projecteuler.net" style="border:none;" /></div>
<h2>Digit factorials</h2><div id="problem_info" class="info"><h3>Problem 34</h3><span>Published on Friday, 3rd January 2003, 06:00 pm; Solved by 56894; Difficulty rating: 5%</span></div>
<div class="problem_content" role="problem">
<p>145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.</p>
<p>Find the sum of all numbers which are equal to the sum of the factorial of their digits.</p>
<p class="info">Note: as 1! = 1 and 2! = 2 are not sums they are not included.</p>
</div><br />
<br /></div>
"""
from math import factorial

max_sum = 0
result = 0
for i in range(1, 10):
    max_sum += factorial(i)

#print max_sum

for i in range (3, max_sum+1):
    idx = i
    buf = str(idx)
    len_i = len(buf)

    sum_res = 0
    for j in range(0, len_i):
        sum_res += factorial(int(buf[j]))

    if (i == sum_res):
        result += i
        print i



print "result = ", result
