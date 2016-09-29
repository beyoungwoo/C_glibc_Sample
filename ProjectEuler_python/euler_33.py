#!/usr/bin/python -Wall
# -*- coding: utf-8 -*-
"""
<div id="content">
<div style="text-align:center;" class="print"><img src="images/print_page_logo.png" alt="projecteuler.net" style="border:none;" /></div>
<h2>Digit cancelling fractions</h2><div id="problem_info" class="info"><h3>Problem 33</h3><span>Published on Friday, 20th December 2002, 06:00 pm; Solved by 43051; Difficulty rating: 5%</span></div>
<div class="problem_content" role="problem">
<p>The fraction <sup>49</sup>/<sub>98</sub> is a curious fraction, as an inexperienced mathematician in attempting to simplify it may incorrectly believe that <sup>49</sup>/<sub>98</sub> = <sup>4</sup>/<sub>8</sub>, which is correct, is obtained by cancelling the 9s.</p>
<p>We shall consider fractions like, <sup>30</sup>/<sub>50</sub> = <sup>3</sup>/<sub>5</sub>, to be trivial examples.</p>
<p>There are exactly four non-trivial examples of this type of fraction, less than one in value, and containing two digits in the numerator and denominator.</p>
<p>If the product of these four fractions is given in its lowest common terms, find the value of the denominator.</p>
</div><br />
<br /></div>
"""

res_i = 1  
res_j = 1    


for i in range(10, 100):
    for j in range(10, 100):
        if (i >= j):
            continue

        a = i/10
        b = i%10
        c = j/10
        d = j%10

        if (a == 0 or b == 0 or c == 0 or d == 0):
            continue



        if (a == c):
            d1 = float(i)/float(j)
            d2 = float(b)/float(d)
        elif (a == d):
            d1 = float(i)/float(j)
            d2 = float(b)/float(c)
        elif (b == c):
            d1 = float(i)/float(j)
            d2 = float(a)/float(d)
        elif (b == d):
            d1 = float(a)/float(c)
            d2 = float(b)/float(c)

        if (d1 == d2):
            print i, j, "d1=",d1,"d2=",d2
            res_i *= i
            res_j *= j


print "res", float(res_j)/float(res_i)
