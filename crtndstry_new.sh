#!/usr/bin/env bash

# This was created during a live stream on 11/16/2019
# twitch.tv/nahamsec
# Thank you to nukedx and dmfroberson for helping debug/improve
domain=$1

if [ ! -x "$(command -v jq)" ]; then
	echo "[-] This script requires jq. Exiting."
	exit 1
fi

certdata(){
	#give it patterns to look for within crt.sh for example %api%.site.com
	declare -a arr=("api" "corp" "dev" "uat" "test" "stag" "sandbox" "prod" "internal" "qa" "admin" "backend" "stage" "web" "web-qa" "web-dev" "uat" "beta")
	#for i in "${arr[@]}"
	#do
		#get a list of domains based on our patterns in the array
		echo "Running crt.sh"
		crtsh=$(curl -s https://crt.sh\?q\=%25.$1\&output\=json | jq . | grep 'name_value' | awk '{print $2}' | sed -e 's/"//g'| sed -e 's/,//g' |  awk '{gsub(/\\n/,"\n")}1' | grep -iv '*' |grep -iv '@' | grep -iv '\--' | sort -u | tee -a rawdata/$1-crtsh.txt )
	#done
		#get a list of domains from certspotter
		echo "Running Certspotter"
		certspotter=$(curl -s https://api.certspotter.com/v1/issuances?domain=$1\&include_subdomains=true\&expand=dns_names\&expand=issuer\&expand=cert | jq '.[].dns_names[]' | sed 's/\"//g' | sed 's/\*\.//g' | sort -u | tee -a rawdata/$1-certspotter.txt)
		#get a list of domains from digicert
		echo "Starting Bufferover"
		bufferover=$(curl -s "https://jldc.me/anubis/subdomains/$1" | grep -Po "((http|https):\/\/)?(([\w.-]*)\.([\w]*)\.([A-z]))\w+" | sed '/^\./d' | tee -a rawdata/$1-bufferover.txt)
		bufferover=$(curl -ss https://dns.bufferover.run/dns?q=.$1 | jq '.FDNS_A[]' | sed 's/^\".*.,//g' | sed 's/\"$//g'  | sort -u | tee -a rawdata/$1-bufferover.txt)
		bufferover=$(curl -s "https://dns.bufferover.run/dns?q=.$1" | jq -r .RDNS[] 2>/dev/null | cut -d ',' -f2 | grep -o "\w.*$1" | sort -u | tee -a rawdata/$1-bufferover.txt)
		bufferover=$(curl -s "https://tls.bufferover.run/dns?q=.$1" | jq -r .Results 2>/dev/null | cut -d ',' -f3 |grep -o "\w.*$1"| sort -u | cut -d '"' -f1| tee -a rawdata/$1-bufferover.txt)
	#echo "$crtsh"
	#echo "$certspotter"
	#echo "$bufferover"
}


rootdomains() { #this creates a list of all unique root sub domains
	cat rawdata/$1-crtsh.txt | rev | cut -d "."  -f 1,2,3 | sort -u | rev > ./$1-temp.txt
	cat rawdata/$1-certspotter.txt | rev | cut -d "."  -f 1,2,3 | sort -u | rev >> ./$1-temp.txt
	cat rawdata/$1-bufferover.txt | rev | cut -d "."  -f 1,2,3 | sort -u | rev >> ./$1-temp.txt
	domain=$1
	jq -r '.data.certificateDetail[].commonName,.data.certificateDetail[].subjectAlternativeNames[]' rawdata/$1-digicert.json | sed 's/"//g' | grep -w "$domain$" | grep -v '^*.' | rev | cut -d "."  -f 1,2,3 | sort -u | rev >> ./$1-temp.txt
	cat $1-temp.txt | tr '[:upper:]' '[:lower:]' | sort -u | tee ./data/$1-$(date "+%Y.%m.%d-%H.%M").txt; rm $1-temp.txt
	echo "[+] Number of domains found: $(cat ./data/$1-$(date "+%Y.%m.%d-%H.%M").txt | wc -l)"
}


certdata $1
rootdomains $1

cname() {
	for i in $(cat data/$domain*);do dig asxf $i | grep  CNAME;done | awk '{print $5}' | tee -a data/cname-temp.txt
	rev data/cname-temp.txt | cut -d'.' -f2- | rev >> data/cname-"$domain".txt
	rm -rf data/cname-temp.txt
}

cname
