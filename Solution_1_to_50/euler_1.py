#!/usr/bin/python -Wall
# -*- coding: utf-8 -*-
"""
<div id="content">
<div style="text-align:center;" class="print"><img src="images/print_page_logo.png" alt="projecteuler.net" style="border:none;" /></div>
<h2>Multiples of 3 and 5</h2><div id="problem_info" class="info"><h3>Problem 1</h3><span>Published on Friday, 5th October 2001, 06:00 pm; Solved by 472714; Difficulty rating: 5%</span></div>
<div class="problem_content" role="problem">
<p>If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.</p>
<p>Find the sum of all the multiples of 3 or 5 below 1000.</p>
</div><br />
<br /></div>
"""

''' 
#great answer
def sumn(n, d):
    n //= d
    return d*n*(n+1) // 2

L1, a, b = 999, 3, 5
som = sumn(L1, a) + sumn(L1, b) - sumn(L1, a*b)

print "answer = ", som
'''


def sumn2(max_num, num):
    sum_num = 0
    max_range = max_num//num
    print "range =", max_range
    for i in range(1, max_range+1):
        sum_num += num * i

    return sum_num

result = sumn2(999, 3) + sumn2(999, 5) - sumn2(999, 3*5)
print "answer2 = ", result 
