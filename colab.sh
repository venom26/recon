#!/bin/bash

RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
RESET=$(tput sgr0)

AMASS_VERSION=3.8.2


echo "${RED} ######################################################### ${RESET}"
echo "${RED} #                 TOOLS FOR BUG BOUNTY                  # ${RESET}"
echo "${RED} ######################################################### ${RESET}"
logo(){
echo "${BLUE}
                ___ ___ _  _ _____     ___
               | _ ) _ ) || |_   _|_ _|_  )
               | _ \ _ \ __ | | | \ V // /
               |___/___/_||_| |_|  \_//___| ${RESET}"
}
logo
echo ""
echo "${GREEN} Tools created by the best people in the InfoSec Community ${RESET}"
echo "${GREEN}                   Thanks to everyone!                     ${RESET}"
echo ""


echo "${GREEN} [+] Updating and installing dependencies ${RESET}"
echo ""

sudo apt-get -y update
sudo apt-get -y upgrade

sudo add-apt-repository -y ppa:apt-fast/stable < /dev/null
sudo echo debconf apt-fast/maxdownloads string 16 | debconf-set-selections
sudo echo debconf apt-fast/dlflag boolean true | debconf-set-selections
sudo echo debconf apt-fast/aptmanager string apt-get | debconf-set-selections
sudo apt install -y apt-fast

sudo apt-fast install -y apt-transport-https
sudo apt-fast install -y libcurl4-openssl-dev
sudo apt-fast install -y libssl-dev
sudo apt-fast install -y jq
sudo apt-fast install -y ruby-full
sudo apt-fast install -y libcurl4-openssl-dev libxml2 libxml2-dev libxslt1-dev ruby-dev build-essential libgmp-dev zlib1g-dev
sudo apt-fast install -y build-essential libssl-dev libffi-dev python-dev
sudo apt-fast install -y python-setuptools
sudo apt-fast install -y libldns-dev
sudo apt-fast install -y python3-pip
sudo apt-fast install -y python-dnspython
sudo apt-fast install -y git
sudo apt-fast install -y npm
sudo apt-fast install -y nmap phantomjs 
sudo apt-fast install -y gem
sudo apt-fast install -y perl 
sudo apt-fast install -y parallel
pip3 install jsbeautifier
echo ""
echo ""
sar 1 1 >/dev/null

#Setting shell functions/aliases
echo "${GREEN} [+] Setting bash_profile aliases ${RESET}"
curl https://raw.githubusercontent.com/unethicalnoob/aliases/master/bashprofile > ~/.bash_profile
echo "${BLUE} If it doesn't work, set it manually ${RESET}"
echo ""
echo ""
sar 1 1 >/dev/null 

echo "${GREEN} [+] Installing Golang ${RESET}"
if [ ! -f /usr/bin/go ];then
    cd ~
    wget -q -O - https://raw.githubusercontent.com/canha/golang-tools-install-script/master/goinstall.sh | bash
	export GOROOT=$HOME/.go
	export PATH=$GOROOT/bin:$PATH
	export GOPATH=$HOME/go
    echo 'export GOROOT=$HOME/.go' >> ~/.bash_profile
	
	echo 'export GOPATH=$HOME/go'	>> ~/.bash_profile			
	echo 'export PATH=$GOPATH/bin:$GOROOT/bin:$PATH' >> ~/.bash_profile
    source ~/.bash_profile 
else 
    echo "${BLUE} Golang is already installed${RESET}"
fi
    break
echo""
echo "${BLUE} Done Install Golang ${RESET}"
echo ""
echo ""
sar 1 1 >/dev/null

#Installing tools

echo "${RED} #################### ${RESET}"
echo "${RED} # Installing tools # ${RESET}"
echo "${RED} #################### ${RESET}"


echo "${GREEN} #### Basic Tools #### ${RESET}"

#install altdns
echo "${BLUE} installing altdns ${RESET}"
sudo pip3 install py-altdns
echo "${BLUE} done${RESET}"
echo ""

#install nmap
echo "${BLUE} installing nmap${RESET}"
sudo apt-fast install -y nmap
echo "${BLUE} done${RESET}"
echo ""


echo "${BLUE} downloading virtual host discovery${RESET}"
git clone https://github.com/jobertabma/virtual-host-discovery.git ~/tools/vhd
echo "${BLUE} done${RESET}"
echo ""

