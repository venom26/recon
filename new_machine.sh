#!/bin/bash

sudo apt update
sudo pip3 install colored
sudo apt-get install -y psmisc
sudo apt install -y grepcidr
sudo apt install -y curl
sudo apt install  -y host
sudo apt install -y dnsutils
sudo apt-get install -y libcurl4-openssl-dev
sudo apt-get install -y libssl-dev
sudo apt-get install -y jq
sudo apt-get install libgdbm-dev libncurses5-dev automake libtool bison libffi-dev -y
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm
rvm install 2.7.1
rvm use 2.7.1 --default
ruby -v
sudo apt-get install -y libcurl4-openssl-dev libxml2 libxml2-dev libxslt1-dev ruby-dev build-essential libgmp-dev zlib1g-dev
sudo apt-get install -y build-essential libssl-dev libffi-dev python-dev
sudo apt-get install -y python-setuptools
sudo apt-get install -y libldns-dev
sudo apt-get install -y python3-pip
sudo apt-get install -y python-pip
sudo apt-get install -y python-dnspython
sudo apt-get install -y git
sudo apt-get install -y rename
sudo apt-get install -y xargs
sudo apt-get install -y snapd
sudo apt-get install gem -y
sudo gem install wpscan
gem install wpscan
pip3 install dnsgen
pip install colored
pip3 install colored
sudo systemctl start snap
echo 'PATH=$PATH:/snap/bin' >> ~/.bashrc

#install rust
echo "Installing rust"
curl https://sh.rustup.rs -sSf | sh
echo "Done"


#install go
if [[ -z "$GOPATH" ]];then
echo "It looks like go is not installed, would you like to install it now"
PS3="Please select an option : "
choices=("yes" "no")
select choice in "${choices[@]}"; do
        case $choice in
                yes)

                                        echo "Installing Golang"
                                        wget https://golang.org/dl/go1.16.2.linux-amd64.tar.gz
                                        sudo tar -xvf go1.16.2.linux-amd64.tar.gz
                                        sudo mv go /usr/local/
                                        export GOROOT=/usr/local/go
                                        export GOPATH=$HOME/go
                                        export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
                                        echo 'export GOROOT=/usr/local/go' >> ~/.bashrc
                                        echo 'export GOPATH=$HOME/go'   >> ~/.bashrc
                                        echo 'export PATH=$GOPATH/bin:$GOROOT/bin:$PATH' >> ~/.bashrc
                                        source ~/.bashrc
                                        sleep 1
                                        break
                                        ;;
                                no)
                                        echo "Please install go and rerun this script"
                                        echo "Aborting installation..."
                                        exit 1
                                        ;;
        esac
done
fi



#create a tools folder in ~/
mkdir ~/tools
cd ~/tools/
pip install py-altdns
#install aquatone
echo "Installing Aquatone"
go get github.com/michenriksen/aquatone
echo "done"

echo "Installing Chromium-Browser"
sudo apt install chromium-browser -y
echo "Done"

#install assetfinder
echo "Installing Assetfinder"
go get -u github.com/tomnomnom/assetfinder 
echo "done"

#install gau
echo "Installing gauplus"
GO111MODULE=on go get -u -v github.com/bp0lr/gauplus
echo "done"

#inatsll antiburl
echo "Downloading hacks and installing antiburl"
git clone https://github.com/tomnomnom/hacks.git
cd hacks/anti-burl
go build main.go
mv main antiburl
sudo cp antiburl /usr/bin/
cd ..
cd unfurl/
go build main.go
mv main unfurl
sudo cp unfurl /usr/bin/
cd ..
cd tok/
go build main.go
mv main tok
sudo cp tok /usr/bin/
cd ..
cd ~/tools/

#installing kxss
echo "installing kxss"
go get -u github.com/tomnomnom/hacks/kxss
GO111MODULE=on go get -v github.com/hahwul/dalfox/v2
echo "done"

#install hakcheckurl
echo "Installing Hakcheckurl"
go get github.com/hakluke/hakcheckurl

#install hakrevdns
echo "Installing Hakrevdns"
go get github.com/hakluke/hakrevdns
go get -u github.com/tomnomnom/fff
#install ffuf
echo "Installing ffuf"
go get github.com/ffuf/ffuf
echo "done"
#install gf
echo "Installing gf"
go get -u github.com/tomnomnom/gf
echo 'source $GOPATH/src/github.com/tomnomnom/gf/gf-completion.bash' >> ~/.bashrc
cp -r $GOPATH/src/github.com/tomnomnom/gf/examples ~/.gf

echo "Installing Commonspeak"
cd ~/tools/
git clone https://github.com/assetnote/commonspeak2-wordlists.git
wget https://raw.githubusercontent.com/venom26/recon/master/commonspeak.py -O ~/tools/commonspeak2-wordlists/subdomains/commonspeak.py

