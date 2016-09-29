#!/usr/bin/python -Wall
# -*- coding: utf-8 -*-
"""
<div id="content">
<div style="text-align:center;" class="print"><img src="images/print_page_logo.png" alt="projecteuler.net" style="border:none;" /></div>
<h2>Square root digital expansion</h2><div id="problem_info" class="info"><h3>Problem 80</h3><span>Published on Friday, 8th October 2004, 06:00 pm; Solved by 11918; Difficulty rating: 20%</span></div>
<div class="problem_content" role="problem">
<p>It is well known that if the square root of a natural number is not an integer, then it is irrational. The decimal expansion of such square roots is infinite without any repeating pattern at all.</p>
<p>The square root of two is 1.41421356237309504880..., and the digital sum of the first one hundred decimal digits is 475.</p>
<p>For the first one hundred natural numbers, find the total of the digital sums of the first one hundred decimal digits for all the irrational square roots.</p>
</div><br />
<br /></div>
"""

from decimal import getcontext, Decimal

def E80():
    getcontext().prec = 102
    L = 100 
    d, s = 100, 0
    p = pow(10, d-1)
    
    for z in range(2, L):
        q = Decimal(z).sqrt()
        if q % 1 == 0:
            continue
    
        s += sum(int(c) for c in str(q * p)[:d])
        ################
        # str(q * p)[:d]
        ################
        # 1. 1.4141592
        # 2. 141415.92
        # 3. 141415
        # 4. 1+4+1+4+1+5
     
    print "Project Euler 80 Solution =", s

E80()
