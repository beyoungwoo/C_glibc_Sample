#!/usr/bin/python -Wall
# -*- coding: utf-8 -*-
"""
<div id="content">
<div style="text-align:center;" class="print"><img src="images/print_page_logo.png" alt="projecteuler.net" style="border:none;" /></div>
<h2>Summation of primes</h2><div id="problem_info" class="info"><h3>Problem 10</h3><span>Published on Friday, 8th February 2002, 06:00 pm; Solved by 183342; Difficulty rating: 5%</span></div>
<div class="problem_content" role="problem">
<p>The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.</p>
<p>Find the sum of all the primes below two million.</p>
<!--
&lt;p class="note"&gt;Note: This problem has been changed recently, please check that you are using the right parameters.&lt;/p&gt;
-->
</div><br />
<br /></div>
"""

from Euler import is_prime

def P(n):
    all_sum = 0
    i = 0
    while i <= n:
        if (is_prime(i)):
            all_sum += i
        i += 1

    return all_sum


result = P(2000000)
print "ret =", result
