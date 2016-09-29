#!/usr/bin/python -Wall
# -*- coding: utf-8 -*-
"""
<div id="content">
<div style="text-align:center;" class="print"><img src="images/print_page_logo.png" alt="projecteuler.net" style="border:none;" /></div>
<h2>Counting Sundays</h2><div id="problem_info" class="info"><h3>Problem 19</h3><span>Published on Friday, 14th June 2002, 06:00 pm; Solved by 79523; Difficulty rating: 5%</span></div>
<div class="problem_content" role="problem">
<p>You are given the following information, but you may prefer to do some research for yourself.</p>
<ul>
<li>1 Jan 1900 was a Monday.</li>
<li>Thirty days has September,<br />
April, June and November.<br />
All the rest have thirty-one,<br />
Saving February alone,<br />
Which has twenty-eight, rain or shine.<br />
And on leap years, twenty-nine.</li>
<li>A leap year occurs on any year evenly divisible by 4, but not on a century unless it is divisible by 400.</li>
</ul>
<p>How many Sundays fell on the first of the month during the twentieth century (1 Jan 1901 to 31 Dec 2000)?</p>
</div><br />
<br /></div>
"""

sunday = 0

startday = 1
#for year in range(1900, 1902):
for year in range(1900, 2001):
    for i in range(1, 13): # month 1~12
        if (startday % 7 == 0):            
            if (year != 1900):
                sunday += 1
                print "year : ", year, "month:", i, "start", startday

        if (i == 4 or i == 6 or i == 9 or i == 11):
            startday += 2 # 30 % 7 
            if (startday > 7):
                startday = startday - 7
        elif (i == 2):
            if (year % 4 == 0 and year % 100 != 0 and year % 400 == 0) :
                startday += 1 # 29 % 7 
                if (startday > 7):
                    startday = startday - 7
        else:
            startday += 3 # 31 % 7 
            if (startday > 7):
                startday = startday - 7

print sunday

