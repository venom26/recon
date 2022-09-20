#!/bin/bash

sudo apt update
sudo pip3 install colored
sudo apt-get install -y psmisc
sudo apt install -y grepcidr
sudo apt install -y lynx
sudo apt install -y curl
sudo apt install  -y host
sudo apt install parallel -y
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
pip3 install uro
sudo systemctl start snap
echo 'PATH=$PATH:/snap/bin' >> ~/.bashrc

#install rust
echo "Installing rust"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh 
source $HOME/.cargo/env 
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
                                        version=$(curl -L -s https://golang.org/VERSION?m=text)
                                        wget https://dl.google.com/go/${version}.linux-amd64.tar.gz
                                        sudo tar -xvf go1*
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
cd ~/tools
wget https://github.com/michenriksen/aquatone/releases/download/v1.7.0/aquatone_linux_amd64_1.7.0.zip
unzip aquatone_linux_amd64_1.7.0.zip
sudo mv aquatone /usr/bin/
rm -rf aquatone_linux_amd64_1.7.0.zip README.md LICENSE.txt
echo "done"

echo "Installing Chromium-Browser"
cd ~/tools/
touch findomain_config.yml
touch amass_config.ini
touch .github_tokens
git clone https://github.com/scheib/chromium-latest-linux.git
cd chromium-latest-linux
./update-and-run.sh
cd ~/tools
echo "Done"

#install assetfinder
echo "Installing Assetfinder"
go install -v  github.com/tomnomnom/assetfinder@latest
echo "done"

echo "Installing Deduplicate"
go install -v github.com/nytr0gen/deduplicate@latest
echo "done"

#install gau
echo "Installing gau"
go install github.com/lc/gau/v2/cmd/gau@latest
echo "done"

echo "Installing Blind Xss Fuzzer"
cd ~/tools/
git clone https://github.com/venom26/Blind-xss-via-ffuf.git
echo "Done"

echo "Installing Sprawl"
cd ~/tools
git clone https://github.com/venom26/sprawl.git
echo "Done"

#inatsll antiburl
echo "Downloading Tomnomnom Tools"
go install -v github.com/tomnomnom/hacks/anti-burl@latest
go install -v github.com/tomnomnom/hacks/qsreplace@latest
go install -v github.com/tomnomnom/hacks/unfurl@latest
go install -v github.com/tomnomnom/hacks/tok@latest
go install -v github.com/tomnomnom/hacks/htmlattribs@latest
go install -v github.com/tomnomnom/hacks/get-title@latest
go install -v github.com/tomnomnom/hacks/kxss@latest
go install -v github.com/tomnomnom/hacks/comb@latest
go install -v github.com/takshal/freq@latest  
go install -v github.com/s0md3v/smap/cmd/smap@latest
go install -v github.com/hakluke/hakfindinternaldomains@latest
cd ~/tools/

echo "Installing CertGraph"
go install -v github.com/lanrat/certgraph@latest
echo "Done"

#install hakcheckurl
echo "Installing Hakcheckurl"
go install github.com/hakluke/hakcheckurl@latest

echo "Installing SourceMapper"
go install github.com/denandz/sourcemapper@latest
echo "done"

echo "Getting M4ll0k tools"
cd ~/tools
mkdir m4ll0k
cd m4ll0k
wget https://raw.githubusercontent.com/m4ll0k/BBTz/master/gctexposer.py
wget https://raw.githubusercontent.com/m4ll0k/BBTz/master/awsgen.py
wget https://raw.githubusercontent.com/m4ll0k/BBTz/master/awsgen.sh
wget https://raw.githubusercontent.com/m4ll0k/BBTz/master/collector.py
wget https://raw.githubusercontent.com/m4ll0k/BBTz/master/getsrc.py
wget https://gist.githubusercontent.com/m4ll0k/2df369418798717d12bef7f42138fb78/raw/24a10879c7f8eb98f50328d3094eaf83212cc166/chaos.py
wget https://gist.githubusercontent.com/m4ll0k/7174f3ab09ab2f1ba934e2e779d901b4/raw/5b47a568075e8e18187128088caefa9c5ea099bb/getpoint.py
wget https://raw.githubusercontent.com/venom26/recon/master/replace.sh
sudo chmod +x awsgen.sh
sudo chmod +x replace.sh
cd ~/tools
echo "Done"

#install hakrevdns
echo "Installing Hakrevdns"
go install -v github.com/hakluke/hakrevdns@latest
go install -v github.com/tomnomnom/fff@latest
go install -v github.com/dwisiswant0/slackcat@latest
#install ffuf
echo "Installing ffuf"
go install -v github.com/ffuf/ffuf@latest
echo "done"
#install gf

echo "Installing gf"
go install -v github.com/tomnomnom/gf@latest
cd ~/tools/
git clone https://github.com/tomnomnom/gf.git
cp -r gf/examples/ ~/.gf
echo 'source ~/tools/gf/gf-completion.bash' >> ~/.bashrc
cp -r $GOPATH/src/github.com/tomnomnom/gf/examples ~/.gf

echo "Installing S3Prefix"
go install github.com/meispi/s3prefix@latest
mkdir ~/.config/
curl https://raw.githubusercontent.com/meispi/s3prefix/main/common_bucket_prefixes.txt -o ~/.config/common_bucket_prefixes.txt
echo "Done"

echo "Installing X8"
wget https://github.com/Sh1Yo/x8/releases/download/v3.2.1/x8_linux.tar.gz
tar -xvf x8_linux.tar.gz
rm x8_linux.tar.gz
mv x8 /usr/bin/

echo "Installing WebAnalyzer"
go install -v github.com/rverton/webanalyze/cmd/webanalyze@latest
cd ~/tools
webanalyze -update
echo "Done"

echo "Installing Interlace"
cd ~/tools
git clone https://github.com/codingo/Interlace.git
cd Interlace
python3 setup.py install
cd ~/tools
echo "Done"

echo "Installing Commonspeak"
cd ~/tools/
git clone https://github.com/assetnote/commonspeak2-wordlists.git
wget https://raw.githubusercontent.com/venom26/recon/master/commonspeak.py -O ~/tools/commonspeak2-wordlists/subdomains/commonspeak.py

echo "Installing Rustscan"
cd ~/tools
git clone https://github.com/RustScan/RustScan.git
cd RustScan
source ~/.bashrc
cargo build --release
sudo cp target/release/rustscan /usr/bin/
cd ~/tools
rm -rf RustScan
echo "Done"

#install httpx
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
echo "Done"

echo "Installing sdlookup"
go install github.com/j3ssie/sdlookup@latest
go install github.com/j3ssie/cdnstrip@latest
echo "Done"

echo "Installing DNSX"
go install -v github.com/projectdiscovery/dnsx/cmd/dnsx@latest
go install github.com/projectdiscovery/tlsx/cmd/tlsx@latest
go install -v github.com/projectdiscovery/interactsh/cmd/interactsh-client@latest
echo "Done"

#install concurl
echo "Installing Concurl"
go install -v github.com/tomnomnom/concurl@latest

echo "Installing Nuclei-Templates"
cd ~/tools
git clone https://github.com/projectdiscovery/nuclei-templates.git
echo "Done"

#echo "Installing EyeWitness"
#cd ~/tools
#git clone https://github.com/FortyNorthSecurity/EyeWitness.git
#cd EyeWitness/Python/setup
#sudo chmod +x setup.sh
#./setup.sh
#cd ~/tools
#echo "Done"

echo "#####Installng Chaos#####"
go install -v github.com/projectdiscovery/chaos-client/cmd/chaos@latest

#install concurl
echo "Installing Puredns"
go install -v github.com/d3mondev/puredns/v2@latest

echo "Installing Gotator"
go install -v github.com/Josue87/gotator@latest

echo "Installing Github-Subdomains"
go install -v github.com/gwen001/github-subdomains@latest
go install -v github.com/gwen001/github-endpoints@latest
echo "Done"

echo "Installing Paramspider"
git clone https://github.com/devanshbatham/ParamSpider
cd ParamSpider
pip3 install -r requirements.txt

echo "Installing roboextractor"
go install -v github.com/Josue87/roboxtractor@latest
echo "Done"

echo "Installing 403 bypasser"
cd ~/tools
git clone https://github.com/Dheerajmadhukar/4-ZERO-3.git
cd 4-ZERO-3/
sudo chmod +x 403-bypass.sh
cd ~/tools

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
go install -v github.com/lc/subjs@latest

echo "installing Sublist3r"
git clone https://github.com/aboul3la/Sublist3r.git
cd Sublist3r*
curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py
sudo python2 get-pip.py
pip install -r requirements.txt
sudo python setup.py install
cd ~/tools/
echo "done"

echo "Installing xnLinkFinder"
cd ~/tools/
git clone https://github.com/xnl-h4ck3r/xnLinkFinder.git
cd ~/tools/xnLinkFinder/
python3 setup.py install
echo "Done"

echo "Installing grapX"
git clone https://github.com/kabilan1290/grapX.git
cd grapX
sudo chmod +x grapX
sudo cp grapX /usr/bin/grapX
cd ~/tools/
echo "Done"

echo "Installing nuclei"
cd ~/tools/
go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest
echo "done"

echo "installing dirsearch"
cd ~/tools/
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
cd ~/tools/SecretFinder/
pip3 install -r requirements.txt
cd ~/tools/
echo "done"

echo "Installing Crobat"
go install -v github.com/cgboal/sonarsearch/cmd/crobat@latest
echo "Done"

echo "Installing Gf-Templates"
git clone https://github.com/1ndianl33t/Gf-Patterns.git
cd Gf-Patterns/
cp *.json ~/.gf
cd ~/tools/
echo"Done"

echo "Installing arjun"
https://github.com/edduu/Arjun.git
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
go install -v github.com/tomnomnom/meg@latest
echo "done"

echo "installing findomain"
cd ~/tools/
wget https://github.com/Edu4rdSHL/findomain/releases/latest/download/findomain-linux
chmod +x findomain-linux
mv findomain-linux findomain
sudo cp findomain /usr/bin/
cd ~/tools/
echo "done"

echo "installing sqlmap"
sudo apt install sqlmap -y
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

echo "installing httprobe"
go install -v github.com/tomnomnom/httprobe@latest
echo "done"

echo "installing waybackurls"
go install -v github.com/tomnomnom/waybackurls@latest
echo "done"

echo "Installing anew"
go install -v github.com/tomnomnom/anew@latest
echo "Done"

echo "Installing Concurl"
go install -v github.com/tomnomnom/concurl@latest
echo "done"

echo "Installing altdns"
cd ~/tools/
wget https://raw.githubusercontent.com/m4ll0k/Bug-Bounty-Toolz/master/altdns.py
git clone https://github.com/infosec-au/altdns.git
echo "done"

echo "installing gospider"
go install -v github.com/jaeles-project/gospider@latest
echo "Done"

echo "installing subfinder"
source ~/.bashrc
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
echo "done"

echo "installing amass"
cd ~/tools/
git clone https://github.com/OWASP/Amass.git
cd Amass
go install -v github.com/OWASP/Amass/v3/...@master
cd ~/tools/
echo "done"

echo "Creating Wordlist"
cd ~/tools/dirsearch/db/
#wget https://github.com/xyele/hackerone_wordlist/releases/download/beta/wordlists.zip
#https://gist.githubusercontent.com/tomnomnom/57af04c3422aac8c6f04451a4c1daa51/raw/9f551e023ff17d093dcb9f8b355c3af55827cb34/short-wordlist.txt -O shortwords.txt
#unzip wordlists.zip
cp ~/tools/recon/ffuf_extension.txt .
#wget https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/DNS/deepmagic.com-prefixes-top50000.txt
#wget https://github.com/six2dez/OneListForAll/releases/download/v2.3/onelistforall.txt
wget https://raw.githubusercontent.com/venom26/recon/master/params.txt
#wget https://raw.githubusercontent.com/assetnote/commonspeak2-wordlists/master/wordswithext/php.txt
wget https://raw.githubusercontent.com/danielmiessler/SecLists/c196a6e62d0b63d6be0c84e6fa224352ea5949df/Discovery/Web-Content/SVNDigger/cat/Language/js.txt
wget https://raw.githubusercontent.com/r3s-ryan/R3S-CTF/a2733be0b3fdc553930493ae164256e3a30f40aa/SecLists/Discovery/Web-Content/quickhits.txt
wget https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/raft-large-files.txt
wget https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/raft-large-directories.txt
wget https://raw.githubusercontent.com/codingo/VHostScan/master/VHostScan/wordlists/virtual-host-scanning.txt
wget https://raw.githubusercontent.com/venom26/recon/master/venom_all.txt -O all.txt
wget https://raw.githubusercontent.com/ayoubfathi/leaky-paths/main/leaky-paths.txt
cp ~/tools/recon/apiwords.txt .
cd -
cd /usr/share/nmap/scripts/
sudo wget https://raw.githubusercontent.com/vulnersCom/nmap-vulners/master/vulners.nse

cd ~/tools
wget https://wordlists-cdn.assetnote.io/data/manual/best-dns-wordlist.txt
wget https://gist.githubusercontent.com/venom26/d61ae198dbfc12c5d2e16f1f9132a4ac/raw/b5510afa66df460512e9a946acba9d9dc5acdb28/getdirs.py
wget -O permutations_list.txt https://gist.github.com/six2dez/ffc2b14d283e8f8eff6ac83e20a3c4b4/raw
wget -N -c https://github.com/codingo/DNSCewl/raw/master/DNScewl
mv DNScewl /usr/bin/DNScewl
wget https://raw.githubusercontent.com/m4ll0k/Bug-Bounty-Toolz/master/getjswords.py
wget -O subdomains.txt https://gist.github.com/six2dez/a307a04a222fab5a57466c51e1569acf/raw
wget https://gist.githubusercontent.com/jhaddix/86a06c5dc309d08580a018c66354a056/raw/96f4e51d96b2203f19f6381c8c545b278eaa0837/all.txt
mv all.txt jhaddix_all.txt
wget https://raw.githubusercontent.com/BonJarber/fresh-resolvers/main/resolvers.txt -O resolvers.txt
echo -e "${LIGHT_YELLOW}Setting ulimit to 100000 ${LIGHT_GREEN}( so as to make ffuf work fine with higher number of threads ) ${NORMAL}"
echo "ulimit -n 100000" >> ~/.bashrc
source ~/.bashrc
source $HOME/.cargo/env
echo -e "\n\n\n\n\n\n\n\n\n\n\nDone! All tools are set up in ~/tools"
ls -la
