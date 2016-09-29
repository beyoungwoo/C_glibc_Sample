#!/usr/bin/python -Wall
# -*- coding: utf-8 -*-
"""
<div id="content">
<div style="text-align:center;" class="print"><img src="images/print_page_logo.png" alt="projecteuler.net" style="border:none;" /></div>
<h2>Goldbach's other conjecture</h2><div id="problem_info" class="info"><h3>Problem 46</h3><span>Published on Friday, 20th June 2003, 06:00 pm; Solved by 35901; Difficulty rating: 5%</span></div>
<div class="problem_content" role="problem">
<p>It was proposed by Christian Goldbach that every odd composite number can be written as the sum of a prime and twice a square.</p>
<p style="margin-left:10px;">9 = 7 + 2&times;1<sup>2</sup><br />
15 = 7 + 2&times;2<sup>2</sup><br />
21 = 3 + 2&times;3<sup>2</sup><br />
25 = 7 + 2&times;3<sup>2</sup><br />
27 = 19 + 2&times;2<sup>2</sup><br />
33 = 31 + 2&times;1<sup>2</sup></p>
<p>It turns out that the conjecture was false.</p>
<p>What is the smallest odd composite that cannot be written as the sum of a prime and twice a square?</p>
</div><br />
<br /></div>
"""

from Euler import is_prime 
import math

def FindPrimeAndTwiceSquare(n):
    max_twice = math.sqrt(n)
    print n, max_twice
    for i in range(1, int(max_twice)):
        if (2 * (i **2)) > n:
            break

        prime = n - (2 * (i ** 2))
        print prime, n
        if (is_prime(prime)) == True:
            print i, "=", prime, "+", "2 x ", i, "^2"
            return True
        #else :
        #    print "not....",i, "=", prime, "+", "2 x ", i, "^2"

    return False

MAX_LIMIT = 1000000
count = 0
for i in range(3, MAX_LIMIT, 2):
    if (is_prime(i) == True):
        continue

    if (FindPrimeAndTwiceSquare(i) == False):
        print "(DONE) result = [",i,"]"
        exit(0)
