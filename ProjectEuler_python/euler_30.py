#!/usr/bin/python -Wall
# -*- coding: utf-8 -*-
"""
<div id="content">
<div style="text-align:center;" class="print"><img src="images/print_page_logo.png" alt="projecteuler.net" style="border:none;" /></div>
<h2>Digit fifth powers</h2><div id="problem_info" class="info"><h3>Problem 30</h3><span>Published on Friday, 8th November 2002, 06:00 pm; Solved by 65548; Difficulty rating: 5%</span></div>
<div class="problem_content" role="problem">
<p>Surprisingly there are only three numbers that can be written as the sum of fourth powers of their digits:</p>
<blockquote>1634 = 1<sup>4</sup> + 6<sup>4</sup> + 3<sup>4</sup> + 4<sup>4</sup><br />
8208 = 8<sup>4</sup> + 2<sup>4</sup> + 0<sup>4</sup> + 8<sup>4</sup><br />
9474 = 9<sup>4</sup> + 4<sup>4</sup> + 7<sup>4</sup> + 4<sup>4</sup></blockquote>
<p class="info">As 1 = 1<sup>4</sup> is not a sum it is not included.</p>
<p>The sum of these numbers is 1634 + 8208 + 9474 = 19316.</p>
<p>Find the sum of all the numbers that can be written as the sum of fifth powers of their digits.</p>
</div><br />
<br /></div>
"""

PF = [0] * 10
total = 0

for i in range(0,10):
    PF[i] = pow(i, 5)

for i in range(1000, 10000):
    number = str(i)
    result = PF[int(number[0])] + PF[int(number[1])] + PF[int(number[2])] + PF[int(number[3])] 
    if (result == i):
        print i
        total += i


for i in range(10000, 100000):
    number = str(i)
    result = PF[int(number[0])] + PF[int(number[1])] + PF[int(number[2])] + PF[int(number[3])] + PF[int(number[4])]
    if (result == i):
        print i
        total += i

for i in range(100000, 900000):
    number = str(i)
    result = PF[int(number[0])] + PF[int(number[1])] + PF[int(number[2])] + PF[int(number[3])] + PF[int(number[4])] + PF[int(number[5])]
    if (result == i):
        print i
        total += i



print "total=",total

