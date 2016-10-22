#!/usr/bin/python -Wall
# -*- coding: utf-8 -*-
"""
<div id="content">
<div style="text-align:center;" class="print"><img src="images/print_page_logo.png" alt="projecteuler.net" style="border:none;" /></div>
<h2>Lattice paths</h2><div id="problem_info" class="info"><h3>Problem 15</h3><span>Published on Friday, 19th April 2002, 06:00 pm; Solved by 107582; Difficulty rating: 5%</span></div>
<div class="problem_content" role="problem">
<p>Starting in the top left corner of a 2&times;2 grid, and only being able to move to the right and down, there are exactly 6 routes to the bottom right corner.</p>
<div style="text-align:center;">
<img src="project/images/p015.gif" alt="" />
</div>
<p>How many such routes are there through a 20&times;20 grid?</p>
</div><br />
<br /></div>
"""
from Euler import factorial
def P():
    a = 20
    b = 20

    print (factorial(a+b))/((factorial(a)) * (factorial(b)))
    return 0

P()
