#!/usr/bin/python -Wall
# -*- coding: utf-8 -*-
"""
<div id="content">
<div style="text-align:center;" class="print"><img src="images/print_page_logo.png" alt="projecteuler.net" style="border:none;" /></div>
<h2>Coin sums</h2><div id="problem_info" class="info"><h3>Problem 31</h3><span>Published on Friday, 22nd November 2002, 06:00 pm; Solved by 49184; Difficulty rating: 5%</span></div>
<div class="problem_content" role="problem">
<p>In England the currency is made up of pound, &pound;, and pence, p, and there are eight coins in general circulation:</p>
<blockquote>1p, 2p, 5p, 10p, 20p, 50p, &pound;1 (100p) and &pound;2 (200p).</blockquote>
<p>It is possible to make &pound;2 in the following way:</p>
<blockquote>1&times;&pound;1 + 1&times;50p + 2&times;20p + 1&times;5p + 1&times;2p + 3&times;1p</blockquote>
<p>How many different ways can &pound;2 be made using any number of coins?</p>
</div><br />
<br /></div>
"""
max_coin = 200
count = 0

for a in range(max_coin, -1, -200):
    for b in range(a, -1, -100):
        for c in range(b, -1, -50):
            for d in range(c, -1, -20):
                for e in range(d, -1, -10):
                    for f in range(e, -1, -5):
                        for g in range(f, -1, -2):
                            count += 1


print "count=",count
