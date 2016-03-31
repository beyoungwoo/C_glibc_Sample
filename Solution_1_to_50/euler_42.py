#!/usr/bin/python -Wall
# -*- coding: utf-8 -*-
"""
<div id="content">
<div style="text-align:center;" class="print"><img src="images/print_page_logo.png" alt="projecteuler.net" style="border:none;" /></div>
<h2>Coded triangle numbers</h2><div id="problem_info" class="info"><h3>Problem 42</h3><span>Published on Friday, 25th April 2003, 06:00 pm; Solved by 46003; Difficulty rating: 5%</span></div>
<div class="problem_content" role="problem">
<p>The <i>n</i><sup>th</sup> term of the sequence of triangle numbers is given by, <i>t<sub>n</sub></i> = &frac12;<i>n</i>(<i>n</i>+1); so the first ten triangle numbers are:</p>
<p style="text-align:center;">1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...</p>
<p>By converting each letter in a word to a number corresponding to its alphabetical position and adding these values we form a word value. For example, the word value for SKY is 19 + 11 + 25 = 55 = <i>t</i><sub>10</sub>. If the word value is a triangle number then we shall call the word a triangle word.</p>
<p>Using <a href="project/resources/p042_words.txt">words.txt</a> (right click and 'Save Link/Target As...'), a 16K text file containing nearly two-thousand common English words, how many are triangle words?</p>
</div><br />
<br /></div>
"""
import re

tri=[ ]
for i in range (1, 50):
    res = (i*(i+1)/2)
    tri.append(res)

def is_triangle(num):
    global tri
    tri_len = len(tri)
    for i in range(0, tri_len):
        if (num == tri[i]):
            return True
        elif (num < tri[i]):
            return False

    return False

count = 0
fread = open("p42words.txt", "r")
for line in fread:
    text =  re.split("\"", line)

total_text = list(text)
len_t = len(total_text)
for i in range(0, len_t):
    if total_text[i].startswith(','):
        continue
    ret = [ord(c) for c in total_text[i]]
    len_ret = len(ret)

    if (is_triangle(sum(ret) - (64 * len_ret)) == True):
        count += 1
        print total_text[i], sum(ret) - (64 * len_ret)


print "total=", count
#a = 'hi'
#print [ord(c) for c in a]
