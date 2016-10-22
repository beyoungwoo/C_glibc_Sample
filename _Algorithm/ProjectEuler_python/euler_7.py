#!/usr/bin/python -Wall
# -*- coding: utf-8 -*-
"""
<div id="content">
<div style="text-align:center;" class="print"><img src="images/print_page_logo.png" alt="projecteuler.net" style="border:none;" /></div>
<h2>10001st prime</h2><div id="problem_info" class="info"><h3>Problem 7</h3><span>Published on Friday, 28th December 2001, 06:00 pm; Solved by 230541; Difficulty rating: 5%</span></div>
<div class="problem_content" role="problem">
<p>By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.</p>
<p>What is the 10 001st prime number?</p>
</div><br />
<br /></div>
"""

from Euler import is_prime

def Get_P(n) :
    i = 2
    prime_th = 0
    while (1):
        if (prime_th == n):
            return (i-1)
            break

        if (is_prime(i)):
            prime_th += 1

        i += 1


print Get_P(10001)
