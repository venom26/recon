ipinfo(){
#!/bin/bash
curl http://ipinfo.io/$1
}

crtsh(){
#!/bin/bash
curl -s https://crt.sh/?q=%.$1  | sed 's/<\/\?[^>]\+>//g' | grep $1
}

dirsearch(){
#!/bin/bash
cd /home/venom/tools/directory_bruteforce/dirsearch
sudo python3 dirsearch.py -u https://$1/ -e htm,html,js,zip,asp,aspx,php,bak,sql,old,txt,gz,gz.tar -x 301,404,400 -t 200
}

crtshauto(){
for i in `cat target.txt`
do
	curl -s https://crt.sh/\?q\=$1\&output\=json | jq -r '.[].name_value' | sed 's/\*\.//g' | sort -u  | tee -a all.txt
done
}
1)create a file named target.txt and store all your subdomains that you got from crtsh and certspotter.
2)./crtshauto.sh 
3)It will find all multi level subdomains and store it in all.txt


fileuploadchecker(){
#!/bin/bash
curl --upload-file test.txt $1
}


#To get more ip's/subdomains
ipinfo.io target
crt.sh %.target.com
asntoip(){
curl https://ipinfo.io/$1 >/dev/null | hxnormalize -x | hxselect '#ipv4-data tr>tda::attr(href)' -s '\n' | cut -d'/' -f3- | sed 's/.$//'
}
#$1 is asn number that you will get from ipinfo.io website.It looks like 'https://ipinfo.io/AS26444' here asn number is AS26444 
#before running above command make sure to install html-xml-utils
sudo apt-get install html-xml-utils

#To find open ports of an ip range:-
mscan(){
sudo masscan -p80,443,2075,2076,6443,3868,3366,8443,8080,9443,9091,3000,8000,5900,8081,6000,10000,8181,3306,5000,4000,8888,5432,15672,9999,161,4044,7077,4040,9000,8089,7447,7080,8880,8983,5673,7443,19000,19080 --rate=100000 --open --range $1 --banners -oG $2.txt
}
$1 is single ip range 
$2 is output file name

#To find open ports from list of ip address

mscanl(){
sudo masscan -p80,443,2075,2076,6443,3868,3366,8443,8080,9443,9091,3000,8000,5900,8081,6000,10000,8181,3306,5000,4000,8888,5432,15672,9999,161,4044,7077,4040,9000,8089,7447,7080,8880,8983,5673,7443,19000,19080 --rate=100000 --open -iL $1 --banners -oG $2.txt
}
$1 is name of file containing ip list
$2 is name of output file
