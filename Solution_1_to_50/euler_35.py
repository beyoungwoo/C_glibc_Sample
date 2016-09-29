#!/usr/bin/python -Wall
# -*- coding: utf-8 -*-
"""
<div id="content">
<div style="text-align:center;" class="print"><img src="images/print_page_logo.png" alt="projecteuler.net" style="border:none;" /></div>
<h2>Circular primes</h2><div id="problem_info" class="info"><h3>Problem 35</h3><span>Published on Friday, 17th January 2003, 06:00 pm; Solved by 51820; Difficulty rating: 5%</span></div>
<div class="problem_content" role="problem">
<p>The number, 197, is called a circular prime because all rotations of the digits: 197, 971, and 719, are themselves prime.</p>
<p>There are thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17, 31, 37, 71, 73, 79, and 97.</p>
<p>How many circular primes are there below one million?</p>
</div><br />
<br /></div>
"""

from Euler import is_prime

def CirPrime(num):
    buf = str(num)
    len_buf = len(buf)

    devide = 1
    for i in range (0, len_buf-1):
        devide *= 10

    new_num = num
    for i in range(0, len_buf):
        #print new_num
        if (is_prime(new_num)) :
            d1 = new_num / devide
            d2 = new_num % devide
            new_num = d2 * 10 + d1
        else :
            return -1

    return 0
        


cnt = 0
result = 0
for idx in range (2, 1000001):
    ret = CirPrime(idx)
    if (ret == 0):
        result += idx
        cnt += 1

print "result =", cnt
