#!/usr/bin/python -Wall
# -*- coding: utf-8 -*-
"""
<div id="content">
<div style="text-align:center;" class="print"><img src="images/print_page_logo.png" alt="projecteuler.net" style="border:none;" /></div>
<h2>Number letter counts</h2><div id="problem_info" class="info"><h3>Problem 17</h3><span>Published on Friday, 17th May 2002, 06:00 pm; Solved by 88413; Difficulty rating: 5%</span></div>
<div class="problem_content" role="problem">
<p>If the numbers 1 to 5 are written out in words: one, two, three, four, five, then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.</p>
<p>If all the numbers from 1 to 1000 (one thousand) inclusive were written out in words, how many letters would be used? </p>
<br />
<p class="note"><b>NOTE:</b> Do not count spaces or hyphens. For example, 342 (three hundred and forty-two) contains 23 letters and 115 (one hundred and fifteen) contains 20 letters. The use of "and" when writing out numbers is in compliance with British usage.</p>
</div><br />
<br /></div>
"""
s={0:"",1:"one",2:"two",3:"three",4:"four",5:"five",6:"six",7:"seven",8:"eight",9:"nine",10:"ten",11:"eleven",12:"twelve",13:"thirteen",14:"fourteen",15:"fifteen",16:"sixteen",17:"seventeen",18:"eighteen",19:"nineteen",20:"twenty",30:"thirty",40:"forty",50:"fifty",60:"sixty",70:"seventy",80:"eighty",90:"ninety"}

for i in range(1,1000):
    if(not i in s.keys()):
        if(i<100):
            s[i]=s[i/10*10]+s[i%10]

        else:
            s[i]=s[i/100]+"hundred"
            if(i%100):
                s[i]+="and"+s[i%100]

s[1000]="onethousand"
total=0;
for i in s.values():
    total+=len(i)

print total
