#!/usr/bin/python -Wall
# -*- coding: utf-8 -*-
"""
<div id="content">
<div style="text-align:center;" class="print"><img src="images/print_page_logo.png" alt="projecteuler.net" style="border:none;" /></div>
<h2>Special Pythagorean triplet</h2><div id="problem_info" class="info"><h3>Problem 9</h3><span>Published on Friday, 25th January 2002, 06:00 pm; Solved by 199702; Difficulty rating: 5%</span></div>
<div class="problem_content" role="problem">
<p>A Pythagorean triplet is a set of three natural numbers, <var>a</var> &lt; <var>b</var> &lt; <var>c</var>, for which,</p>
<div style="text-align:center;"> <var>a</var><sup>2</sup> + <var>b</var><sup>2</sup> = <var>c</var><sup>2</sup></div>
<p>For example, 3<sup>2</sup> + 4<sup>2</sup> = 9 + 16 = 25 = 5<sup>2</sup>.</p>
<p>There exists exactly one Pythagorean triplet for which <var>a</var> + <var>b</var> + <var>c</var> = 1000.<br />Find the product <var>abc</var>.</p>
</div><br />
<br /></div>
"""

# brute force
'''
for c in range(998, 3, -1):
    for b in range(997, 2, -1):
        for a in range(996, 1, -1):
            if (a + b + c != 1000):
                continue

            if (c > b and b > a):

                if ((a**2 + b**2) == c**2):
                    print "a:",a , "b:", b , "c:", c
                    exit(1)
'''

# simple answer
print [(x,y,1000-x-y) for x in range(1,1000) for y in range(1,x) if x**2+y**2==(1000-x-y)**2]
