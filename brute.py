import sys
scope = sys.argv[1]
wordlist = open('/home/ubuntu/tools/subdomains.txt').read().split('\n')

for word in wordlist:
    if not word.strip():
        continue
    print('{}.{}\n'.format(word.strip(), scope))
