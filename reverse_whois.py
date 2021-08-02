import re, sys, requests
for i in re.findall(r'<tr><td>([^<]+)</td>',requests.get("https://viewdns.info/reversewhois/?q="+'+'.join(sys.argv[1:]),headers={'User-Agent':"Mozilla/5.0 Windows NT 10.0 Win64 AppleWebKit/537.36 Chrome/69.0.3497.100"}).text)[1:]:
  print(i)
