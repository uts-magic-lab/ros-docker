#!/usr/bin/env python

import os
import requests
from lxml import html

page = requests.get("http://blackhole.themagiclab.org:40080/simple/")
tree = html.fromstring(page.content)

links = tree.xpath('//a')
for a in links:
    print(a.text)
