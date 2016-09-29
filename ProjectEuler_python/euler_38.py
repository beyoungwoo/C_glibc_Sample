#!/usr/bin/python -Wall
# -*- coding: utf-8 -*-
"""
<div id="content">
<div style="text-align:center;" class="print"><img src="images/print_page_logo.png" alt="projecteuler.net" style="border:none;" /></div>
<h2>Pandigital multiples</h2><div id="problem_info" class="info"><h3>Problem 38</h3><span>Published on Friday, 28th February 2003, 06:00 pm; Solved by 37585; Difficulty rating: 5%</span></div>
<div class="problem_content" role="problem">
<p>Take the number 192 and multiply it by each of 1, 2, and 3:</p>
<blockquote>192 &times; 1 = 192<br />
192 &times; 2 = 384<br />
192 &times; 3 = 576</blockquote>
<p>By concatenating each product we get the 1 to 9 pandigital, 192384576. We will call 192384576 the concatenated product of 192 and (1,2,3)</p>
<p>The same can be achieved by starting with 9 and multiplying by 1, 2, 3, 4, and 5, giving the pandigital, 918273645, which is the concatenated product of 9 and (1,2,3,4,5).</p>
<p>What is the largest 1 to 9 pandigital 9-digit number that can be formed as the concatenated product of an integer with (1,2, ... , <var>n</var>) where <var>n</var> &gt; 1?</p>
</div><br />
<br /></div>
"""

from Euler import is_pandigital

for i in range(9999, 9000, -1):
    a1 = i * 1
    a2 = i * 2
    buf ="%d%d" % (a1, a2)
    if (is_pandigital(int(buf))):
        print buf
