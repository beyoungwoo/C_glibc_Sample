#!/usr/bin/python -Wall
# -*- coding: utf-8 -*-
"""
<div id="content">
<div style="text-align:center;" class="print"><img src="images/print_page_logo.png" alt="projecteuler.net" style="border:none;" /></div>
<h2>Number spiral diagonals</h2><div id="problem_info" class="info"><h3>Problem 28</h3><span>Published on Friday, 11th October 2002, 06:00 pm; Solved by 67110; Difficulty rating: 5%</span></div>
<div class="problem_content" role="problem">
<p>Starting with the number 1 and moving to the right in a clockwise direction a 5 by 5 spiral is formed as follows:</p>
<p style="text-align:center;font-family:courier new;"><span style="color:#ff0000;font-family:courier new;"><b>21</b></span> 22 23 24 <span style="color:#ff0000;font-family:courier new;"><b>25</b></span><br />
20 &nbsp;<span style="color:#ff0000;font-family:courier new;"><b>7</b></span> &nbsp;8 &nbsp;<span style="color:#ff0000;font-family:courier new;"><b>9</b></span> 10<br />
19 &nbsp;6 &nbsp;<span style="color:#ff0000;font-family:courier new;"><b>1</b></span> &nbsp;2 11<br />
18 &nbsp;<span style="color:#ff0000;font-family:courier new;"><b>5</b></span> &nbsp;4 &nbsp;<span style="color:#ff0000;font-family:courier new;"><b>3</b></span> 12<br />
<span style="color:#ff0000;font-family:courier new;"><b>17</b></span> 16 15 14 <span style="color:#ff0000;font-family:courier new;"><b>13</b></span></p>
<p>It can be verified that the sum of the numbers on the diagonals is 101.</p>
<p>What is the sum of the numbers on the diagonals in a 1001 by 1001 spiral formed in the same way?</p>
</div><br />
<br /></div>
"""


# 1 7 21 43 73 
# 1 3 13 31 57 
# 1 5 17 37 65 
# 1 9 25 49 81 

MAX_LIMIT = 1001

total = 0
a1 = 0
for i in range(1, MAX_LIMIT+1):
    if (i >= MAX_LIMIT+1): break
    if (i%2 != 0):
        a1 = (i * i)
        total += a1
        print a1

n = 0
a = 1
while (a < (MAX_LIMIT*MAX_LIMIT)+1):
    a = a + (6 + (8 * n))
    if (a >= (MAX_LIMIT*MAX_LIMIT)+1): break;
    n += 1
    total += a
    print a

n = 0
a = 1
while (a < (MAX_LIMIT*MAX_LIMIT)+1):
    a = a + (2 + (8 * n))
    if (a >= (MAX_LIMIT*MAX_LIMIT)+1): break;
    n += 1
    total += a
    print a

n = 0
a = 1
while (a < (MAX_LIMIT*MAX_LIMIT)+1):
    a = a + (4 + (8 * n))
    if (a >= (MAX_LIMIT*MAX_LIMIT)+1): break;
    n += 1
    total += a
    print a
    
print "total = ",total

