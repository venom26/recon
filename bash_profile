fd(){
findomain -t $1
}

paramfinder(){
x8 -u $1 -w ~/tools/dirsearch/db/params.txt -c 10
}

thewadl(){
curl -s $i | grep -e 'resource path' -e 'method id' | cut -d '=' -f2 | cut -d '"' -f2 | sort -u
}

crtsh(){
curl -s https://crt.sh/\?q\=%25.$1\&output\=json | jq . | egrep -e 'common_name' -e 'name_value' | awk '{print $2}'| sed -e 's/"//g'| sed -e 's/,//g' |  awk '{gsub(/\\n/,"\n")}1' | sed 's/\*\.//g' | sort -u
}

fdir(){
feroxbuster -u $1 --scan-limit 3 -w ~/tools/dirsearch/db/dicc.txt -x htm,html,xml,js,json,zip,asp,aspx,php,bak,sql,old,txt,gz,gz.tar --random-agent --extract-links  -r -k -t 200
}


fapi(){
feroxbuster -u $1 --scan-limit 3 -w ~/tools/dirsearch/db/apiwords.txt --random-agent --extract-links  -r -k -t 200
}


fraf(){
feroxbuster -u $1 --scan-limit 3 -w ~/tools/dirsearch/db/raft-large-directories.txt --random-agent -x htm,html,xml,js,json,zip,asp,aspx,php,bak,sql,old,txt,gz,gz.tar --extract-links  -r -k -t 200
}

fuf(){
ffuf -u $1/FUZZ -w ~/tools/dirsearch/db/dicc.txt -mc 200,301,302 -t 200 -D -e js,php,bak,txt,html,zip,sql,old,gz,log,swp,yaml,yml,config,save,rsa,ppk -ac
}

fufapi(){
ffuf -u $1/FUZZ -w ~/tools/dirsearch/db/apiwords.txt -mc 200 -t 200 -D -e js,php,bak,txt,html,zip,sql,old,gz,log,swp,yaml,yml,config,save,rsa,ppk -ac
}

nucleiop(){
cat * | grep -v 'Labda' | grep -v 'CVE-2017-7529' |  grep -v 'basic-cors-misconfig' | grep -v 'Kingdee-file-list' | grep -v 'host-header-poisoning'  | grep -v '\[info]' | grep -v 'general-tokens' | grep -v 'missing-x-frame-options' |  grep -v 'Express-LFR-json' | grep -v 'ruijie-EWEB-rce' | grep -v 'seaCMS-sqli' | grep -v 'Application-dos' | grep -v 'Labda_403Bypass_slash' | grep -v 'ssl-dns-names' |  grep -v 'CVE-2018-15473' |  grep -v 'dns-waf-detect:cloudflare' | grep -v 'basic-cors-misconfig-flash' | grep -v 'openssh-username-enumeration' | grep -v 'CVE-2019-19985' | grep -v 'CVE-2019-7192' | grep -v 'jira-unauthenticated-user-picker' | grep -v Express-LFR-GET | grep -v dnssec-detection | grep -v json-endpoints | grep -v graphite | grep -iv cellpower | grep -v IOC | grep -v 'Clickhouse DB' | grep -v twig | grep -v header-reflection | grep -v header-sqli | grep -v 'graphite-browser-default-credential' | grep -v 'tech-detect' | grep -v 'nginx-version' | grep -v 'http-missing-security-headers' | grep -v 'exposed-pii' | grep -v 'apple-app-site-association' | grep -v 'developer-notes' | grep -v 'addeventlistener-detect' | grep -v 'generic-tokens' | grep -v 'base-64-strings' | grep -v 'possibility-of-webshell' | grep -vi 'cve-2020-36287' 
}

mscan(){
sudo /home/ubuntu/tools/masscan/bin/masscan -p80,443,8020,50070,50470,19890,19888,8088,8090,2075,2076,6443,3868,3366,8443,8080,9443,9091,3000,8000,5900,8081,6000,10000,8181,3306,5000,10250,4000,8888,5432,15672,9999,161,4044,7077,4040,9000,8089,7447,7080,8880,8983,5673,7443,19000,19080,2375,8069,5984,6379,11211 --rate=100000 --open -iL $1 --banners -oG famous_ports.txt
}

mscanall(){
sudo /home/ubuntu/tools/masscan/bin/masscan -p0-65535 --rate=100000 --open -iL $1 --banners -oG all_ports.txt
}

dirapi(){
cd ~/tools/dirsearch
sudo python3 dirsearch.py -u $1 -e htm,html,xml,js,json,zip,asp,aspx,php,bak,sql,old,txt,gz,gz.tar -x 301,429,404,400 -t 200 -w db/apiwords.txt
cd -
}
fuffiles(){
ffuf -u $1/FUZZ -w ~/tools/dirsearch/db/raft-large-files.txt -mc 200,301,302 -t 200
}

fufdir(){
ffuf -u $1/FUZZ -w ~/tools/dirsearch/db/raft-large-directories.txt -mc 200,301,302,403 -t 200
}

dirsearch(){
cd ~/tools/dirsearch
sudo python3 dirsearch.py -u $1 -e htm,html,xml,js,json,zip,asp,aspx,php,bak,sql,old,txt,gz,gz.tar -x 301,502,404,400,429 -t 200
cd -
}

wordlist(){
cd ~/tools/dirsearch/db
}

sf(){
subfinder -d $1 -silent | httpx -status-code -web-server -title -silent -threads 100
}

bypass(){
~/tools/4-ZERO-3/403-bypass.sh -u $1 --exploit
}

source "$HOME/.cargo/env"

linkfinder(){
python3 ~/tools/LinkFinder/linkfinder.py -i $1 -o cli
}

fufresult(){
cat * | jq -r '.results[] | "\(.length)"+ " " +"\(.url)" + " " +  "\(.status)"' | sort -unt " " -k "1,1"
}

awsls(){
aws s3 ls s3://$1/ --no-sign-request
}

fierce(){
python3 ~/tools/fierce/fierce/fierce.py --domain $1 --wide --traverse 10
}