#install sqlmap
echo "${BLUE} installing sqlmap${RESET}"
sudo apt-fast install sqlmap
echo "${BLUE} done${RESET}"
echo ""


echo "${BLUE} downloading knockpy${RESET}"
git clone https://github.com/guelfoweb/knock.git ~/tools/knockpy
cd ~/tools/knockpy
sudo python setup.py install
echo "${BLUE} done${RESET}"
echo ""

echo "${BLUE} installing knock2${RESET}"
go get -u github.com/harleo/knockknock
echo "${BLUE} done${RESET}"
echo ""

echo "${BLUE} downloading asnlookup${RESET}"
git clone https://github.com/yassineaboukir/asnlookup.git ~/tools/asnlookup
cd ~/tools/asnlookup
sudo pip3 install -r requirements.txt
echo "${BLUE} done${RESET}"
echo ""

echo "${BLUE} installing metabigor${RESET}"
go get -u github.com/j3ssie/metabigor
echo "${BLUE} done${RESET}"

sar 1 1 >/dev/null
echo ""

echo "${GREEN}#### Installing fuzzing tools ####${RESET}"
#install gobuster
echo "${BLUE} installing gobuster${RESET}"
sudo go get -u github.com/OJ/gobuster
echo "${BLUE} done${RESET}"
echo ""

#install ffuf
echo "${BLUE} installing ffuf${RESET}"
go get -u github.com/ffuf/ffuf
echo "${BLUE} done${RESET}"
echo ""

echo "${BLUE} installing dirsearch${RESET}"
git clone https://github.com/maurosoria/dirsearch.git ~/tools/dirsearch
echo "${BLUE} done${RESET}"
echo ""

echo "${BLUE} installing wfuzz${RESET}"
sudo apt-fast install wfuzz
echo "${BLUE} done${RESET}"
echo ""
sar 1 1 >/dev/null

echo "${GREEN}#### Installing Domain Enum Tools ####${RESET}"

#install aquatone
echo "${BLUE} Installing Aquatone ${RESET}"
go get -u github.com/michenriksen/aquatone 
echo "${BLUE} done ${RESET}"
echo ""

#install subDomainizer
echo "${BLUE} subdomainizer ${RESET}"
git clone https://github.com/nsonaniya2010/SubDomainizer.git ~/tools/SubDomainizer
cd ~/tools/SubDomainizer && chmod +x SubDomainizer.py
sudo pip3 install -r requirements.txt 
echo "${BLUE} done ${RESET}"
echo ""

#install domain_analyzer
echo "${BLUE} domain_analyzer ${RESET}"
git clone https://github.com/eldraco/domain_analyzer.git ~/tools/domain_analyzer
echo "${BLUE} done ${RESET}"
echo ""

#install massdns
echo "${BLUE} Installing massdns ${RESET}"
git clone https://github.com/blechschmidt/massdns.git ~/tools/massdns
cd ~/tools/massdns
make
echo "${BLUE} done ${RESET}"
echo ""

#install sub.sh
echo "${BLUE} sub.sh ${RESET}"
git clone https://github.com/cihanmehmet/sub.sh.git ~/tools/subsh
cd ~/tools/subsh && chmod +x sub.sh
echo "${BLUE} done ${RESET}"
echo ""

#install subjack
echo "${BLUE} installing subjack ${RESET}"
go get -u github.com/haccer/subjack
echo "${BLUE} done ${RESET}"
echo ""

echo "${BLUE} installing Sublister ${RESET}"
git clone https://github.com/aboul3la/Sublist3r.git ~/tools/Sublist3r
cd ~/tools/Sublist3r
sudo pip3 install -r requirements.txt
echo "${BLUE} done ${RESET}"
echo ""

echo "${BLUE} installing Subover ${RESET}"
go get -u github.com/Ice3man543/SubOver
echo "${BLUE} done ${RESET}"
echo ""

echo "${BLUE} installing spyse ${RESET}"
sudo pip3 install spyse.py
echo "${BLUE} done ${RESET}"
echo ""
sar 1 1 >/dev/null


echo "${GREEN} #### Installing CORS Tools #### ${RESET}"

echo "${BLUE} installing corsy ${RESET}"
git clone https://github.com/s0md3v/Corsy.git ~/tools/corsy
sudo pip3 install -r requirements.txt
echo "${BLUE} done ${RESET}"
echo ""

