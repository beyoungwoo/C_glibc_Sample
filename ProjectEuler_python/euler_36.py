#!/usr/bin/python -Wall
# -*- coding: utf-8 -*-
"""
<div id="content">
<div style="text-align:center;" class="print"><img src="images/print_page_logo.png" alt="projecteuler.net" style="border:none;" /></div>
<h2>Double-base palindromes</h2><div id="problem_info" class="info"><h3>Problem 36</h3><span>Published on Friday, 31st January 2003, 06:00 pm; Solved by 54853; Difficulty rating: 5%</span></div>
<div class="problem_content" role="problem">
<p>The decimal number, 585 = 1001001001<sub>2</sub> (binary), is palindromic in both bases.</p>
<p>Find the sum of all numbers, less than one million, which are palindromic in base 10 and base 2.</p>
<p class="info">(Please note that the palindromic number, in either base, may not include leading zeros.)</p>
</div><br />
<br /></div>
"""

from Euler import is_palindromic

result = 0
for i in range(1, 1000000):
    if (is_palindromic("{0:b}".format(i))):
        if (is_palindromic(str(i))) :
            print i
            result += i


print "result = ", result
