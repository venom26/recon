#!/bin/bash

while getopts ":d:" input;do
        case "$input" in
                d) domain=${OPTARG}
                        ;;
                esac
        done
if [ -z "$domain" ]     
        then
                echo "Please give a domain like \"-d domain.com\""
                exit 1
fi

sublist3r -d $domain -v -o op.txt
subfinder -d $domain -o op.txt  
assetfinder --subs-only $domain | tee -a op.txt
amass enum -passive -d $doamin | tee -a op.txt
amass enum -active -d $domain -ip | tee -a amass_ips.txt
cat amass_ips.txt | awk '{print $1}' | tee -a op.txt
cat op.txt | sort -u | tee -a all.txt
echo -e "######Starting Bruteforce######\n"
altdns -i all.txt -o data_output -w ~/tools/recon/patterns.txt -r -s results_output.txt
mv results_output.txt dns_op.txt
cat dns_op.txt output.txt

cat output.txt | sort -u | tee -a all.txt
echo "Checking for alive subdomains"
cat all.txt | httprobe | tee -a alive2.txt
cat alive2.txt | sort -u | tee -a alive.txt

~/tools/massdns/bin/massdns -r ~/tools/massdns/lists/resolvers.txt -q -t A -o S -w massdns.raw all.txt
cat massdns.raw | grep -e ' A ' |  cut -d 'A' -f 2 | tr -d ' ' > massdns.txt
cat *.txt | sort -V | uniq > $IP_PATH/final-ips.txt
echo -e "${BLUE}[*] Check the list of IP addresses at $IP_PATH/final-ips.txt${RESET}"

echo "Starting Nuclei"
mkdir nuclei_op
nuclei -l alive.txt -t "/root/tools/nuclei-templates/cves/*.yaml" -c 60 -o nuclei_op/cves.txt
nuclei -l alive.txt -t "/root/tools/nuclei-templates/files/*.yaml" -c 60 -o nuclei_op/files.txt
nuclei -l alive.txt -t "/root/tools/nuclei-templates/panels/*.yaml" -c 60 -o nuclei_op/panels.txt
nuclei -l alive.txt -t "/root/tools/nuclei-templates/security-misconfiguration/*.yaml" -c 60 -o nuclei_op/security-misconfiguration.txt
nuclei -l alive.txt -t "/root/tools/nuclei-templates/technologies/*.yaml" -c 60 -o nuclei_op/technologies.txt
nuclei -l alive.txt -t "/root/tools/nuclei-templates/tokens/*.yaml" -c 60 -o nuclei_op/tokens.txt
nuclei -l alive.txt -t "/root/tools/nuclei-templates/vulnerabilities/*.yaml" -c 60 -o nuclei_op/vulnerabilities.txt

echo "Now looking for CORS misconfiguration"
python3 ~/tools/Corsy/corsy.py -i alive.txt -t 40 | tee -a corsy_op.txt

echo "Starting CMS detection"
whatweb -i alive.txt | tee -a whatweb_op.txt

mkdir wayback_data
cd wayback_data
for i in $(cat ../all.txt);do echo $i | waybackurls ;done | tee -a wb.txt
cat wb.txt  | sort -u | unfurl --unique keys | tee -a paramlist.txt

cat wb.txt u | grep -P "\w+\.js(\?|$)" | sort -u | tee -a jsurls.txt

cat wb.txt  | grep -P "\w+\.php(\?|$)" | sort -u  | tee -a phpurls.txt

cat wb.txt  | grep -P "\w+\.aspx(\?|$)" | sort -u  | tee -a aspxurls.txt

cat wb.txt  | grep -P "\w+\.jsp(\?|$)" | sort -u | tee -a jspurls.txt

cat wb.txt  | grep -P "\w+\.txt(\?|$)" | sort -u  | tee -a robots.txt

cd ..

echo "Looking for HTTP request smugglig"
python3 ~/tools/smuggler.py -u alive.txt | tee -a smuggler_op.txt

mkdir scripts
mkdir scriptsresponse
mkdir endpoints
mkdir responsebody
mkdir headers

jsep()
{
response(){
echo "Gathering Response"       
        for x in $(cat alive.txt)
do
        NAME=$(echo $x | awk -F/ '{print $3}')
        curl -X GET -H "X-Forwarded-For: evil.com" $x -I > "headers/$NAME" 
        curl -s -X GET -H "X-Forwarded-For: evil.com" -L $x > "responsebody/$NAME"
done
}

jsfinder(){
echo "Gathering JS Files"       
for x in $(ls "responsebody")
do
        printf "\n\n${RED}$x${NC}\n\n"
        END_POINTS=$(cat "responsebody/$x" | grep -Eoi "src=\"[^>]+></script>" | cut -d '"' -f 2)
        for end_point in $END_POINTS
        do
                len=$(echo $end_point | grep "http" | wc -c)
                mkdir "scriptsresponse/$x/" > /dev/null 2>&1
                URL=$end_point
                if [ $len == 0 ]
                then
                        URL="https://$x$end_point"
                fi
                file=$(basename $end_point)
                curl -X GET $URL -L > "scriptsresponse/$x/$file"
                echo $URL >> "scripts/$x"
        done
done
}

endpoints()
{
echo "Gathering Endpoints"
for domain in $(ls scriptsresponse)
do
        #looping through files in each domain
        mkdir endpoints/$domain
        for file in $(ls scriptsresponse/$domain)
        do
                ruby ~/tools/relative-url-extractor/extract.rb scriptsresponse/$domain/$file >> endpoints/$domain/$file 
        done
done

}
response
jsfinder
endpoints
}
jsep

cat endpoints/*/* | sort -u | tee -a endpoints.txt

for i in $(cat alive.txt);do ffuf -u $i/FUZZ -w ~/tools/dirsearch/db/dicc.txt -mc 200 -t 60 ;done| tee -a ffuf_op.txt