#install httpx
GO111MODULE=on go get -u -v github.com/projectdiscovery/httpx/cmd/httpx
echo "Done"

echo "Installing DNSX"
GO111MODULE=on go get -v github.com/projectdiscovery/dnsx/cmd/dnsx
echo "Done"

#install concurl
echo "Installing Concurl"
go get -u github.com/tomnomnom/concurl

echo "Installing Github-Subdomains"
go get -u github.com/gwen001/github-subdomains
echo "Done"

echo "Installing Firece"
cd ~/tools/
git clone https://github.com/mschwager/fierce.git
cd fierce
python3 -m pip install -r requirements.txt
cd ~/tools
echo "Done"

echo "Installing Bypass403"
git clone https://github.com/lobuhi/byp4xx.git
cd ~/tools
echo "Done"

#install subjs
echo "installing subjs"
GO111MODULE=on go get -u -v github.com/lc/subjs

#install chromium
echo "Installing Chromium"
sudo snap install chromium
echo "done"

echo "installing Sublist3r"
git clone https://github.com/aboul3la/Sublist3r.git
cd Sublist3r*
curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py
sudo python2 get-pip.py
pip install -r requirements.txt
sudo python setup.py install
cd ~/tools/
echo "done"

echo "Installing JSA"
cd ~/tools/
git clone https://github.com/w9w/JSA.git
cd ~/tools/
echo "Done"

echo "Installing grapX"
git clone https://github.com/kabilan1290/grapX.git
cd grapX
sudo chmod +x grapX
sudo cp grapX /usr/bin/grapX
cd ~/tools/
echo "Done"

echo "Installing Telegram-Bot-Cli"
git clone https://github.com/ShutdownRepo/telegram-bot-cli.git
cd ~/tools/
echo "Done"

echo "installing subdomain-takeover detection tool"
go get github.com/haccer/subjack
echo "done"
cd ~/tools/

echo "Installing nuclei"
GO111MODULE=on go get -u -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei
git clone https://github.com/projectdiscovery/nuclei-templates.git
echo "done"

echo "Installing httpx"
GO111MODULE=on go get -v github.com/projectdiscovery/httpx/cmd/httpx
echo "done"

echo "installing dirsearch"
git clone https://github.com/maurosoria/dirsearch.git
cd ~/tools/
echo "done"

echo "Installing Masscan"
sudo apt-get install git gcc make libpcap-dev -y
git clone https://github.com/robertdavidgraham/masscan
cd masscan/
make
cd ~/tools/
echo "Done"

echo "Installing secretfinder"
git clone https://github.com/m4ll0k/SecretFinder.git
cd ~/tools/
echo "done"

echo "Installing Crobat"
go get -u github.com/cgboal/sonarsearch/crobat
echo "Done"

echo "Installing Gf-Templates"
git clone https://github.com/1ndianl33t/Gf-Patterns.git
cd Gf-Patterns/
cp *.json ~/.gf
cd ~/tools/
echo"Done"

echo "Installing arjun"
git clone https://github.com/s0md3v/Arjun.git
echo "Done"
cd ~/tools/

echo "installing crtfinder"
git clone https://github.com/venom26/crtfinder.git
cd ~/tools/crtfinder/
pip install -r requirments.txt

cd ~/tools/
echo "done"

echo "installing Linkfinder"
git clone https://github.com/GerbenJavado/LinkFinder.git
cd LinkFinder
pip3 install -r requirements.txt
cd ~/tools/

#installing meg
echo "Installing meg"
go get -u github.com/tomnomnom/meg
echo "done"

echo "Installing Dnsprobe"
GO111MODULE=on go get -u -v github.com/projectdiscovery/dnsprobe
echo "Done"

#installing shuffledns
echo "Installing Shuffledns"
GO111MODULE=on go get -v github.com/projectdiscovery/shuffledns/cmd/shuffledns
echo "Done"

echo "installing findomain"
cd ~/tools/
wget https://github.com/Edu4rdSHL/findomain/releases/latest/download/findomain-linux
chmod +x findomain-linux
mv findomain-linux findomain
sudo cp findomain /usr/bin/
cd ~/tools/
echo "done"

echo "installing relative-url-extractor"
git clone https://github.com/jobertabma/relative-url-extractor.git
cd ~/tools/
echo "done"

echo "installing sqlmap"
sudo apt install sqlmap -y
echo "done"

echo "installing knock.py"
git clone https://github.com/guelfoweb/knock.git
cd knock
sudo python setup.py install
cd ~/tools/
echo "done"

echo "installing nmap"
sudo apt-get install -y nmap
echo "done"

echo "installing your scripts"
git clone https://github.com/venom26/recon.git
echo "done"

