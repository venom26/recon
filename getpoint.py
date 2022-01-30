# -----------------------------
# by m4ll0k (@m4ll0k) 
# github.com/m4ll0k
# ------------------------------
# e.g:
# echo -e "test.example.com\ntest-dev.example.com\nstaging-test.example.com" > targets.txt && python3 getpoint.py targets.txt %FUZZ%
# output:
'''
%FUZZ%.test.example.com
%FUZZ%.test-dev.example.com
%FUZZ%-dev.example.com
test-%FUZZ%.example.com
%FUZZ%.staging-test.example.com
%FUZZ%-test.example.com
staging-%FUZZ%.example.com
'''
# now use any tools for replace %FUZZ% with your wordlist for example this simple bash file 

''' 
# ./replace.sh %FUZZ%.test.example.com wordlist.txt
for i in $(cat $2)
do
	sr=$1
	echo "${sr//%FUZZ%/$i}"  >> all.txt
done
'''
# now use any tool like massdns..etc 
import os,sys,re

if len(sys.argv) <= 2 or len(sys.argv) > 3:
    print('Usage:')
    print('\tpython <list of domains> <inject_string>')
    print('e.g:')
    print('\tpython targets.txt "%FUZZ%"')
    sys.exit(0)

injected = []
_injected = []

def read_wordlist():
    try:
        return [
        x.strip() for x in open(sys.argv[1],'r+')
    ]
    except Exception as e:
        sys.exit(print(e))

def main():
    '''
    get potential injection point in a wordlist file  
    '''
    for domain in read_wordlist():
        if domain.startswith('.'):
            kk = "%s"%(sys.argv[2])+domain 
            if kk not in injected:
                injected.append(kk)
        if not domain.startswith('.'):
            kk = "%s."%(sys.argv[2])+domain
            if kk not in injected:
                injected.append(kk)
        root = ".".join(domain.split('.')[-2:])
        domain = domain.split('.'+str(root))[0]
        # --
        if '-' in domain:
            dd = domain.split('-')
            for sp in domain.split('-'):
                d =  "-".join(dd).replace(sp,sys.argv[2])
                d = d+'.'+root
                if d not in injected:
                    injected.append(d)
        # --
        if '_' in domain:
            dd = domain.split('_')
            for sp in domain.split('_'):
                d = '_'.join(dd).replace(sp,sys.argv[2])
                d = d + '.' + root 
                if d not in injected:
                    injected.append(d)
        # --            
        if len(domain.split('.')) > 2:
            for i in domain.split('.'):
                if i == '': 
                    d = '%s%s'%(sys.argv[2],domain)
                else:
                    d = domain.replace(i,sys.argv[2])
                d = d + '.' + root 
                if d not in injected:
                    injected.append(d) 
        # --
        if root == domain:
            if '%s.%s'%(sys.argv[2],root) not in injected:
                injected.append('%s.%s'%(sys.argv[2],root))
    for d in injected:
        if d.startswith('.'):
            d = d[1:]
            if d not in _injected:
                _injected.append(d)
                print(d)
        elif d not in _injected:
            _injected.append(d)
            print(d)
if __name__ == "__main__":
    main()
