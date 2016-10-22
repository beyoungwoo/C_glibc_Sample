#!/usr/bin/python -Wall
# -*- coding: utf-8 -*-
"""
<div id="content">
<div style="text-align:center;" class="print"><img src="images/print_page_logo.png" alt="projecteuler.net" style="border:none;" /></div>
<h2>Powerful digit counts</h2><div id="problem_info" class="info"><h3>Problem 63</h3><span>Published on Friday, 13th February 2004, 06:00 pm; Solved by 26010; Difficulty rating: 5%</span></div>
<div class="problem_content="problem">
<p>The 5-digit number, 16807=7<sup>5</sup>, is also a fifth power. Similarly, the 9-digit number, 134217728=8<sup>9</sup>, is a ninth power.</p>
<p>How many <i>n</i>-digit positive integers exist which are also an <i>n</i>th power?</p>
</div><br />
<br /></div>
"""
MAX_NUM = 100
cnt = 0
for i in range(1, MAX_NUM):
    for j in range(1, MAX_NUM):
        ret = (j ** i)
        if len(str(ret)) == i:
            cnt += 1
            print i,ret 

print "total=", cnt
print "DONE"
