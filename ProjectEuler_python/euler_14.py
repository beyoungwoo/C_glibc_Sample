#!/usr/bin/python -Wall
# -*- coding: utf-8 -*-
"""
<div id="content">
<div style="text-align:center;" class="print"><img src="images/print_page_logo.png" alt="projecteuler.net" style="border:none;" /></div>
<h2>Longest Collatz sequence</h2><div id="problem_info" class="info"><h3>Problem 14</h3><span>Published on Friday, 5th April 2002, 06:00 pm; Solved by 129075; Difficulty rating: 5%</span></div>
<div class="problem_content" role="problem">
<p>The following iterative sequence is defined for the set of positive integers:</p>
<p style="margin-left:50px;"><var>n</var> &rarr; <var>n</var>/2 (<var>n</var> is even)<br />
<var>n</var> &rarr; 3<var>n</var> + 1 (<var>n</var> is odd)</p>
<p>Using the rule above and starting with 13, we generate the following sequence:</p>
<div style="text-align:center;">13 &rarr; 40 &rarr; 20 &rarr; 10 &rarr; 5 &rarr; 16 &rarr; 8 &rarr; 4 &rarr; 2 &rarr; 1</div>
<p>It can be seen that this sequence (starting at 13 and finishing at 1) contains 10 terms. Although it has not been proved yet (Collatz Problem), it is thought that all starting numbers finish at 1.</p>
<p>Which starting number, under one million, produces the longest chain?</p>
<p class="note"><b>NOTE:</b> Once the chain starts the terms are allowed to go above one million.</p>
</div><br />
<br /></div>
"""

#limit_num = 10
limit_num = 1000000

def P():
    max_cnt = 0
    max_i = 0
    for i in range(limit_num-1, limit_num/2, -1):
        temp = i
        cnt = 0

        while (temp != 1) :
            cnt += 1

            if (temp % 2 == 0):
                temp = temp/2
            else :
                temp = 3*temp +1

        if (max_cnt < cnt):
            max_cnt = cnt
            max_i = i


    print "cnt=", max_cnt, "max:", max_i
P()

""" great answer """
L, maxc, cache = 1000000, 1, {1:1}

def chain(n):
    if not n in cache:
        cache[n] = chain(3*n + 1 if n % 2 else n/2) + 1
    return cache[n]
 
for n in range(3, L, 2):
    maxc = n if chain(n) > cache[maxc] else maxc 

print "Project Euler 14 Solution: (Starting number, Chain Length) =", (maxc, cache[maxc])

