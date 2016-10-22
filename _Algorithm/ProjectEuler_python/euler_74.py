#!/usr/bin/python -Wall
# -*- coding: utf-8 -*-
"""
<div id="content">
<div style="text-align:center;" class="print"><img src="images/print_page_logo.png" alt="projecteuler.net" style="border:none;" /></div>
<h2>Digit factorial chains</h2><div id="problem_info" class="info"><h3>Problem 74</h3><span>Published on Friday, 16th July 2004, 06:00 pm; Solved by 16074; Difficulty rating: 15%</span></div>
<div class="problem_content" role="problem">
<p>The number 145 is well known for the property that the sum of the factorial of its digits is equal to 145:</p>
<p style="margin-left:50px;">1! + 4! + 5! = 1 + 24 + 120 = 145</p>
<p>Perhaps less well known is 169, in that it produces the longest chain of numbers that link back to 169; it turns out that there are only three such loops that exist:</p>
<p style="margin-left:50px;">169 &rarr; 363601 &rarr; 1454 &rarr; 169<br />
871 &rarr; 45361 &rarr; 871<br />
872 &rarr; 45362 &rarr; 872</p>
<p>It is not difficult to prove that EVERY starting number will eventually get stuck in a loop. For example,</p>
<p style="margin-left:50px;">69 &rarr; 363600 &rarr; 1454 &rarr; 169 &rarr; 363601 (&rarr; 1454)<br />
78 &rarr; 45360 &rarr; 871 &rarr; 45361 (&rarr; 871)<br />
540 &rarr; 145 (&rarr; 145)</p>
<p>Starting with 69 produces a chain of five non-repeating terms, but the longest non-repeating chain with a starting number below one million is sixty terms.</p>
<p>How many chains, with a starting number below one million, contain exactly sixty non-repeating terms?</p>
</div><br />
<br /></div>
"""

import math

MAXNUM=1000001
MAXNUM=10000

f = [0, 1, 2, 6, 24, 120, 720, 5040, 40320, 362880]

def Chk(n):
    s = str(n)
    l = len(s)
    t = 0
    for i in range(0, l):
        t += f[int(s[i])]

    return t

def E74():
    a = []
    for i in range(2, MAXNUM):
        bf = 0 # break flag
        cnt = 1
        del a[:]
        n = i
        total_cnt=0
        while True:
            t = Chk(n)
            if (t == 1):
                break
            for j in a:
                if j == t:
                    if cnt == 60:
                        total_cnt+=1
                    #print "same, break", j,"=", t, "i=",i, "cnt=",cnt
                    bf = 1
                    break

            if bf == 1:
                bf = 0
                break
                
            cnt+=1

            a.append(t)
            n = t
    print "total=", total_cnt
    return 0

E74()
