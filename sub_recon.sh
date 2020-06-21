#!/bin/bash

echo "####Don't Forget to add your github Token #####"
sleep 5

CUR_DIR=$(pwd)
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
amass enum -d $1  | tee -a $CUR_DIR/domains.txt

cat $CUR_DIR/domains.txt | sort -u | tee -a all.txt

#starting shuffledns
echo "#####starting shuffledns#####"
shuffledns -d $1 -w ~/tools/subdomains.txt -r ~/tools/subbrute/resolvers.txt | tee -a bruteforced.txt

cat bruteforced.txt | tee -a all.txt 

shuffledns -d $1 -list all.txt -r ~/tools/subbrute/resolvers.txt | tee -a resolved.txt

echo "####Gathering IP Addresses####"
cat all.txt | xargs -n1 -P10 -I{} python3 ~/tools/recon/getip.py {} |grep IP | awk '{print $2}' | sort -u | tee -a ip.txt

echo "####Getting Shodan Info####"
cat ip.txt | python3 ~/tools/Shodanfy.py/shodanfy.py --stdin --getvuln --getports --getinfo --getbanner | tee -a shodan.txt

cat all.txt | httprobe -c 40 | tee -a alive2.txt
cat resolved.txt | httprobe -c 40 | tee -a alive2.txt
cat alive2.txt | sort -u |tee -a alive.txt
rm -rf alive2.txt 
rm -rf domains.txt

cat all.txt | httpx -title -content-length -status-code | tee -a httpx.txt 
cat all.txt | xargs -n1 -P4 -I{} waybackurls {} | tee -a wb.txt
cat all.txt | xargs -n1 -P4 -I{} gau -subs {} | tee -a wb.txt
cat wb.txt | sort -u | tee -a wb2.txt
rm -rf wb.txt
mv wb2.txt wb.txt

mkdir js
cat alive.txt | subjs| tee -a js/js.txt
cd js
cat js.txt | concurl -c 5
cd -

echo "####Starting Github Subdomain Scanning #####"
mkdir github_recon
for i in {1..5};do python3 ~/tools/github-subdomains.py -t '' -d $1 | tee -a $CUR_DIR/github_recon/github_subs.txt ;done


echo "####Starting altdns####"
mkdir altdns_op
cd altdns_op
altdns -i ../all.txt -o data_output -w ~/tools/recon/patterns.txt -r -s results_output.txt
cd ..

