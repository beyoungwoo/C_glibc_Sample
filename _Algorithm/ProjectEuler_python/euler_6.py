#!/usr/bin/python -Wall
# -*- coding: utf-8 -*-
"""
<div id="content">
<div style="text-align:center;" class="print"><img src="images/print_page_logo.png" alt="projecteuler.net" style="border:none;" /></div>
<h2>Sum square difference</h2><div id="problem_info" class="info"><h3>Problem 6</h3><span>Published on Friday, 14th December 2001, 06:00 pm; Solved by 268921; Difficulty rating: 5%</span></div>
<div class="problem_content" role="problem">
<p>The sum of the squares of the first ten natural numbers is,</p>
<div style="text-align:center">1<sup>2</sup> + 2<sup>2</sup> + ... + 10<sup>2</sup> = 385</div>
<p>The square of the sum of the first ten natural numbers is,</p>
<div style="text-align:center">(1 + 2 + ... + 10)<sup>2</sup> = 55<sup>2</sup> = 3025</div>
<p>Hence the difference between the sum of the squares of the first ten natural numbers and the square of the sum is 3025 &minus; 385 = 2640.</p>
<p>Find the difference between the sum of the squares of the first one hundred natural numbers and the square of the sum.</p>
</div><br />
<br /></div>
"""
def problem6(r):
    return sum(r)** 2- sum([x** 2 for x in r])

print problem6(range(1, 101))
