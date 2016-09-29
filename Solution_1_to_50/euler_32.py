#!/usr/bin/python -Wall
# -*- coding: utf-8 -*-
"""
<div id="content">
<div style="text-align:center;" class="print"><img src="images/print_page_logo.png" alt="projecteuler.net" style="border:none;" /></div>
<h2>Pandigital products</h2><div id="problem_info" class="info"><h3>Problem 32</h3><span>Published on Friday, 6th December 2002, 06:00 pm; Solved by 42017; Difficulty rating: 5%</span></div>
<div class="problem_content" role="problem">
<p>We shall say that an <var>n</var>-digit number is pandigital if it makes use of all the digits 1 to <var>n</var> exactly once; for example, the 5-digit number, 15234, is 1 through 5 pandigital.</p>
<p>The product 7254 is unusual, as the identity, 39 &times; 186 = 7254, containing multiplicand, multiplier, and product is 1 through 9 pandigital.</p>
<p>Find the sum of all products whose multiplicand/multiplier/product identity can be written as a 1 through 9 pandigital.</p>
<div class="note">HINT: Some products can be obtained in more than one way so be sure to only include it once in your sum.</div>
</div><br />
<br /></div>
"""
'''
buf = [0] * 10
buf[0] = 1
buf[1] = 0
buf[2] = 1
buf[3] = 1
buf[4] = 1
buf[5] = 0
buf[6] = 1
buf[7] = 1
buf[8] = 0
buf[9] = 0

mask = 1111111111
comp = "%d%d%d%d%d%d%d%d%d%d" % (buf[0], buf[1], buf[2], buf[3], buf[4], buf[5], buf[6], buf[7], buf[8], buf[9])

a = (int(comp) ^ mask)
if (a == 0):
    print "matched, ", a
else :
    print "not matched", a

'''


'''
num = 1234
a = num/1000
b = num%1000/100
c = num%100/10
d = num%10
print a,b,c,d

num = 12345
a = num/10000
b = num%10000/1000
c = num%1000/100
d = num%100/10
e = num%10
print a,b,c,d,e
'''

#list duplicate check

def list_duplicates(seq):
  seen = set()
  seen_add = seen.add
  # adds all elements it doesn't know yet to seen and all other to seen_twice
  seen_twice = set( x for x in seq if x in seen or seen_add(x) )
  # turn the set into a list (as requested)
  return list( seen_twice )


sum_list = [ ]

mask = 111111111


buf = [0] * 10
for i in range(1, 10):
    for j in range(1000, 10000):
        
        k = i * j
        if (k < 1000 or k >= 10000):
            continue

        for idx in range(0, 10):
            buf[idx] = 0

        buf[i] = 1

        if (buf[j/1000] == 1 or j/1000 == 0):
            continue
        else :
            buf[j/1000] = 1

        if (buf[j%1000/100] == 1 or j%1000/100 == 0):
           continue 
        else :
            buf[j%1000/100] = 1

        if (buf[j%100/10] == 1 or j%100/10 == 0):
            continue
        else :
            buf[j%100/10] = 1

        if (buf[j%10] == 1 or j%10 == 0):
            continue
        else :
            buf[j%10] = 1


        if (buf[k/1000] == 1 or k/1000 == 0):
            continue
        else :
            buf[k/1000] = 1

        if (buf[k%1000/100] == 1 or k%1000/100 == 0):
           continue 
        else :
            buf[k%1000/100] = 1

        if (buf[k%100/10] == 1 or k%100/10 == 0):
            continue
        else :
            buf[k%100/10] = 1

        if (buf[k%10] == 1 or k%10 == 0):
            continue
        else :
            buf[k%10] = 1


        comp = "%d%d%d%d%d%d%d%d%d" % (buf[1], buf[2], buf[3], buf[4], buf[5], buf[6], buf[7], buf[8], buf[9])

#        print comp, i, j, k
#        print "mask= ",mask
        a = (int(comp) & mask)
        if (a != 0):
            #print "matched, ", i, "*", j , "=", k
            sum_list.append(k)

for i in range(10, 100):
    for j in range(100, 1000):
        
        k = i * j
        if (k < 1000 or k >= 10000):
            continue

        for idx in range(0, 10):
            buf[idx] = 0

        if (i/10 == 0):
            continue
        buf[i/10] = 1

        if (buf[i%10] == 1 or i%10 == 0):
            continue
        else :
            buf[i%10] = 1

        if (buf[j/100] == 1 or j/100 == 0):
            continue
        else :
            buf[j/100] = 1

        if (buf[j%100/10] == 1 or j%100/10 == 0):
           continue 
        else :
            buf[j%100/10] = 1

        if (buf[j%10] == 1 or j%10 == 0):
            continue
        else :
            buf[j%10] = 1

        if (buf[k/1000] == 1 or k/1000 == 0):
            continue
        else :
            buf[k/1000] = 1

        if (buf[k%1000/100] == 1 or k%1000/100 == 0):
           continue 
        else :
            buf[k%1000/100] = 1

        if (buf[k%100/10] == 1 or k%100/10 == 0):
            continue
        else :
            buf[k%100/10] = 1

        if (buf[k%10] == 1 or k%10 == 0):
            continue
        else :
            buf[k%10] = 1


        comp = "%d%d%d%d%d%d%d%d%d" % (buf[1], buf[2], buf[3], buf[4], buf[5], buf[6], buf[7], buf[8], buf[9])

        a = (int(comp) & mask)
        if (a != 0):
            #print "matched, ", i, "*", j , "=", k
            sum_list.append(k)


print sum_list
# total 
total = sum(sum_list)

# duplicated 
duplicated = list_duplicates(sum_list)
dup = sum(duplicated)


# result
print total - dup


