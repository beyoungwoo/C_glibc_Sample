#!/usr/bin/python -Wall
# -*- coding: utf-8 -*-
"""
<div id="content">
<div style="text-align:center;" class="print"><img src="images/print_page_logo.png" alt="projecteuler.net" style="border:none;" /></div>
<h2>Smallest multiple</h2><div id="problem_info" class="info"><h3>Problem 5</h3><span>Published on Friday, 30th November 2001, 06:00 pm; Solved by 267040; Difficulty rating: 5%</span></div>
<div class="problem_content" role="problem">
<p>2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.</p>
<p>What is the smallest positive number that is <dfn title="divisible with no remainder">evenly divisible</dfn> by all of the numbers from 1 to 20?</p>
</div><br />
<br /></div>
"""

def P():
    i = 1
    for k in (range(1, 21)):
        if i % k > 0:
            for j in range(1, 21):
                if (i*j) % k == 0:
                    i *= j
                    break
    print i

P()


def P2():
    # brute force 
    # loop 1~20 then divide each number
    return 