echo "${BLUE} installing cors-scanner ${RESET}"
git clone https://github.com/chenjj/CORScanner.git ~/tools/corscanner
sudo pip3 install -r requirements.txt
echo "${BLUE} done ${RESET}"
echo ""

echo "${BLUE} installing another cors scanner${RESET}"
go get -u github.com/Tanmay-N/CORS-Scanner
echo "${BLUE} done${RESET}"
echo ""
sar 1 1 >/dev/null



echo "${GREEN} #### Installing XSS Tools#### ${RESET}"

echo "${BLUE} installing dalfox${RESET}"
git clone https://github.com/hahwul/dalfox ~/tools/dalfox
cd ~/tools/dalfox/ && go build dalfox.go
sudo cp dalfox /usr/bin/
echo "${BLUE} done${RESET}"
echo ""

echo "${BLUE} installing XSStrike${RESET}"
git clone https://github.com/s0md3v/XSStrike.git ~/tools/XSStrike 
cd ~/tools/XSStrike
sudo pip3 install -r requirements.txt
echo "${BLUE} done${RESET}"
echo ""

#Xspear for XSS
echo "${BLUE} installing XSpear${RESET}"
sudo gem install XSpear
sudo gem install colorize
sudo gem install selenium-webdriver
sudo gem install terminal-table
sudo gem install progress_bar
echo "${BLUE} done${RESET}"
echo ""

#traxss
echo "${BLUE} downloading traxss${RESET}"
git clone https://github.com/M4cs/traxss.git ~/tools/traxss
cd ~/tools/traxss
sudo pip3 install -r requirements.txt
echo "${BLUE} done${RESET}"
echo ""
sar 1 1 >/dev/null



echo "${GREEN} #### Installing Cloud workflow Tools #### ${RESET}"

echo "${BLUE} Instaliing awscli${RESET}"
sudo pip3 install awscli --upgrade --user
echo "${BLUE} Don't forget to set up AWS credentials!${RESET}"
echo "${BLUE} done${RESET}"
echo ""


#install s3-buckets-finder
echo "${BLUE} s3-buckets-finder${RESET}"
git clone https://github.com/gwen001/s3-buckets-finder.git ~/tools/s3-buckets-finder
echo "${BLUE} done${RESET}"
echo ""


#install lazys3
echo "${BLUE} lazys3${RESET}"
git clone https://github.com/nahamsec/lazys3.git ~/tools/lazys3
echo "${BLUE} done${RESET}"
echo ""

#install DumpsterDiver
echo "${BLUE} DumpsterDiver${RESET}"
git clone https://github.com/securing/DumpsterDiver.git ~/tools/DumpsterDiver
cd ~/tools/DumpsterDiver && chmod +x DumpsterDiver.py
sudo pip3 install -r requirements.txt
echo "${BLUE} done${RESET}"
echo ""

#install S3Scanner
echo "${BLUE} installing S3Scanner${RESET}"
git clone https://github.com/sa7mon/S3Scanner.git ~/tools/S3Scanner 
cd ~/tools/S3Scanner
sudo pip3 install -r requirements.txt
echo "${BLUE} done${RESET}"
echo ""


echo "${BLUE} installing Cloudflair${RESET}"
git clone https://github.com/christophetd/CloudFlair.git ~/tools/CloudFlair
cd ~/tools/CloudFlair && chmod +x cloudflair.py
sudo pip3 install -r requirements.txt
echo "${BLUE} done${RESET}"
echo ""


echo "${BLUE} installing Cloudunflare${RESET}"
git clone https://github.com/greycatz/CloudUnflare.git ~/tools/CloudUnflare
echo "${BLUE} done${RESET}"
echo ""


echo "${BLUE} installing flumberboozle${RESET}"
git clone https://github.com/fellchase/flumberboozle ~/tools/flumberboozle
echo "${BLUE} done${RESET}"
echo ""



#install GCPBucketBrute
echo "${BLUE} installing GCPBucketBrute${RESET}"
git clone https://github.com/RhinoSecurityLabs/GCPBucketBrute.git ~/tools/GCPBucketBrute
cd ~/tools/GCPBucketBrute
sudo python3 -m pip install -r requirements.txt
echo "${BLUE} done${RESET}"
echo ""
sar 1 1 >/dev/null


