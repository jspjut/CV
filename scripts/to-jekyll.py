#!/usr/bin/python

import sys

try:
    ready = False
    # print header
    print '''+++
title = "Josef B. Spjut"
+++
'''
# '''---
# layout: page
# title: Josef B. Spjut
# tagline: 
# group: 
# ---
# {% include JB/setup %}
# '''
    for line in open(sys.argv[1]):
        # only keep html inside the body for jekyll to do the rest
        if line[:7] == "</body>":
            ready = False
        if ready: sys.stdout.write(line)
        if line.startswith('<h1 id="josef-b.-spjut">'):
            ready = True
except:
    sys.stderr.write("error opening file %s\n"%sys.argv[1])
