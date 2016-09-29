#!/usr/bin/python -Wall
# -*- coding: utf-8 -*-
"""
<div id="content">
<div style="text-align:center;" class="print"><img src="images/print_page_logo.png" alt="projecteuler.net" style="border:none;" /></div>
<h2>Integer right triangles</h2><div id="problem_info" class="info"><h3>Problem 39</h3><span>Published on Friday, 14th March 2003, 06:00 pm; Solved by 43573; Difficulty rating: 5%</span></div>
<div class="problem_content" role="problem">
<p>If <i>p</i> is the perimeter of a right angle triangle with integral length sides, {<i>a</i>,<i>b</i>,<i>c</i>}, there are exactly three solutions for <i>p</i> = 120.</p>
<p style="">{20,48,52}, {24,45,51}, {30,40,50}</p>
<p>For which value of <i>p</i> &le; 1000, is the number of solutions maximised?</p>
</div><br />
<br /></div>
"""

total_cnt = 0
max_cnt = 0
max_num = 0

def GetMaxMised(num):
    global total_cnt 
    global max_cnt
    global max_num
    total_cnt = 0
    for i in range(1, num/2):

        for j in range(i+1, num/2):
            k = num - i - j
            a1 = (i*i) + (j*j)
            a2 = k*k
            if (a1 == a2):
                total_cnt += 1
#                print "[",num,"]", i, j, k, total_cnt
        
    if (max_cnt < total_cnt):
        max_cnt = total_cnt
        max_num = num
        print max_num, max_cnt

    return 0


for idx in range(1, 1001):
    GetMaxMised(idx)


print "result=", max_num, max_cnt

'''
L, t_max, p_max = 1000, 0, 0  #L must be an even integer

for p in range(L//4*2, L+1, 2):
    t = 0
    for a in range(2, int(p/3.4142) + 1):
        if  p*(p - 2*a) % (2*(p - a)) == 0: 
            t += 1
            if t >= t_max: 
                t_max, p_max = t, p 
 
print "Maximum perimeter, p <=",L,"is", p_max
print "Triangles in set =", t_max
'''
