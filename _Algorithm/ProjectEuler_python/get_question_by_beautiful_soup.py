#!/usr/bin/python -Wall
# -*- coding: utf-8 -*-

import sys
import re
import httplib
import urllib2
from urlparse import urlparse
import BeautifulSoup

def crawler(SeedUrl, file_name):

    fwrite = open(file_name,'w')
    tocrawl=[SeedUrl]
    crawled=[]
    while tocrawl:
        page=tocrawl.pop()
        pagesource=urllib2.urlopen(page)
        read_page=pagesource.read()
        soup=BeautifulSoup.BeautifulSoup(read_page)

        fwrite.write('#!/usr/bin/python -Wall\n')
        fwrite.write('# -*- coding: utf-8 -*-\n')
        fwrite.write('"""\n')
        fwrite.write('%s' % soup.find(id="content"))
        fwrite.write('\n"""')
#        print soup.body
#        print soup.h3
#        print soup.h3.firstText

    fwrite.close()
    return crawled  


def get_euler():
    # get 500 questions
    for i in range(1,500):
        s = "https://projecteuler.net/problem=%d" % (i)
        wfile_name = "./euler/euler_%d.py" % (i)
        crawler(s, wfile_name)

    return 0


get_euler()
 
