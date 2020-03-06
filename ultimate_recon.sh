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

subdomain()
{
#	crtsh $domain | tee -a op.txt
	sublist3r -d $domain -v -o op.txt
	subfinder -d $domain -o op.txt	
	assetfinder --subs-only $domain | tee -a op.txt
	amass enum -passive -d $doamin | tee -a op.txt
	amass enum -active -d $domain -ip | tee -a amass_ips.txt
	cat amass_ips.txt | awk '{print $1}' | tee -a op.txt
}
sort()
{
	cat op.txt | sort -u | tee -a all.txt
}
bruteforce()
{
	echo -e "######Starting Bruteforce######\n"
altdns -i all.txt -o data_output -w ~/tools/recon/patterns.txt -r -s results_output.txt
mv results_output.txt dns_op.txt
cat dns_op.txt all.txt
}

subdomain
sort
bruteforce

mv all.txt output.txt
echo "Checking for alive subdomains"
cat output.txt | httprobe | tee -a alive2.txt
uniq alive2.txt >> alive.txt

wb()
{
	for i in $(cat op.txt);do echo $i | waybackurls ;done | tee -a wb.txt
	}
wb	

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