echo "${GREEN} #### Installing CMS Tools #### ${RESET}" 
#install CMSmap
echo "${BLUE} installing CMSmap${RESET}"
git clone https://github.com/Dionach/CMSmap.git ~/tools/CMS/CMSmap
cd ~/tools/CMS/CMSmap
sudo pip3 install .
echo "${BLUE} done${RESET}"
echo ""

echo "${BLUE} installing wig${RESET}"
git clone https://github.com/jekyc/wig.git ~/tools/CMS/wig
cd ~/tools/wig
sudo python3 setup.py install
echo "${BLUE} done${RESET}"
echo "" 

#install CMSeek
echo "${BLUE} installing CMSeek${RESET}"
git clone https://github.com/Tuhinshubhra/CMSeeK.git ~/tools/CMS/CMSeek
cd ~/tools/CMS/CMSeek
sudo python3 -m pip install -r requirements.txt
echo "${BLUE} done${RESET}"
echo ""

#install Joomscan
echo "${BLUE} installing Joomscan${RESET}"
git clone https://github.com/rezasp/joomscan.git ~/tools/CMS/Joomscan
echo "${BLUE} done${RESET}"
echo ""

#install wpscan
echo "${BLUE} installing wpscan${RESET}"
sudo gem install wpscan
echo "${BLUE} done${RESET}"
echo ""

#install droopescan
echo "${BLUE} installing droopescan${RESET}"
sudo pip3 install droopescan
echo "${BLUE} done${RESET}"
echo ""

#install drupwn
echo "${BLUE} installing drupwn${RESET}"
git clone https://github.com/immunIT/drupwn.git ~/tools/CMS/drupwn
cd ~/tools/CMS/drupwn
sudo python3 setup.py install
echo "${BLUE} done${RESET}"
echo ""

echo "${BLUE} Adobe scanner${RESET}"
git clone https://github.com/0ang3el/aem-hacker.git ~/tools/CMS/aem-hacker
echo "${BLUE} done${RESET}"
echo ""
sar 1 1 >/dev/null


echo "${GREEN}#### Downloading Git tools ####${RESET}"

echo "${BLUE} git-scanner${RESET}"
git clone https://github.com/HightechSec/git-scanner ~/tools/GIT/git-scanner
cd ~/tools/GIT/git-scanner && chmod +x gitscanner.sh
echo "${BLUE} done${RESET}"
echo ""

echo "${BLUE} gitgraber${RESET}"
git clone https://github.com/hisxo/gitGraber.git ~/tools/GIT/gitGraber
cd ~/tools/GIT/gitGraber && chmod +x gitGraber.py
sudo pip3 install -r requirements.txt
echo "${BLUE} done${RESET}"
echo ""

echo "${BLUE}  GitHound${RESET}"
git clone https://github.com/tillson/git-hound.git ~/tools/GIT/git-hound
cd ~/tools/GIT/git-hound
sudo go build main.go && mv main githound
echo "${BLUE} Create a ./config.yml or ~/.githound/config.yml${RESET}"
echo "${BLUE} done${RESET}"
echo ""

echo "${BLUE} gitsearch${RESET}"
git clone https://github.com/gwen001/github-search.git ~/tools/GIT/github-search
cd ~/tools/GIT/github-search 
sudo pip3 install -r  requirements3.txt
echo "${BLUE} done${RESET}"
echo ""
sar 1 1 >/dev/null






echo "${GREEN}#### Downloading Frameworks ####${RESET}"
#install Sn1per
echo "${BLUE} Sn1per${RESET}"
git clone https://github.com/1N3/Sn1per.git ~/tools/Frameworks/Sn1per
echo "${BLUE} done${RESET}"
echo ""

#install Osmedeus
echo "${BLUE} Osmedeus${RESET}"
git clone https://github.com/j3ssie/Osmedeus.git ~/tools/Frameworks/osmedeus
echo "${BLUE} done${RESET}"
echo ""

#install Cobra
echo "${BLUE} Cobra${RESET}"
git clone https://github.com/WhaleShark-Team/cobra.git ~/tools/Frameworks/Cobra
echo "${BLUE} done${RESET}"
echo ""

#install TIDoS-Framework
echo "${BLUE} TIDoS-Framework${RESET}"
git clone https://github.com/0xinfection/tidos-framework.git ~/tools/Frameworks/TIDoS-Framework
cd ~/tools/Frameworks/TIDoS-Framework
chmod +x install
echo "${BLUE} done${RESET}"
echo ""

