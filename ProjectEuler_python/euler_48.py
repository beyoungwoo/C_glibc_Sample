#!/usr/bin/python -Wall
# -*- coding: utf-8 -*-
"""
<div id="content">
<div style="text-align:center;" class="print"><img src="images/print_page_logo.png" alt="projecteuler.net" style="border:none;" /></div>
<h2>Self powers</h2><div id="problem_info" class="info"><h3>Problem 48</h3><span>Published on Friday, 18th July 2003, 06:00 pm; Solved by 71708; Difficulty rating: 5%</span></div>
<div class="problem_content" role="problem">
<p>The series, 1<sup>1</sup> + 2<sup>2</sup> + 3<sup>3</sup> + ... + 10<sup>10</sup> = 10405071317.</p>
<p>Find the last ten digits of the series, 1<sup>1</sup> + 2<sup>2</sup> + 3<sup>3</sup> + ... + 1000<sup>1000</sup>.</p>
</div><br />
<br /></div>
"""

d = sum(pow(i, i, 10**10) for i in range(1, 1001))
print d % (10 ** 10)

total_len = 0
def E48(num):
    if num % 10 == 0:
        return 0

    global total_len
    ret = pow(num, num)

    buf = str(ret)
    len_b = len(buf)
    if (len_b <= 11):
        total_len += ret
#        print "[",num,"]",ret
    else :
        total_len += int(buf[len_b-11:len_b])
#        print "[",num,"]",int(buf[len_b-11:len_b]), total_len

    return 0


for i in range(1, 1001):
    E48(i)

print "result=", total_len % 10**10
print "result=", total_len % pow(10, 10)

