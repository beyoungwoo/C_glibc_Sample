#!/usr/bin/python -Wall
# -*- coding: utf-8 -*-
"""
<div id="content">
<div style="text-align:center;" class="print"><img src="images/print_page_logo.png" alt="projecteuler.net" style="border:none;" /></div>
<h2>Cubic permutations</h2><div id="problem_info" class="info"><h3>Problem 62</h3><span>Published on Friday, 30th January 2004, 06:00 pm; Solved by 18313; Difficulty rating: 15%</span></div>
<div class="problem_content" role="problem">
<p>The cube, 41063625 (345<sup>3</sup>), can be permuted to produce two other cubes: 56623104 (384<sup>3</sup>) and 66430125 (405<sup>3</sup>). In fact, 41063625 is the smallest cube which has exactly three permutations of its digits which are also cube.</p>
<p>Find the smallest cube for which exactly five permutations of its digits are cube.</p>
</div><br />
<br /></div>
"""

from Euler import is_perm

MIN_NUM = 300 
MAX_NUM = 1000

for i in range(MIN_NUM, MAX_NUM):
    num_i = i * i * i 
    for j in range(MIN_NUM, MAX_NUM):
        if (i == j):
            continue;

        num_j = j * j * j 
        if (is_perm(num_i, num_j) == False):
            continue

        for k in range(MIN_NUM, MAX_NUM):
            if (i == k or j == k):
                continue

            num_k = k * k * k 
            if (is_perm(num_j, num_k) == False):
                continue

            for l in range(MIN_NUM, MAX_NUM):
                if (i == l or j == l or k == l):
                    continue
    
                num_l = l * l * l 
                if (is_perm(num_k, num_l) == False):
                    continue

                for m in range(MIN_NUM, MAX_NUM):
                    if (i == m or j == m or k == m or l == m):
                        continue
        
                    num_m = m * m * m 
                    if (is_perm(num_l, num_m) == True):
                        print num_i, num_j, num_k, num_l, num_m, i


        

