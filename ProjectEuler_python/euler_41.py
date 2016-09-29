#!/usr/bin/python -Wall
# -*- coding: utf-8 -*-
"""
<div id="content">
<div style="text-align:center;" class="print"><img src="images/print_page_logo.png" alt="projecteuler.net" style="border:none;" /></div>
<h2>Pandigital prime</h2><div id="problem_info" class="info"><h3>Problem 41</h3><span>Published on Friday, 11th April 2003, 06:00 pm; Solved by 40663; Difficulty rating: 5%</span></div>
<div class="problem_content" role="problem">
<p>We shall say that an <i>n</i>-digit number is pandigital if it makes use of all the digits 1 to <i>n</i> exactly once. For example, 2143 is a 4-digit pandigital and is also prime.</p>
<p>What is the largest <i>n</i>-digit pandigital prime that exists?</p>
</div><br />
<br /></div>
"""

#Nine numbers cannot be done (1+2+3+4+5+6+7+8+9=45 => always dividable by 3)
#Eight numbers cannot be done (1+2+3+4+5+6+7+8=36 => always dividable by 3)

from Euler import is_prime
count = 0

for a1 in range(1, 8):
    BUF = [0,0,0,0,0,0,0,0,0,0]
    BUF[a1] = 1
    for a2 in range(1, 8):
        if (BUF[a2] == 1):
            continue
        BUF[a2] = 1
        for a3 in range(1, 8):
            if (BUF[a3] == 1):
                continue
            BUF[a3] = 1
            for a4 in range(1, 8):
                if (BUF[a4] == 1):
                    continue
                BUF[a4] = 1
                for a5 in range(1, 8):
                    if (BUF[a5] == 1):
                        continue
                    BUF[a5] = 1
                    for a6 in range(1, 8):
                        if (BUF[a6] == 1):
                            continue
                        BUF[a6] = 1
                        for a7 in range(1, 8):
                            if (BUF[a7] == 1):
                                continue
                            count += 1
                            buf = "%d%d%d%d%d%d%d" % (a1,a2,a3,a4,a5,a6,a7)
                            if (is_prime(int(buf)) == True):
                                print "prime = ", buf
                            BUF[a7] = 0
                        BUF[a6] = 0
                    BUF[a5] = 0
                BUF[a4] = 0
            BUF[a3] = 0
        BUF[a2] = 0


'''
for a1 in range(1, 10):
    BUF = [0,0,0,0,0,0,0,0,0,0]
    BUF[a1] = 1
    for a2 in range(1, 10):
        if (BUF[a2] == 1):
            continue
        BUF[a2] = 1
        for a3 in range(1, 10):
            if (BUF[a3] == 1):
                continue
            BUF[a3] = 1
            for a4 in range(1, 10):
                if (BUF[a4] == 1):
                    continue
                BUF[a4] = 1
                for a5 in range(1, 10):
                    if (BUF[a5] == 1):
                        continue
                    BUF[a5] = 1
                    for a6 in range(1, 10):
                        if (BUF[a6] == 1):
                            continue
                        BUF[a6] = 1
                        for a7 in range(1, 10):
                            if (BUF[a7] == 1):
                                continue
                            BUF[a7] = 1
                            for a8 in range(1, 10):
                                if (BUF[a8] == 1):
                                    continue
                                BUF[a8] = 1
                                for a9 in range(1, 10):
                                    if (BUF[a9] == 1):
                                        continue
                                    count += 1
                                    buf = "%d%d%d%d%d%d%d%d%d" % (a1,a2,a3,a4,a5,a6,a7,a8,a9)
                                    print buf
                                    if (is_prime(int(buf)) == True):
                                        print "prime = ", buf
                     
                                    BUF[a9] = 0
                                BUF[a8] = 0
                            BUF[a7] = 0
                        BUF[a6] = 0
                    BUF[a5] = 0
                BUF[a4] = 0
            BUF[a3] = 0
        BUF[a2] = 0

print "count=",count, 9*8*7*6*5*4*3*2*1
'''
