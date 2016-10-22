#!/usr/bin/python -Wall
# -*- coding: utf-8 -*-
"""
<div id="content">
<div style="text-align:center;" class="print"><img src="images/print_page_logo.png" alt="projecteuler.net" style="border:none;" /></div>
<h2>Counting fractions in a range</h2><div id="problem_info" class="info"><h3>Problem 73</h3><span>Published on Friday, 2nd July 2004, 06:00 pm; Solved by 15547; Difficulty rating: 15%</span></div>
<div class="problem_content" role="problem">
<p>Consider the fraction, <i>n/d</i>, where <i>n</i> and <i>d</i> are positive integers. If <i>n</i>&lt;<i>d</i> and HCF(<i>n,d</i>)=1, it is called a reduced proper fraction.</p>
<p>If we list the set of reduced proper fractions for <i>d</i> &le; 8 in ascending order of size, we get:</p>
<p style="text-align:center;font-size:90%;">1/8, 1/7, 1/6, 1/5, 1/4, 2/7, 1/3, <b>3/8, 2/5, 3/7</b>, 1/2, 4/7, 3/5, 5/8, 2/3, 5/7, 3/4, 4/5, 5/6, 6/7, 7/8</p>
<p>It can be seen that there are 3 fractions between 1/3 and 1/2.</p>
<p>How many fractions lie between 1/3 and 1/2 in the sorted set of reduced proper fractions for <i>d</i> &le; 12,000?</p>
</div><br />
<br /></div>
"""

from Euler import gcd

MAXNUM=51
MAXNUM=12001
a2=1
a3=1

cnt = 0
for i in range(4, MAXNUM):
    a2 = i*3
    a3 = i*2
    for j in range(a3+1, a2):
        if j%6 == 0:
            if gcd(i, j/6) == 1:
                cnt+=1

print cnt
