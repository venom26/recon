#!/bin/bash

sudo apt update
sudo pip3 install colored
sudo apt-get install -y psmisc
sudo apt install  -y host
sudo apt install -y dnsutils
sudo apt-get install -y libcurl4-openssl-dev
sudo apt-get install -y libssl-dev
sudo apt-get install -y jq
sudo apt-get install -y ruby-full
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
pip3 install dnsgen
pip install colored
pip3 install colored
sudo systemctl start snap
echo 'PATH=$PATH:/snap/bin' >> ~/.bashrc

#install rust
echo "Installing rust"
curl https://sh.rustup.rs -sSf | sh
"Done"

#install go
if [[ -z "$GOPATH" ]];then
echo "It looks like go is not installed, would you like to install it now"
PS3="Please select an option : "
choices=("yes" "no")
select choice in "${choices[@]}"; do
        case $choice in
                yes)

                                        echo "Installing Golang"
                                        wget https://dl.google.com/go/go1.13.4.linux-amd64.tar.gz
                                        sudo tar -xvf go1.13.4.linux-amd64.tar.gz
                                        sudo mv go /usr/local
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

#install aquatone
echo "Installing Aquatone"
go get github.com/michenriksen/aquatone
echo "done"

#install assetfinder
echo "Installing Assetfinder"
go get -u github.com/tomnomnom/assetfinder 
echo "done"

#install gau
echo "Installing gau"
go get -u github.com/lc/gau
echo "done"

#inatsll antiburl
echo "Downloading hacks and installing antiburl"
git clone https://github.com/tomnomnom/hacks.git
cd hacks/anti-burl
go build main.go
mv main antiburl
sudo cp antiburl /usr/bin/

#installing kxss
echo "installing kxss"
go get -u github.com/tomnomnom/hacks/kxss
echo "done"

#install hakcheckurl
echo "Installing Hakcheckurl"
go get github.com/hakluke/hakcheckurl

#install hakrevdns
echo "Installing Hakrevdns"
go get github.com/hakluke/hakrevdns

#install ffuf
echo "Installing ffuf"
go get github.com/ffuf/ffuf
echo "done"

#install concurl
echo "Installing Concurl"
go get -u github.com/tomnomnom/concurl

#install subjs
echo "installing subjs"
GO111MODULE=on go get -u -v github.com/lc/subjs

#install chromium
echo "Installing Chromium"
sudo snap install chromium
echo "done"

#install sublime-text
echo "Installing Sublime-Text"
sudo snap install sublime-text --classic
echo "done"

echo "installing Sublist3r"
git clone https://github.com/aboul3la/Sublist3r.git
cd Sublist3r*
pip install -r requirements.txt
sudo python setup.py install
cd ~/tools/
echo "done"

echo "Installing nuclei"
GO111MODULE=on go get -u -v github.com/projectdiscovery/nuclei/cmd/nuclei
git clone https://github.com/projectdiscovery/nuclei-templates.git
echo "done"

echo "installing dirsearch"
git clone https://github.com/maurosoria/dirsearch.git
cd ~/tools/
echo "done"

echo "Installing secretfinder"
git clone https://github.com/m4ll0k/SecretFinder.git
cd ~/tools/
echo "done"

echo "installing virtual host discovery"
git clone https://github.com/jobertabma/virtual-host-discovery.git
cd ~/tools/
echo "done"

#installing meg
echo "Installing meg"
go get -u github.com/tomnomnom/meg
echo "done"

echo "installing findomain"
git clone https://github.com/Edu4rdSHL/findomain.git
cd ~/tools/
echo"done"

echo "installing relative-url-extractor"
git clone https://github.com/jobertabma/relative-url-extractor.git
cd ~/tools/
echo "done"

echo "installing sqlmap"
git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git sqlmap-dev
cd ~/tools/
echo "done"

echo "installing knock.py"
git clone https://github.com/guelfoweb/knock.git
cd knock
sudo python setup.py install
cd ~/tools/
echo "done"

echo "installing lazyrecon"
git clone https://github.com/nahamsec/lazyrecon.git
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

echo "installing Corsy"
git clone https://github.com/s0md3v/Corsy.git
cd Corsy
sudo pip3 install -r requirments.txt
cd ..
echo "DONE"

echo "installing asnlookup"
git clone https://github.com/yassineaboukir/asnlookup.git
cd ~/tools/asnlookup
pip install -r requirements.txt
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

echo "Installing Concurl"
go get -u github.com/tomnomnom/concurl
echo "done"

echo "installing gospider"
go get -u github.com/jaeles-project/gospider
echo "Done"

echo "installing subfinder"
source ~/.bashrc
go get -v github.com/projectdiscovery/subfinder/cmd/subfinder
echo "done"

echo "installing amass"
go get -v -u github.com/OWASP/Amass/v3/...
cd $GOPATH/src/github.com/OWASP/Amass
go install ./...
echo "done"

echo "Creating Wordlist"
cd ~/tools/dirsearch/db/
wget https://raw.githubusercontent.com/assetnote/commonspeak2-wordlists/master/wordswithext/php.txt
wget https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/raft-large-files.txt
wget https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/raft-large-directories.txt
wget https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/spring-boot.txt
cd -

cd ~/tools
wget https://raw.githubusercontent.com/gwen001/github-search/master/github-endpoints.py
wget https://raw.githubusercontent.com/gwen001/github-search/master/github-subdomains.py

echo -e "\n\n\n\n\n\n\n\n\n\n\nDone! All tools are set up in ~/tools"
ls -la
