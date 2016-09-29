#!/usr/bin/python -Wall
# -*- coding: utf-8 -*-
"""
<div id="content">
<div style="text-align:center;" class="print"><img src="images/print_page_logo.png" alt="projecteuler.net" style="border:none;" /></div>
<h2>Champernowne's constant</h2><div id="problem_info" class="info"><h3>Problem 40</h3><span>Published on Friday, 28th March 2003, 06:00 pm; Solved by 48442; Difficulty rating: 5%</span></div>
<div class="problem_content" role="problem">
<p>An irrational decimal fraction is created by concatenating the positive integers:</p>
<p style="text-align:center;">0.12345678910<span style="color:#dd0000;font-size:14pt;">1</span>112131415161718192021...</p>
<p>It can be seen that the 12<sup>th</sup> digit of the fractional part is 1.</p>
<p>If <i>d</i><sub><i>n</i></sub> represents the <i>n</i><sup>th</sup> digit of the fractional part, find the value of the following expression.</p>
<p style="text-align:center;"><i>d</i><sub>1</sub> &times; <i>d</i><sub>10</sub> &times; <i>d</i><sub>100</sub> &times; <i>d</i><sub>1000</sub> &times; <i>d</i><sub>10000</sub> &times; <i>d</i><sub>100000</sub> &times; <i>d</i><sub>1000000</sub></p>
</div><br />
<br /></div>
"""


result = 1
total_len = 0
comp_val = 10
for i in range(1, 1000001):
    total_len += len(str(i))

    if (total_len >= comp_val):
        d1 = total_len - comp_val
        buf = str(i)[::-1]
        print i, buf[d1], "len", total_len, comp_val
        result *= int(buf[d1])
        comp_val *= 10


print "result 40: ",result
