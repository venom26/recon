#!/usr/bin/env python3
import socket
import sys
hostname = sys.argv[1]
ip = socket.gethostbyname(hostname)
print('Hostname: ', hostname, '\n' 'IP: ', ip)

#usage:-
#cat hosts | xargs -n1 -P10 -I{} python3 getip.py {}
