#!/usr/bin/python -Wall
# -*- coding: utf-8 -*-
"""
<div id="content">
<div style="text-align:center;" class="print"><img src="images/print_page_logo.png" alt="projecteuler.net" style="border:none;" /></div>
<h2>1000-digit Fibonacci number</h2><div id="problem_info" class="info"><h3>Problem 25</h3><span>Published on Friday, 30th August 2002, 06:00 pm; Solved by 92640; Difficulty rating: 5%</span></div>
<div class="problem_content" role="problem">
<p>The Fibonacci sequence is defined by the recurrence relation:</p>
<blockquote>F<sub><i>n</i></sub> = F<sub><i>n</i>&minus;1</sub> + F<sub><i>n</i>&minus;2</sub>, where F<sub>1</sub> = 1 and F<sub>2</sub> = 1.</blockquote>
<p>Hence the first 12 terms will be:</p>
<blockquote>F<sub>1</sub> = 1<br />
F<sub>2</sub> = 1<br />
F<sub>3</sub> = 2<br />
F<sub>4</sub> = 3<br />
F<sub>5</sub> = 5<br />
F<sub>6</sub> = 8<br />
F<sub>7</sub> = 13<br />
F<sub>8</sub> = 21<br />
F<sub>9</sub> = 34<br />
F<sub>10</sub> = 55<br />
F<sub>11</sub> = 89<br />
F<sub>12</sub> = 144</blockquote>
<p>The 12th term, F<sub>12</sub>, is the first term to contain three digits.</p>
<p>What is the index of the first term in the Fibonacci sequence to contain 1000 digits?</p>
</div><br />
<br /></div>
"""

from Euler import fibonacci

for i in (range (1000, 10000)):
    ret = fibonacci(i)
    if (len(str(ret))) >= 1000:
        print "ret =",ret, "len=",  len(str(ret))
        break


print "F",i
