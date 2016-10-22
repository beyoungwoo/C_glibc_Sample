#!/usr/bin/python -Wall
# -*- coding: utf-8 -*-
"""
<div id="content">
<div style="text-align:center;" class="print"><img src="images/print_page_logo.png" alt="projecteuler.net" style="border:none;" /></div>
<h2>Power digit sum</h2><div id="problem_info" class="info"><h3>Problem 16</h3><span>Published on Friday, 3rd May 2002, 06:00 pm; Solved by 133429; Difficulty rating: 5%</span></div>
<div class="problem_content" role="problem">
<p>2<sup>15</sup> = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.</p>
<p>What is the sum of the digits of the number 2<sup>1000</sup>?</p>
</div><br />
<br /></div>
"""

#ret = 1
#for i in range(1, 1001):
#    ret *= 2 
#print "2-> ",ret
ret = 1
for i in range(1, 126):
    ret *= 256
print ret

""" great answer """
print reduce(lambda x, y: x + y, [int(i) for i in str(256 ** 125)])
