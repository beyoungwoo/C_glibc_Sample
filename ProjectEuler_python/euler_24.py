#!/usr/bin/python -Wall
# -*- coding: utf-8 -*-
"""
<div id="content">
<div style="text-align:center;" class="print"><img src="images/print_page_logo.png" alt="projecteuler.net" style="border:none;" /></div>
<h2>Lexicographic permutations</h2><div id="problem_info" class="info"><h3>Problem 24</h3><span>Published on Friday, 16th August 2002, 06:00 pm; Solved by 68438; Difficulty rating: 5%</span></div>
<div class="problem_content" role="problem">
<p>A permutation is an ordered arrangement of objects. For example, 3124 is one possible permutation of the digits 1, 2, 3 and 4. If all of the permutations are listed numerically or alphabetically, we call it lexicographic order. The lexicographic permutations of 0, 1 and 2 are:</p>
<p style="text-align:center;">012&nbsp; &nbsp;021&nbsp; &nbsp;102&nbsp; &nbsp;120&nbsp; &nbsp;201&nbsp; &nbsp;210</p>
<p>What is the millionth lexicographic permutation of the digits 0, 1, 2, 3, 4, 5, 6, 7, 8 and 9?</p>
</div><br />
<br /></div>
"""

lexi=[ ]
for i1 in range(0, 10):
    for i2 in range(0, 10):
        if (i2 == i1):
            continue

        for i3 in range(0, 10):
            if (i3 == i1 or i3 == i2):
                continue
            
            for i4 in range(0, 10):
                if (i4 == i1 or i4 == i2 or i4 == i3):
                    continue
            
                for i5 in range(0, 10):
                    if (i5 == i1 or i5 == i2 or i5 == i3 or i5 == i4):
                        continue
            
                    for i6 in range(0, 10):
                        if (i6 == i1 or i6 == i2 or i6 == i3 or i6 == i4 or i6 == i5):
                            continue

                        for i7 in range(0, 10):
                            if (i7 == i1 or i7 == i2 or i7 == i3 or i7 == i4 or i7 == i5 or i7 == i6):
                                continue

                            for i8 in range(0, 10):
                                if (i8 == i1 or i8 == i2 or i8 == i3 or i8 == i4 or i8 == i5 or i8 == i6 or i8 == i7):
                                    continue

                                for i9 in range(0, 10):
                                    if (i9 == i1 or i9 == i2 or i9 == i3 or i9 == i4 or i9 == i5 or i9 == i6 or i9 == i7 or i9 == i8):
                                        continue

                                    buf = "%s%s%s%s%s%s%s%s%s" % (i1, i2, i3, i4, i5, i6, i7, i8, i9)
                                    lexi.append(buf)


lexi.sort()
print lexi[999999]
