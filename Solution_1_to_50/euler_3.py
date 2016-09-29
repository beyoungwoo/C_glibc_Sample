#!/usr/bin/python -Wall
# -*- coding: utf-8 -*-
"""
<div id="content">
<div style="text-align:center;" class="print"><img src="images/print_page_logo.png" alt="projecteuler.net" style="border:none;" /></div>
<h2>Largest prime factor</h2><div id="problem_info" class="info"><h3>Problem 3</h3><span>Published on Friday, 2nd November 2001, 06:00 pm; Solved by 281868; Difficulty rating: 5%</span></div>
<div class="problem_content" role="problem">
<p>The prime factors of 13195 are 5, 7, 13 and 29.</p>
<p>What is the largest prime factor of the number 600851475143 ?</p>
<!--
Note: This problem has been changed recently, please check that you are using the right number.
-->
</div><br />
<br /></div>
"""


from Euler import is_prime

#limit = 13195
limit = 600851475143

i = 3
max_num = 0
for i in range (i, 10000):
    if (is_prime(i)):
        if (limit % i == 0):
            temp = limit // i
            max_num = i


print "max =", max_num
