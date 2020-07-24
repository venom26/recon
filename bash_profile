fd(){
findomain -t $1
}

fuf(){
ffuf -u $1/FUZZ -w ~/tools/dirsearch/db/dicc.txt -mc 200,301,302 -t 50
}

fufapi(){
ffuf -u $1/FUZZ -w ~/tools/dirsearch/db/apiwords.txt -mc 200 -t 50
}

arjun(){
cd ~/tools/Arjun
python3 arjun.py -u $1
cd -
}

ipinfo(){
curl ipinfo.io/$1
}

mscan(){
sudo /home/ubuntu/tools/masscan/bin/masscan -p80,443,8020,50070,50470,19890,19888,8088,8090,2075,2076,6443,3868,3366,8443,8080,9443,9091,3000,8000,5900,8081,6000,10000,8181,3306,5000,10000,4000,8888,5432,15672,9999,161,4044,7077,4040,9000,8089,7447,7080,8880,8983,5673,7443,19000,19080 --rate=100000 --open -iL $1 --banners -oG famous_ports.txt
}

mscanall(){
sudo /home/ubuntu/tools/masscan/bin/masscan -p0-65535 --rate=100000 --open -iL $1 --banners -oG all_ports.txt
}

crawl(){
echo $1 | hakrawler -depth 3 -plain
}

dirsearch(){
cd ~/tools/dirsearch
sudo python3 dirsearch.py -u $1 -e htm,html,xml,js,json,zip,asp,aspx,php,bak,sql,old,txt,gz,gz.tar -x 301,404,400,429 -t 200
cd -
}

dirapi(){
cd ~/tools/dirsearch
sudo python3 dirsearch.py -u $1 -e htm,html,xml,js,json,zip,asp,aspx,php,bak,sql,old,txt,gz,gz.tar -x 301,429,404,400 -t 200 -w db/apiwords.txt
cd -
}
fuffiles(){
ffuf -u $1/FUZZ -w ~/tools/dirsearch/db/raft-large-files.txt -mc 200,301,302 -t 50
}

fufdir(){
ffuf -u $1/FUZZ -w ~/tools/dirsearch/db/raft-large-directories.txt -mc 200,301,302,403 -t 70
}

dirsearch(){
cd ~/tools/dirsearch
sudo python3 dirsearch.py -u $1 -e htm,html,xml,js,json,zip,asp,aspx,php,bak,sql,old,txt,gz,gz.tar -x 301,502,404,400,429 -t 200
cd -
}

digit(){
dig @8.8.8.8 $1 CNAME
}

wordlist(){
cd ~/tools/dirsearch/db
}
fufextension(){
ffuf -u $1/FUZZ -mc 200,301,302,403,401 -t 150 -w ~/tools/dirsearch/db/ffuf_extension.txt -e php,asp,aspx,jsp,py,txt,conf,config,bak,backup,swp,old,db,sql,json,xml,log
}
fufthis(){
ffuf -u $1/FUZZ -mc 200,301,302,403,401 -t 150 -w $(pwd)/wordlist.txt -e php,asp,aspx,jsp,txt,conf,config,bak,backup,old,db,sql,json,xml,log
}
