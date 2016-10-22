#!/usr/bin/python -Wall
# -*- coding: utf-8 -*-
"""
<div id="content">
<div style="text-align:center;" class="print"><img src="images/print_page_logo.png" alt="projecteuler.net" style="border:none;" /></div>
<h2>Truncatable primes</h2><div id="problem_info" class="info"><h3>Problem 37</h3><span>Published on Friday, 14th February 2003, 06:00 pm; Solved by 44217; Difficulty rating: 5%</span></div>
<div class="problem_content" role="problem">
<p>The number 3797 has an interesting property. Being prime itself, it is possible to continuously remove digits from left to right, and remain prime at each stage: 3797, 797, 97, and 7. Similarly we can work from right to left: 3797, 379, 37, and 3.</p>
<p>Find the sum of the only eleven primes that are both truncatable from left to right and right to left.</p>
<p class="info">NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.</p>
</div><br />
<br /></div>
"""

from Euler import is_prime

def CheckLeft(num):
    devide = 1
    for i in range (0, len(str(num))):
        devide *= 10
        res = num % devide
        if (is_prime(res) != True):
            return -1

    return 0

def CheckRight(num):
    devide = 1
    if (is_prime(num) != True):
        return -1

    for i in range (0, len(str(num))-1):
        num = num / 10
        if (is_prime(num) != True):
            return -1

    return 0

#for i in range(10, 100):
result = 0
for i in range(10, 1000000):
    if (is_prime(i)):
        if (CheckLeft(i) == 0):
            if (CheckRight(i) == 0):
                print "result", i
                result += i



print "total=",result
