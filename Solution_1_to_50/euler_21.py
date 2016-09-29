#!/usr/bin/python -Wall
# -*- coding: utf-8 -*-
"""
<div id="content">
<div style="text-align:center;" class="print"><img src="images/print_page_logo.png" alt="projecteuler.net" style="border:none;" /></div>
<h2>Amicable numbers</h2><div id="problem_info" class="info"><h3>Problem 21</h3><span>Published on Friday, 5th July 2002, 06:00 pm; Solved by 85424; Difficulty rating: 5%</span></div>
<div class="problem_content" role="problem">
<p>Let d(<i>n</i>) be defined as the sum of proper divisors of <i>n</i> (numbers less than <i>n</i> which divide evenly into <i>n</i>).<br />
If d(<i>a</i>) = <i>b</i> and d(<i>b</i>) = <i>a</i>, where <i>a</i> &ne; <i>b</i>, then <i>a</i> and <i>b</i> are an amicable pair and each of <i>a</i> and <i>b</i> are called amicable numbers.</p>
<p>For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22, 44, 55 and 110; therefore d(220) = 284. The proper divisors of 284 are 1, 2, 4, 71 and 142; so d(284) = 220.</p>
<p>Evaluate the sum of all the amicable numbers under 10000.</p>
</div><br />
<br /></div>
"""

from Euler import d

rsum = 0
j = 0
for i in range(2, 10001):
    j = d(i)
    if (d(j) == i):
        if (i != j) :
            print i, ", ", j
            rsum += i
        

print rsum