echo "${BLUE} WAScan${RESET}"
git clone https://github.com/m4ll0k/WAScan.git ~/tools/Frameworks/WAScan
echo "${BLUE} done${RESET}"
echo ""

#install Blackwidow#
echo "${BLUE} blackwidow${RESET}"
git clone https://github.com/1N3/BlackWidow.git ~/tools/Frameworks/BlackWidow
cd ~/tools/Frameworks/BlackWidow
echo "${BLUE} done${RESET}"
echo ""

echo "${BLUE} installing Sudomy${RESET}"
git clone --recursive https://github.com/screetsec/Sudomy.git ~/tools/Frameworks/Sudomy
cd ~/tools/Frameworks/Sudomy
sudo pip3 install -r requirements.txt
sudo npm i -g wappalyzer
echo "${BLUE} done${RESET}"
echo ""

echo "${BLUE} installing findomain${RESET}"
cd ~/tools/Frameworks
wget https://github.com/Edu4rdSHL/findomain/releases/latest/download/findomain-linux
sudo chmod +x findomain-linux
sudo cp findomain-linux /usr/bin/findomain
echo "${BLUE} Add your keys in the config file"
echo "${BLUE} done${RESET}"
echo ""
sar 1 1 >/dev/null

echo "${GREEN}#### Other Tools ####${RESET}"

echo "${BLUE} installing SSRFMap ${RESET}"
git clone https://github.com/swisskyrepo/SSRFmap ~/tools/SSRFMap
cd ~/tools/SSRFMap/
sudo pip3 install -r requirements.txt
echo "${BLUE} done${RESET}"
echo ""

echo "${BLUE} installing XSRFProbe${RESET}"
sudo pip3 install xsrfprobe
echo "${BLUE} done${RESET}"
echo ""


#install JSParser
echo "${BLUE} installing JSParser${RESET}"
git clone https://github.com/nahamsec/JSParser.git ~/tools/JSParser
cd ~/tools/JSParser
sudo python3 setup.py install
echo "${BLUE} done${RESET}"
echo ""

#install subjs
echo "${BLUE} installing subjs${RESET}"
go get -u github.com/lc/subjs
echo "${BLUE} done${RESET}"
echo ""

echo "${BLUE} installing broken-link-checker${RESET}"
sudo npm install broken-link-checker -g
echo "${BLUE} done${RESET}"
echo ""

echo "${BLUE} installing pwncat${RESET}"
sudo pip3 install pwncat
echo "${BLUE} done${RESET}"
echo ""

echo "${BLUE} installing Photon${RESET}"
git clone https://github.com/s0md3v/Photon.git ~/tools/Photon
cd ~/tools/Photon
sudo pip3 install -r requirements.txt
echo "${BLUE} done${RESET}"
echo ""

echo "${BLUE} installing hakrawler${RESET}"
git clone https://github.com/hakluke/hakrawler.git ~/tools/hakrawler
cd ~/tools/hakrawler
go build main.go && mv main hakrawler
sudo mv hakrawler /usr/bin/
echo "${BLUE} done${RESET}"
echo ""

echo "${BLUE} installing waff00f${RESET}"
git clone https://github.com/EnableSecurity/wafw00f.git ~/tools/waff00f
cd ~/tools/wafw00f
sudo python3 setup.py install
echo "${BLUE} done${RESET}"
echo ""


echo "${BLUE} Paramspider${RESET}"
git clone https://github.com/devanshbatham/ParamSpider ~/tools/ParamSpider
cd ~/tools/ParamSpider
sudo pip3 install -r requirements.txt
echo "${BLUE} done${RESET}"
echo ""

echo "${BLUE} jexboss${RESET}"
git clone https://github.com/joaomatosf/jexboss.git ~/tools/jexboss
cd ~/tools/jexboss
sudo pip3 install -r requires.txt
echo "${BLUE} done${RESET}"
echo ""

echo "${BLUE} goohak${RESET}"
git clone https://github.com/1N3/Goohak.git ~/tools/Goohak
cd ~/tools/Goohak && chmod +x goohak
echo "${BLUE} done${RESET}"
echo ""

echo "${BLUE} installing webtech${RESET}"
sudo pip3 install webtech
echo "${BLUE} done${RESET}"
echo ""

