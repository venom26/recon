#!/bin/python3
import sys
scope = sys.argv[1]
print(scope)
wordlist = open('/root/tools/commonspeak2-wordlists/subdomains/subdomains.txt').read().split('\n')

for word in wordlist:
    if not word.strip():
        continue
    print('{}.{}\n'.format(word.strip(), scope))
