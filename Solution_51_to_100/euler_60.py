#!/usr/bin/python -Wall
# -*- coding: utf-8 -*-
"""
<div id="content">
<div style="text-align:center;" class="print"><img src="images/print_page_logo.png" alt="projecteuler.net" style="border:none;" /></div>
<h2>Prime pair sets</h2><div id="problem_info" class="info"><h3>Problem 60</h3><span>Published on Friday, 2nd January 2004, 06:00 pm; Solved by 14965; Difficulty rating: 20%</span></div>
<div class="problem_content" role="problem">
<p>The primes 3, 7, 109, and 673, are quite remarkable. By taking any two primes and concatenating them in any order the result will always be prime. For example, taking 7 and 109, both 7109 and 1097 are prime. The sum of these four primes, 792, represents the lowest sum for a set of four primes with this property.</p>
<p>Find the lowest sum for a set of five primes for which any two primes concatenate to produce another prime.</p>
</div><br />
<br /></div>
"""

from math import sqrt

def is_prime(num):

    n = int(num)   # type casting

    if n == 2 or n == 3: return True
    if n < 2 or n%2 == 0: return False
    if n < 9: return True
    if n%3 == 0: return False
    r = int(sqrt(n))
    f = 5
    while f <= r:
        if n%f == 0: return False
        if n%(f+2) == 0: return False
        f +=6
    return True

MAXLIMIT=10000
def E60():
    a = 3
    retstr = '0'

    while True:
        if a > MAXLIMIT:
            #print 'max overlow.... terminate'
            return

        if is_prime(a) == False:
            a+=2
            continue

        b = a+2
        while True:
            if b > MAXLIMIT:
                a+=2
                break

            if is_prime(b) == False:
                b+=2
                continue

            retstr = str(a) + str(b)
            if is_prime(retstr) == False:
                #print 'not prime[B]', a, b, retstr
                b+=2
                continue
            retstr = str(b) + str(a)
            if is_prime(retstr) == False:
                #print 'not prime[B]', a, b, retstr
                b+=2
                continue

            c = b+2
            while True:
                if c > MAXLIMIT:
                    b+=2
                    break

                if is_prime(c) == False:
                    c+=2
                    continue
                retstr = str(a) + str(c)
                if is_prime(retstr) == False:
                    #print 'not prime[C]', a, b, c, retstr
                    c+=2
                    continue
                retstr = str(c) + str(a)
                if is_prime(retstr) == False:
                    #print 'not prime[C]', a, b, c, retstr
                    c+=2
                    continue
                retstr = str(b) + str(c)
                if is_prime(retstr) == False:
                    #print 'not prime[C]', a, b, c, retstr
                    c+=2
                    continue
                retstr = str(c) + str(b)
                if is_prime(retstr) == False:
                    #print 'not prime[C]', a, b, c, retstr
                    c+=2
                    continue

                d = c+2
                while True:
                    if d > MAXLIMIT:
                        c+=2
                        break

                    if is_prime(d) == False:
                        d+=2
                        continue

                    retstr = str(a) + str(d)
                    if is_prime(retstr) == False:
                        #print 'not prime[D]', a, b, c, d, retstr
                        d+=2
                        continue
                    retstr = str(d) + str(a)
                    if is_prime(retstr) == False:
                        #print 'not prime[D]', a, b, c, d, retstr
                        d+=2
                        continue
                    retstr = str(b) + str(d)
                    if is_prime(retstr) == False:
                        #print 'not prime[D]', a, b, c, d, retstr
                        d+=2
                        continue
                    retstr = str(d) + str(b)
                    if is_prime(retstr) == False:
                        #print 'not prime[D]', a, b, c, d, retstr
                        d+=2
                        continue
                    retstr = str(c) + str(d)
                    if is_prime(retstr) == False:
                        #print 'not prime[D]', a, b, c, d, retstr
                        d+=2
                        continue
                    retstr = str(d) + str(c)
                    if is_prime(retstr) == False:
                        #print 'not prime[D]', a, b, c, d, retstr
                        d+=2
                        continue


                    e = d+2
                    while True:
                        if e > MAXLIMIT:
                            d+=2
                            break

                        if is_prime(e) == False:
                            e+=2
                            continue

                        retstr = str(a) + str(e)
                        if is_prime(retstr) == False:
                            #print 'not prime[E]', a, b, c, d, e, retstr
                            e+=2
                            continue
                        retstr = str(e) + str(a)
                        if is_prime(retstr) == False:
                            #print 'not prime[E]', a, b, c, d, e, retstr
                            e+=2
                            continue
                        retstr = str(b) + str(e)
                        if is_prime(retstr) == False:
                            #print 'not prime[E]', a, b, c, d, e, retstr
                            e+=2
                            continue
                        retstr = str(e) + str(b)
                        if is_prime(retstr) == False:
                            #print 'not prime[E]', a, b, c, d, e, retstr
                            e+=2
                            continue
                        retstr = str(c) + str(e)
                        if is_prime(retstr) == False:
                            #print 'not prime[E]', a, b, c, d, e, retstr
                            e+=2
                            continue
                        retstr = str(e) + str(c)
                        if is_prime(retstr) == False:
                            #print 'not prime[E]', a, b, c, d, e, retstr
                            e+=2
                            continue
                        retstr = str(d) + str(e)
                        if is_prime(retstr) == False:
                            #print 'not prime[E]', a, b, c, d, e, retstr
                            e+=2
                            continue
                        retstr = str(e) + str(d)
                        if is_prime(retstr) == False:
                            #print 'not prime[E]', a, b, c, d, e, retstr
                            e+=2
                            continue

                        print 'found!!!!!', a, b, c, d, e, 'result =', a+b+c+d+e
                        return

E60()