echo "installing massdns"
git clone https://github.com/blechschmidt/massdns.git
cd ~/tools/massdns
make
cd ~/tools/
echo "done"

cd ~/tools
echo "Getting smuggler.py"
wget https://raw.githubusercontent.com/gwen001/pentest-tools/master/smuggler.py
echo "Done"

echo "installing httprobe"
go get -u github.com/tomnomnom/httprobe 
echo "done"

echo "installing unfurl"
go get -u github.com/tomnomnom/unfurl 
echo "done"

echo "installing waybackurls"
go get github.com/tomnomnom/waybackurls
echo "done"

echo "installing crtndstry"
git clone https://github.com/nahamsec/crtndstry.git
echo "done"

echo "Installing anew"
go get -u github.com/tomnomnom/anew
echo "Done"

echo "Installing Concurl"
go get -u github.com/tomnomnom/concurl
echo "done"

echo "Installing altdns"
cd ~/tools/
wget https://raw.githubusercontent.com/m4ll0k/Bug-Bounty-Toolz/master/altdns.py
git clone https://github.com/infosec-au/altdns.git
echo "done"

echo "installing gospider"
go get -u github.com/jaeles-project/gospider
echo "Done"

echo "installing subfinder"
source ~/.bashrc
GO111MODULE=on go get -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder
echo "done"

echo "installing amass"
cd ~/tools/
git clone https://github.com/OWASP/Amass.git
cd Amass
go get -v github.com/OWASP/Amass/v3/...
cd ~/tools/
echo "done"

echo "Creating Wordlist"
cd ~/tools/dirsearch/db/
wget https://github.com/xyele/hackerone_wordlist/releases/download/beta/wordlists.zip
https://gist.githubusercontent.com/tomnomnom/57af04c3422aac8c6f04451a4c1daa51/raw/9f551e023ff17d093dcb9f8b355c3af55827cb34/short-wordlist.txt -O shortwords.txt
unzip wordlists.zip
cp ~/tools/dirsearch/db/apiwords.txt .
cp ~/tools/recon/ffuf_extension.txt .
wget https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/DNS/deepmagic.com-prefixes-top50000.txt
wget https://raw.githubusercontent.com/assetnote/commonspeak2-wordlists/master/wordswithext/php.txt
wget https://raw.githubusercontent.com/danielmiessler/SecLists/c196a6e62d0b63d6be0c84e6fa224352ea5949df/Discovery/Web-Content/SVNDigger/cat/Language/js.txt
wget https://raw.githubusercontent.com/r3s-ryan/R3S-CTF/a2733be0b3fdc553930493ae164256e3a30f40aa/SecLists/Discovery/Web-Content/quickhits.txt
wget https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/raft-large-files.txt
wget https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/raft-large-directories.txt
wget https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/spring-boot.txt
wget https://raw.githubusercontent.com/milo2012/pathbrute/master/defaultPaths.txt
wget https://raw.githubusercontent.com/milo2012/pathbrute/master/cvePaths.txt
wget https://gist.githubusercontent.com/jhaddix/b80ea67d85c13206125806f0828f4d10/raw/c81a34fe84731430741e0463eb6076129c20c4c0/content_discovery_all.txt -O all.txt
cp ~/tools/recon/apiwords.txt .
cd -
cd /usr/share/nmap/scripts/
sudo wget https://raw.githubusercontent.com/vulnersCom/nmap-vulners/master/vulners.nse

cd ~/tools
wget https://raw.githubusercontent.com/m4ll0k/Bug-Bounty-Toolz/master/getjswords.py
wget https://raw.githubusercontent.com/maverickNerd/naabu/master/scripts/naabu2nmap.sh
wget https://raw.githubusercontent.com/gwen001/github-search/master/github-endpoints.py
wget https://raw.githubusercontent.com/gwen001/github-search/master/github-subdomains.py
wget https://raw.githubusercontent.com/assetnote/commonspeak2-wordlists/master/subdomains/subdomains.txt
wget https://gist.githubusercontent.com/jhaddix/86a06c5dc309d08580a018c66354a056/raw/96f4e51d96b2203f19f6381c8c545b278eaa0837/all.txt
mv all.txt jhaddix_all.txt
wget https://raw.githubusercontent.com/BBerastegui/fresh-dns-servers/master/resolvers.txt -O resolvers.txt
echo -e "${LIGHT_YELLOW}Setting ulimit to 100000 ${LIGHT_GREEN}( so as to make ffuf work fine with higher number of threads ) ${NORMAL}"
echo "ulimit -n 100000" >> ~/.bashrc
source ~/.bashrc
source $HOME/.cargo/env
echo -e "\n\n\n\n\n\n\n\n\n\n\nDone! All tools are set up in ~/tools"
ls -la
