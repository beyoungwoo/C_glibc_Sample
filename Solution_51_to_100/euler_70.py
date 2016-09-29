#!/usr/bin/python -Wall
# -*- coding: utf-8 -*-
"""
<div id="content">
<div style="text-align:center;" class="print"><img src="images/print_page_logo.png" alt="projecteuler.net" style="border:none;" /></div>
<h2>Totient permutation</h2><div id="problem_info" class="info"><h3>Problem 70</h3><span>Published on Friday, 21st May 2004, 06:00 pm; Solved by 13419; Difficulty rating: 20%</span></div>
<div class="problem_content" role="problem">
<p>Euler's Totient function, &phi;(<var>n</var>) [sometimes called the phi function], is used to determine the number of positive numbers less than or equal to <var>n</var> which are relatively prime to <var>n</var>. For example, as 1, 2, 4, 5, 7, and 8, are all less than nine and relatively prime to nine, &phi;(9)=6.<br />The number 1 is considered to be relatively prime to every positive number, so &phi;(1)=1. </p>
<p>Interestingly, &phi;(87109)=79180, and it can be seen that 87109 is a permutation of 79180.</p>
<p>Find the value of <var>n</var>, 1 &lt; <var>n</var> &lt; 10<sup>7</sup>, for which &phi;(<var>n</var>) is a permutation of <var>n</var> and the ratio <var>n</var>/&phi;(<var>n</var>) produces a minimum.</p>
</div><br />
<br /></div>
"""
from Euler import is_prime
from Euler import is_perm
from Euler import factor

MAXNUM = 10**7

MAXNUM = 10**7
def E70():
    res = 0
    min_res = 100
    min_i = 100
    p_set = []
    for i in range (3, MAXNUM, 2):
        if is_prime(i) == True:
            continue

        p_set = factor(i)
        if len(p_set) != 2:
            continue

        if int(p_set[0][1])!=1 or int(p_set[1][1])!=1:
            continue

        # [(421, 1), (571, 1)] <- both are 1
        cnt = i - (int(p_set[0][0])+int(p_set[1][0])-1)
        if is_perm(i, cnt) == False:
            continue

        res = float(i)/float(cnt)
        if min_res >= res:
            min_res = res
            min_i = i
            #print min_res, min_i, cnt, (1, p_set[0][0], p_set[1][0], i)

    print "result", min_res, min_i
    return 0

E70()
'''
def E70():
    res = 0
    min_res = 100
    min_i = 100
    for i in range (2, MAXNUM):
        if i % 2 == 0:
            continue;
        if is_prime(i) == True:
            continue

        c_cnt = 0
        a1 = 0
        a2 = 0
        for j in range (3, i, 2):
            if i%j == 0:
                c_cnt+=1
                if c_cnt > 3:
                    break

        if c_cnt != 2:
            continue

        cnt = 2
        for j in range (2, i):
            if gcd(i, j) == 1:
                cnt+=1

        if is_perm(i, cnt) == False:
            continue

        res = float(i)/float(cnt)
        if min_res >= res:
            min_res = res
            min_i = i
            print min_res, min_i, cnt

    print min_res, min_i
    return 0

E70()
'''
