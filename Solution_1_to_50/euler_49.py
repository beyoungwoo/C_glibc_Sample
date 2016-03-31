#!/usr/bin/python -Wall
# -*- coding: utf-8 -*-
"""
<div id="content">
<div style="text-align:center;" class="print"><img src="images/print_page_logo.png" alt="projecteuler.net" style="border:none;" /></div>
<h2>Prime permutations</h2><div id="problem_info" class="info"><h3>Problem 49</h3><span>Published on Friday, 1st August 2003, 06:00 pm; Solved by 34074; Difficulty rating: 5%</span></div>
<div class="problem_content" role="problem">
<p>The arithmetic sequence, 1487, 4817, 8147, in which each of the terms increases by 3330, is unusual in two ways: (i) each of the three terms are prime, and, (ii) each of the 4-digit numbers are permutations of one another.</p>
<p>There are no arithmetic sequences made up of three 1-, 2-, or 3-digit primes, exhibiting this property, but there is one other 4-digit increasing sequence.</p>
<p>What 12-digit number do you form by concatenating the three terms in this sequence?</p>
</div><br />
<br /></div>
"""
from Euler import is_prime
import itertools

def E49():
    prime_perm = [ ]
    for i in range(1487, 10000):
        if is_prime(i) == False: continue

        plist = list(itertools.permutations(str(i)))
        for each_num in plist:
            num =  "".join(map(str, each_num))
            if is_prime(num) == True:
                prime_perm.append(num)

        len_p = len(prime_perm)
        for j in range(0, len_p-1):
            for k in range(j+1, len_p):
                if prime_perm[k] == prime_perm[j]: continue

                diff = int(prime_perm[k]) - int(prime_perm[j])
                next_num = int(prime_perm[k]) + diff

                if (str(next_num) in prime_perm) == True :
                    print prime_perm[j], prime_perm[k], next_num


        del prime_perm[:]

    return 0

E49()
