#!/usr/bin/python -Wall
# -*- coding: utf-8 -*-
"""
<div id="content">
<div style="text-align:center;" class="print"><img src="images/print_page_logo.png" alt="projecteuler.net" style="border:none;" /></div>
<h2>Factorial digit sum</h2><div id="problem_info" class="info"><h3>Problem 20</h3><span>Published on Friday, 21st June 2002, 06:00 pm; Solved by 119990; Difficulty rating: 5%</span></div>
<div class="problem_content" role="problem">
<p><i>n</i>! means <i>n</i> &times; (<i>n</i> &minus; 1) &times; ... &times; 3 &times; 2 &times; 1</p>
<p>For example, 10! = 10 &times; 9 &times; ... &times; 3 &times; 2 &times; 1 = 3628800,<br />and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0 + 0 = 27.</p>
<p>Find the sum of the digits in the number 100!</p>
</div><br />
<br /></div>
"""

from math import factorial

total = 0
ret = factorial(100)
while (1):
    total = total + ret % 10
    
    ret = ret/10
    if (ret < 10):
        total = total + ret
        break

   
print total
