#!/usr/bin/python -Wall
# -*- coding: utf-8 -*-
"""
<div id="content">
<div style="text-align:center;" class="print"><img src="images/print_page_logo.png" alt="projecteuler.net" style="border:none;" /></div>
<h2>Totient maximum</h2><div id="problem_info" class="info"><h3>Problem 69</h3><span>Published on Friday, 7th May 2004, 06:00 pm; Solved by 20623; Difficulty rating: 10%</span></div>
<div class="problem_content" role="problem">
<p>Euler's Totient function, &phi;(<i>n</i>) [sometimes called the phi function], is used to determine the number of numbers less than <i>n</i> which are relatively prime to <i>n</i>. For example, as 1, 2, 4, 5, 7, and 8, are all less than nine and relatively prime to nine, &phi;(9)=6.</p>
<div style="margin-left:100px;">
<table border="1">
<tr>
<td><b><i>n</i></b></td>
<td><b>Relatively Prime</b></td>
<td><b>&phi;(<i>n</i>)</b></td>
<td><b><i>n</i>/&phi;(<i>n</i>)</b></td>
</tr>
<tr>
<td>2</td>
<td>1</td>
<td>1</td>
<td>2</td>
</tr>
<tr>
<td>3</td>
<td>1,2</td>
<td>2</td>
<td>1.5</td>
</tr>
<tr>
<td>4</td>
<td>1,3</td>
<td>2</td>
<td>2</td>
</tr>
<tr>
<td>5</td>
<td>1,2,3,4</td>
<td>4</td>
<td>1.25</td>
</tr>
<tr>
<td>6</td>
<td>1,5</td>
<td>2</td>
<td>3</td>
</tr>
<tr>
<td>7</td>
<td>1,2,3,4,5,6</td>
<td>6</td>
<td>1.1666...</td>
</tr>
<tr>
<td>8</td>
<td>1,3,5,7</td>
<td>4</td>
<td>2</td>
</tr>
<tr>
<td>9</td>
<td>1,2,4,5,7,8</td>
<td>6</td>
<td>1.5</td>
</tr>
<tr>
<td>10</td>
<td>1,3,7,9</td>
<td>4</td>
<td>2.5</td>
</tr>
</table>
</div>
<p>It can be seen that <i>n</i>=6 produces a maximum <i>n</i>/&phi;(<i>n</i>) for <i>n</i> &le; 10.</p>
<p>Find the value of <i>n</i> &le; 1,000,000 for which <i>n</i>/&phi;(<i>n</i>) is a maximum.</p>
</div><br />
<br /></div>
"""

from Euler import gcd
from Euler import is_prime

#best answer
# 2*3*5*7*11*13 = 510510


#MAXNUM = 11
MAXNUM = 1000001
def E69():
    res = 0
    max_res = 0
    max_i = 0
    for i in range (2, MAXNUM):
        if i % 2 == 1:
            continue;
        if is_prime(i) == True:
            continue
        cnt = 1
        for j in range (1, i):
            if gcd(i, j) == 1:
                cnt+=1
        if cnt != 0:
            res = float(i)/float(cnt)
            if max_res < res:
                max_res = res
                max_i = i

    print max_res, max_i
    return 0

E69()

