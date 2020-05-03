#!/bin/bash

CUR_DIR=$(pwd)
#starting findomain
echo "######Starting Findomain#########"
findomain -t $1 -u $CUR_DIR/domains.txt

#starting sublist3r
echo "######Starting Sublist3r######"
sublist3r -d $1 -v -o $CUR_DIR/domains.txt

#starting subfinder
echo "#######Starting Subfiner####"
subfinder -d $domain -o $CUR_DIR/domains.txt

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

cat all.txt | httprobe -c 40 | tee -a alive2.txt
cat resolved.txt | httprobe -c 40 | tee -a alive2.txt
cat alive2.txt | sort -u |tee -a alive.txt
rm -rf alive2.txt 
rm -rf domains.txt