echo "${BLUE} installing gau${RESET}"
go get -u github.com/lc/gau
echo "${BLUE} done${RESET}"
echo ""

cd ~/tools/
wget https://github.com/OWASP/Amass/releases/download/v3.8.2/amass_linux_amd64.zip
cd amass_linux_amd64/
sudo cp amass /usr/bin/
cd ~/tools
cd ~/tools
echo "Getting smuggler.py"
wget https://raw.githubusercontent.com/gwen001/pentest-tools/master/smuggler.py
git clone https://github.com/venom26/recon.git
cd ~/tools/dirsearch/db/
wget https://github.com/xyele/hackerone_wordlist/releases/download/beta/wordlists.zip
unzip wordlists.zip
cp ~/tools/dirsearch/db/apiwords.txt .
cp ~/tools/recon/ffuf_extension.txt .
wget https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/DNS/deepmagic.com-prefixes-top50000.txt
wget https://raw.githubusercontent.com/assetnote/commonspeak2-wordlists/master/wordswithext/php.txt
wget https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/raft-large-files.txt
wget https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/raft-large-directories.txt
wget https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/spring-boot.txt
wget https://raw.githubusercontent.com/milo2012/pathbrute/master/defaultPaths.txt
wget https://raw.githubusercontent.com/milo2012/pathbrute/master/cvePaths.txt
cd ~/tools
wget https://raw.githubusercontent.com/m4ll0k/Bug-Bounty-Toolz/master/getjswords.py
wget https://raw.githubusercontent.com/gwen001/github-search/master/github-endpoints.py
wget https://raw.githubusercontent.com/gwen001/github-search/master/github-subdomains.py
wget https://raw.githubusercontent.com/assetnote/commonspeak2-wordlists/master/subdomains/subdomains.txt

echo "${BLUE} LinkFinder${RESET}"
git clone https://github.com/GerbenJavado/LinkFinder.git ~/tools/LinkFinder
cd ~/tools/LinkFinder
sudo pip3 install -r requirements.txt
sudo python3 setup.py install
echo "${BLUE} done${RESET}"
echo ""

echo "${BLUE} SecretFinder${RESET}"
git clone https://github.com/m4ll0k/SecretFinder.git ~/tools/SecretFinder
cd ~/tools/SecretFinder && chmod +x secretfinder
sudo pip3 install -r requirements.txt
echo "${BLUE} done${RESET}"
echo ""
sar 1 1 >/dev/null


echo "${GREEN}#### ProjectDiscovery Pinned Tools ####${RESET}"

echo "${BLUE} installing naabu${RESET}"
go get -u github.com/projectdiscovery/naabu/cmd/naabu
echo "${BLUE} done${RESET}"
echo ""


echo "${BLUE} installing dnsprobe${RESET}"
go get -u github.com/projectdiscovery/dnsprobe
echo  "${BLUE} done${RESET}"
echo ""

echo "${BLUE} installing nuclei${RESET}"
go get -u github.com/projectdiscovery/nuclei/cmd/nuclei
echo "${BLUE} done${RESET}"
echo ""

echo "${BLUE} installing subfinder${RESET}"
go get -u github.com/projectdiscovery/subfinder/cmd/subfinder
echo "${BLUE} done${RESET}"
echo ""

echo "${BLUE} installing httpx${RESET}"
go get -u github.com/projectdiscovery/httpx/cmd/httpx
echo "${BLUE} done${RESET}"
echo ""

echo "${BLUE} installing shuffledns${RESET}"
go get -u github.com/projectdiscovery/shuffledns/cmd/shuffledns
echo "${BLUE} done${RESET}"
echo ""

echo "${BLUE} installing chaos-client${RESET}"
go get -u github.com/projectdiscovery/chaos-client/cmd/chaos
echo "${BLUE} done${RESET}"
echo ""
sar 1 1 >/dev/null


