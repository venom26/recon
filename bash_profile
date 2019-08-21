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


