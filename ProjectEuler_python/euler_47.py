#!/usr/bin/python -Wall
# -*- coding: utf-8 -*-
"""
<div id="content">
<div style="text-align:center;" class="print"><img src="images/print_page_logo.png" alt="projecteuler.net" style="border:none;" /></div>
<h2>Distinct primes factors</h2><div id="problem_info" class="info"><h3>Problem 47</h3><span>Published on Friday, 4th July 2003, 06:00 pm; Solved by 34214; Difficulty rating: 5%</span></div>
<div class="problem_content" role="problem">
<p>The first two consecutive numbers to have two distinct prime factors are:</p>
<p style="margin-left:100px;">14 = 2 &times; 7<br />15 = 3 &times; 5</p>
<p>The first three consecutive numbers to have three distinct prime factors are:</p>
<p style="margin-left:100px;">644 = 2&sup2; &times; 7 &times; 23<br />645 = 3 &times; 5 &times; 43<br />646 = 2 &times; 17 &times; 19.</p>
<p>Find the first four consecutive integers to have four distinct prime factors. What is the first of these numbers?</p>
</div><br />
<br /></div>
"""
from Euler import is_prime


# best
from Euler import factor

ci = 1
nf = 4      # number of distinct factors
ns = 4      # number of consecutive integers
n = 2*3*5*7 # starting candidate for search
while ci != ns:
    n += 1
    if len(factor(n)) == nf: 
        ci += 1 
        print n, ci, nf, factor(n)
    else: ci = 0

print "Project Euler 47 Solution =", n-nf + 1

# slow 
'''
ps = [ ]
i = 0
num = 1
while (i != 200):
    if (is_prime(num) == True):
        i+=1
        ps.append(num)

    num+=1

#for i in ps:
#    print i

def CheckPrimeFactor(num):
    pf_cnt = 0
    temp = num
    for x in ps:
        tr = temp % int(x) #temp rest
        if (tr == 0) :
            temp //= int(x)
            pf_cnt += 1
            while (temp % int(x) == 0) :
                temp //= int(x)

#            print "(DBG)","input=", num, "temp=", temp , "devider=",x, 'cnt=', pf_cnt
        else :
            continue

        if (temp <=3):
            break

    if (pf_cnt >= 4) :
        return True
    else :
        return False
        

for i in range(1000, 1000000):
    flag = 0
    for j in range(i, i+4):
        if (CheckPrimeFactor(j) == False):
            flag = 1
            break

    if (flag == 0):
        print "found = ", j-3
        break
'''
