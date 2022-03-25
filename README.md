**Bug Hunting Tricks**

**Extracting links, paths from source of a website**
```
Use Xidel
https://github.com/benibela/xidel
Usage:-
xidel http://apple.com -f '//script/@src'
xidel http://apple.com -f '//link/@href'
xidel http://apple.com -f '//a/@href'

References:-
https://www.videlibri.de/xidel.html
```

**Bypasses For LFI, Auth Bypass**
```
..;/ 
or
/foo;x=x/bar/
tricks work well when you have a ngnix server in front of an tomcat

References:- https://i.blackhat.com/us-18/Wed-August-8/us-18-Orange-Tsai-Breaking-Parser-Logic-Take-Your-Path-Normalization-Off-And-Pop-0days-Out-2.pdf
```
