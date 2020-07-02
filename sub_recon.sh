#!/bin/bash

echo "####Don't Forget to add your github Token #####"
sleep 5

CUR_DIR=$(pwd)
github_token=''
#starting findomain
echo "######Starting Findomain#########"
findomain -t $1 -u $CUR_DIR/domains.txt

#starting sublist3r
echo "######Starting Sublist3r######"
sublist3r -d $1 -v -o $CUR_DIR/domains.txt

#starting subfinder
echo "#######Starting Subfiner####"
subfinder -d $1 -silent | tee -a  $CUR_DIR/domains.txt

#running assetfinder
echo "######Starting assetfinder######"
assetfinder --subs-only $1 | tee -a $CUR_DIR/domains.txt

#running bufferover
echo "######Starting bufferover######"
curl -ss https://dns.bufferover.run/dns?q=.$1 | jq '.FDNS_A[]' | sed 's/^\".*.,//g' | sed 's/\"$//g'  | sort -u | tee -a $CUR_DIR/domains.txt

#running amass
echo "######Running Amass######"
amass enum -passive -d $1  | tee -a $CUR_DIR/domains.txt

cat $CUR_DIR/domains.txt | sort -u | tee -a $CUR_DIR/all.txt

#starting shuffledns
echo "#####starting shuffledns#####"
shuffledns -d $1 -w ~/tools/subdomains.txt -r ~/tools/subbrute/resolvers.txt | tee -a $CUR_DIR/bruteforced.txt

cat $CUR_DIR/bruteforced.txt | tee -a $CUR_DIR/all.txt 

shuffledns -d $1 -list all.txt -r ~/tools/subbrute/resolvers.txt | tee -a $CUR_DIR/resolved.txt
cat $CUR_DIR/resolved.txt | tee -a $CUR_DIR/all.txt
cat $CUR_DIR/all.txt | dnsgen - | shuffledns -silent -d "$domain" -r ~/tools/subbrute/resolvers.txt -o $CUR_DIR/dnsgen.txt
cat $CUR_DIR/dnsgen.txt | sort -u | tee -a $CUR_DIR/all.txt
cat $CUR_DIR/all.txt | sort -u | tee -a $CUR_DIR/temp.txt
rm -rf $CUR_DIR/all.txt
mv $CUR_DIR/temp.txt $CUR_DIR/all.txt


echo "####Gathering IP Addresses####"
cat $CUR_DIR/all.txt | xargs -n1 -P10 -I{} python3 ~/tools/recon/getip.py {} 2> /dev/null|grep IP | awk '{print $2}' | sort -u | tee -a $CUR_DIR/ip.txt

echo "####Getting Shodan Info####"
cat $CUR_DIR/ip.txt | python3 ~/tools/Shodanfy.py/shodanfy.py --stdin --getvuln --getports --getinfo --getbanner | tee -a $CUR_DIR/shodan.txt

cat $CUR_DIR/all.txt | httprobe -c 40 | tee -a $CUR_DIR/alive2.txt
cat $CUR_DIR/resolved.txt | httprobe -c 40 | tee -a $CUR_DIR/alive2.txt
cat $CUR_DIR/alive2.txt | sort -u |tee -a $CUR_DIR/alive.txt
rm -rf $CUR_DIR/alive2.txt 
rm -rf $CUR_DIR/domains.txt

cat $CUR_DIR/all.txt | httpx -title -content-length -status-code | tee -a $CUR_DIR/httpx.txt 
cat $CUR_DIR/all.txt | xargs -n1 -P4 -I{} waybackurls {} | tee -a $CUR_DIR/wb.txt
cat $CUR_DIR/all.txt | xargs -n1 -P4 -I{} gau -subs {} | tee -a $CUR_DIR/wb.txt
cat $CUR_DIR/wb.txt | sort -u | tee -a $CUR_DIR/wb2.txt
rm -rf $CUR_DIR/wb.txt
mv $CUR_DIR/wb2.txt $CUR_DIR/wb.txt

mkdir js
cat $CUR_DIR/alive.txt | subjs| tee -a js/js.txt
cd js
cat js.txt | concurl -c 5
cat ../wb.txt |egrep -iv '\.json'|grep -iE '\.js'|antiburl|awk '{print $4}' | xargs -I %% bash -c 'python3 ~/tools/SecretFinder/SecretFinder.py -i %% -o cli' 2> /dev/null | tee -a secrets.txt
cat $CUR_DIR/js.txt |egrep -iv '\.json'|grep -iE '\.js'|antiburl|awk '{print $4}' | xargs -I %% bash -c 'python3 ~/tools/SecretFinder/SecretFinder.py -i %% -o cli' 2> /dev/null | tee -a secrets.txt
cat js.txt | while read url;do python3 ~/tools/LinkFinder/linkfinder.py -d -i $url -o cli;done > exdpoints.txt
cd -

echo "####Starting Naabu For Port Scanning####"
for i in $(cat $CUR_DIR/ip.txt);do naabu -silent -host $i -json;done | tee -a $CUR_DIR/ports.txt


echo "####Starting Github Subdomain Scanning #####"
mkdir $CUR_DIR/github_recon
for i in {1..5};do python3 ~/tools/github-subdomains.py -t $github_token -d $1 | tee -a $CUR_DIR/github_recon/github_subs.txt ;done
python3 ~/tools/github-endpoints.py -d $1 -t $github_token -s -r | tee -a $CUR_DIR/github_recon/github_endpoints.txt


echo "####Starting altdns####"
mkdir $CUR_DIR/altdns_op
cd $CUR_DIR/altdns_op
altdns -i ../all.txt -o data_output -w ~/tools/recon/patterns.txt -r -s results_output.txt
cd ..

echo "Starting FFUF"
mkdir $CUR_DIR/ffuf_op
for i in $(cat $CUR_DIR/alive.txt);do ffuf -u $i/FUZZ -w ~/tools/dirsearch/db/dicc.txt -mc 200 -t 60 -fs 0 -o ffuf_op/$ffufop.html -of html -t 60;done

gospider -S $CUR_DIR/alive.txt --depth 3 --no-redirect -t 50 -c 3 -o gospider_out
