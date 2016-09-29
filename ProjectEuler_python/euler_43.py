#!/usr/bin/python -Wall
# -*- coding: utf-8 -*-
"""
<div id="content">
<div style="text-align:center;" class="print"><img src="images/print_page_logo.png" alt="projecteuler.net" style="border:none;" /></div>
<h2>Sub-string divisibility</h2><div id="problem_info" class="info"><h3>Problem 43</h3><span>Published on Friday, 9th May 2003, 06:00 pm; Solved by 34986; Difficulty rating: 5%</span></div>
<div class="problem_content" role="problem">
<p>The number, 1406357289, is a 0 to 9 pandigital number because it is made up of each of the digits 0 to 9 in some order, but it also has a rather interesting sub-string divisibility property.</p>
<p>Let <i>d</i><sub>1</sub> be the 1<sup>st</sup> digit, <i>d</i><sub>2</sub> be the 2<sup>nd</sup> digit, and so on. In this way, we note the following:</p>
<ul>
<li><i>d</i><sub>2</sub><i>d</i><sub>3</sub><i>d</i><sub>4</sub>=406 is divisible by 2</li>
<li><i>d</i><sub>3</sub><i>d</i><sub>4</sub><i>d</i><sub>5</sub>=063 is divisible by 3</li>
<li><i>d</i><sub>4</sub><i>d</i><sub>5</sub><i>d</i><sub>6</sub>=635 is divisible by 5</li>
<li><i>d</i><sub>5</sub><i>d</i><sub>6</sub><i>d</i><sub>7</sub>=357 is divisible by 7</li>
<li><i>d</i><sub>6</sub><i>d</i><sub>7</sub><i>d</i><sub>8</sub>=572 is divisible by 11</li>
<li><i>d</i><sub>7</sub><i>d</i><sub>8</sub><i>d</i><sub>9</sub>=728 is divisible by 13</li>
<li><i>d</i><sub>8</sub><i>d</i><sub>9</sub><i>d</i><sub>10</sub>=289 is divisible by 17</li>
</ul>
<p>Find the sum of all 0 to 9 pandigital numbers with this property.</p>
</div><br />
<br /></div>
"""
total = 0

def E43(num):
    global total
    buf = str(num)
    
    a1 = "%s%s%s" % (buf[1],buf[2],buf[3])
    if (int(a1) % 2 == 0) :
        a2 = "%s%s%s" % (buf[2],buf[3],buf[4])
        if (int(a2) % 3 == 0) :
            a3 = "%s%s%s" % (buf[3],buf[4],buf[5])
            if (int(a3) % 5 == 0) :
                a4 = "%s%s%s" % (buf[4],buf[5],buf[6])
                if (int(a4) % 7 == 0) :
                    a5 = "%s%s%s" % (buf[5],buf[6],buf[7])
                    if (int(a5) % 11 == 0) :
                        a6 = "%s%s%s" % (buf[6],buf[7],buf[8])
                        if (int(a6) % 13 == 0) :
                            a7 = "%s%s%s" % (buf[7],buf[8],buf[9])
                            if (int(a7) % 17 == 0) :
                                print "num=",num, "->",a1,a2,a3,a4,a5,a6,a7
                                total += num


for a1 in range(1, 10):
    BUF = [0,0,0,0,0,0,0,0,0,0]
    BUF[a1] = 1
    for a2 in range(0, 10):
        if (BUF[a2] == 1):
            continue
        BUF[a2] = 1
        for a3 in range(0, 10):
            if (BUF[a3] == 1):
                continue
            BUF[a3] = 1
            for a4 in range(0, 10):
                if (BUF[a4] == 1):
                    continue
                BUF[a4] = 1
                for a5 in range(0, 10):
                    if (BUF[a5] == 1):
                        continue
                    BUF[a5] = 1
                    for a6 in range(0, 10):
                        if (BUF[a6] == 1):
                            continue
                        BUF[a6] = 1
                        for a7 in range(0, 10):
                            if (BUF[a7] == 1):
                                continue
                            BUF[a7] = 1
                            for a8 in range(0, 10):
                                if (BUF[a8] == 1):
                                    continue
                                BUF[a8] = 1
                                for a9 in range(0, 10):
                                    if (BUF[a9] == 1):
                                        continue
                                    BUF[a9] = 1
                                    for a10 in range(0, 10):
                                        if (BUF[a10] == 1):
                                            continue
 
                                        buf = "%d%d%d%d%d%d%d%d%d%d" % (a1,a2,a3,a4,a5,a6,a7,a8,a9,a10)
                                        E43(int(buf))
                                        BUF[a10] = 0
                                    BUF[a9] = 0
                                BUF[a8] = 0
                            BUF[a7] = 0
                        BUF[a6] = 0
                    BUF[a5] = 0
                BUF[a4] = 0
            BUF[a3] = 0
        BUF[a2] = 0


print "total = ", total
