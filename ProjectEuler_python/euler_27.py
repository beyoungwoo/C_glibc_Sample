#!/usr/bin/python -Wall
# -*- coding: utf-8 -*-
"""
<div id="content">
<div style="text-align:center;" class="print"><img src="images/print_page_logo.png" alt="projecteuler.net" style="border:none;" /></div>
<h2>Quadratic primes</h2><div id="problem_info" class="info"><h3>Problem 27</h3><span>Published on Friday, 27th September 2002, 06:00 pm; Solved by 51713; Difficulty rating: 5%</span></div>
<div class="problem_content" role="problem">
<p>Euler discovered the remarkable quadratic formula:</p>
<p style="text-align:center;"><i>n</i>&sup2; + <i>n</i> + 41</p>
<p>It turns out that the formula will produce 40 primes for the consecutive values <i>n</i> = 0 to 39. However, when <i>n</i> = 40, 40<sup>2</sup> + 40 + 41 = 40(40 + 1) + 41 is divisible by 41, and certainly when <i>n</i> = 41, 41&sup2; + 41 + 41 is clearly divisible by 41.</p>
<p>The incredible formula &nbsp;<i>n</i>&sup2; &minus; 79<i>n</i> + 1601 was discovered, which produces 80 primes for the consecutive values <i>n</i> = 0 to 79. The product of the coefficients, &minus;79 and 1601, is &minus;126479.</p>
<p>Considering quadratics of the form:</p>
<blockquote>
<i>n</i>&sup2; + <i>an</i> + <i>b</i>, where |<i>a</i>| &lt; 1000 and |<i>b</i>| &lt; 1000<br /><br />
<div class="info" style="text-align:left;">where |<i>n</i>| is the modulus/absolute value of <i>n</i><br />e.g. |11| = 11 and |&minus;4| = 4</div>
</blockquote>
<p>Find the product of the coefficients, <i>a</i> and <i>b</i>, for the quadratic expression that produces the maximum number of primes for consecutive values of <i>n</i>, starting with <i>n</i> = 0.</p>
</div><br />
<br /></div>
"""

from Euler import is_prime

max_cnt = 0
max_a = 0
max_b = 0

for a in range (-1000, 1001):
    for b in range (-1000, 1001):
        n = 0
        while (True):
            result = (n*n) + (a*n) + b
            if (is_prime(result)):
                n += 1
            else:
                if (max_cnt < n):
                    max_cnt = n
                    max_a = a
                    max_b = b
                break


print max_cnt, max_a, max_b
print "result=", (max_a * max_b)
