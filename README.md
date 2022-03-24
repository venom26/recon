**#Random Recon Tricks**

**Extracting links, paths from source of a website**
```
Use Xidel
https://github.com/benibela/xidel
Usage:-
./xidel http://apple.com -f '//script/@src'
./xidel http://apple.com -f '//link/@href'
./xidel http://apple.com -f '//a/@href'
```
