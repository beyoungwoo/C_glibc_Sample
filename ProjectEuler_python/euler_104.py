#!/usr/bin/python -Wall
# -*- coding: utf-8 -*-
"""
<div id="content">
<div style="text-align:center;" class="print"><img src="images/print_page_logo.png" alt="projecteuler.net" style="border:none;" /></div>
<h2>Pandigital Fibonacci ends</h2><div id="problem_info" class="info"><h3>Problem 104</h3><span>Published on Friday, 9th September 2005, 06:00 pm; Solved by 10143; Difficulty rating: 25%</span></div>
<div class="problem_content" role="problem">
<p>The Fibonacci sequence is defined by the recurrence relation:</p>
<blockquote>F<sub><i>n</i></sub> = F<sub><i>n</i>&minus;1</sub> + F<sub><i>n</i>&minus;2</sub>, where F<sub>1</sub> = 1 and F<sub>2</sub> = 1.</blockquote>
<p>It turns out that F<sub>541</sub>, which contains 113 digits, is the first Fibonacci number for which the last nine digits are 1-9 pandigital (contain all the digits 1 to 9, but not necessarily in order). And F<sub>2749</sub>, which contains 575 digits, is the first Fibonacci number for which the first nine digits are 1-9 pandigital.</p>
<p>Given that F<sub><i>k</i></sub> is the first Fibonacci number for which the first nine digits AND the last nine digits are 1-9 pandigital, find <i>k</i>.</p>
</div><br />
<br /></div>
"""

from Euler import fibonacci

def E104():
    ni = 1
    oi = 1
    temp = 0
    i = 2
    while True:
        if is_pandigital(ni%1000000000) == True:
            print ni, str(ni)[0:9], (i)
            if is_pandigital(int(str(ni)[0:9])) == True:
                print i
                return 0
        temp = ni
        ni = ni+oi
        oi = temp
        i+=1

E104()