echo "${GREEN} #### Downloading wordlists #### ${RESET}"
git clone https://github.com/assetnote/commonspeak2-wordlists ~/tools/Wordlists/commonspeak2-wordlists
git clone https://github.com/fuzzdb-project/fuzzdb ~/tools/Wordlists/fuzzdb
git clone https://github.com/1N3/IntruderPayloads ~/tools/Wordlists/IntruderPayloads
git clone https://github.com/swisskyrepo/PayloadsAllTheThings ~/tools/Wordlists/PayloadsAllTheThings
git clone https://github.com/danielmiessler/SecLists ~/tools/Wordlists/SecLists
cd ~/tools/Wordlists/SecLists/Discovery/DNS/
##THIS FILE BREAKS MASSDNS AND NEEDS TO BE CLEANED
cat dns-Jhaddix.txt | head -n -14 > clean-jhaddix-dns.txt
printf "${BLUE} Wordlists downloaded ${RESET}"

sar 1 1 >/dev/null



echo "${GREEN} #### Installing tomnomnom tools #### ${RESET}"
echo "${GREEN}   check out his other tools as well  ${RESET}"

echo "${BLUE} installing meg${RESET}"
go get -u github.com/tomnomnom/meg
echo "${BLUE} done${RESET}"
echo ""

echo "${BLUE} installing assetfinder${RESET}"
go get -u github.com/tomnomnom/assetfinder
echo "${BLUE} done${RESET}"
echo ""

echo "${BLUE} installing waybackurls${RESET}"
go get -u github.com/tomnomnom/waybackurls
echo "${BLUE} done${RESET}"
echo ""

echo "${BLUE} installing gf${RESET}"
go get -u github.com/tomnomnom/gf
echo "${BLUE} done${RESET}"
echo ""

echo "${BLUE} installing httprobe${RESET}"
go get -u github.com/tomnomnom/httprobe
echo "${BLUE} done${RESET}"
echo ""

echo "${BLUE} installing concurl${RESET}"
go get -u github.com/tomnomnom/hacks/concurl
echo "${BLUE} done${RESET}"
echo ""

echo "${BLUE} installing unfurl${RESET}"
go get -u github.com/tomnomnom/unfurl
echo "${BLUE} done${RESET}"
echo ""

echo "${BLUE} installing anti-burl${RESET}"
go get -u github.com/tomnomnom/hacks/anti-burl
echo "${BLUE} done${RESET}"
echo ""

echo "${BLUE} installing filter-resolved${RESET}"
go get github.com/tomnomnom/hacks/filter-resolved
echo "${BLUE} done${RESET}"
echo ""

echo "${BLUE} installing fff${RESET}"
go get -u github.com/tomnomnom/fff
echo "${BLUE} done${RESET}"
echo ""

echo "${BLUE} installing qsreplace${RESET}"
go get -u github.com/tomnomnom/qsreplace
echo "${BLUE} done${RESET}"
echo ""
sar 1 1 >/dev/null

echo "${GREEN} #### Other other Tools #### ${RESET}"

echo "${BLUE} installing arjun${RESET}"
git clone https://github.com/s0md3v/Arjun.git ~/tools/Arjun
echo "${BLUE} done${RESET}"
echo ""

echo "${BLUE} installing cf-check${RESET}"
go get -u github.com/dwisiswant0/cf-check
echo "${BLUE} done${RESET}"
echo ""


echo "${BLUE} installing Urlprobe${RESET}"
go get -u github.com/1ndianl33t/urlprobe
echo "${BLUE} done${RESET}"
echo ""

echo "${BLUE} installing amass${RESET}"
cd ~ && echo -e "Downloading amass version ${AMASS_VERSION} ..." && wget -q https://github.com/OWASP/Amass/releases/download/v${AMASS_VERSION}/amass_linux_amd64.zip && unzip amass_linux_amd64.zip && mv amass_linux_amd64/amass /usr/bin/

cd ~ && rm -rf amass_linux_amd64* amass_linux_amd64.zip*
echo "${BLUE} done${RESET}"
echo ""
unzip -q temp.zip && 


echo "${BLUE} installing impacket${RESET}"
git clone https://github.com/SecureAuthCorp/impacket.git ~/tools/impacket
cd ~/tools/impacket
sudo pip3 install -r requirements.txt
sudo pip3 install .
echo "${BLUE} done${RESET}"
echo ""
sar 1 1 >/dev/null

echo "${GREEN} use the command 'source ~/.bash_profile' for the shell functions to work ${RESET}"
echo ""
echo "${GREEN}  ALL THE TOOLS ARE MADE BY THE BEST PEOPLE OF THE INFOSEC COMMUNITY ${RESET}"
echo ""
echo "${GREEN}                I AM JUST A SCRIPT-KIDDIE ;)                         ${RESET}"
