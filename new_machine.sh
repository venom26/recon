{
  "builders": [],
  "provisioners": [
    {
      "type": "file",
      "source": "./configs",
      "destination":"/tmp/configs"
    },
    {
      "execute_command": "chmod +x {{ .Path }}; {{ .Vars }} sudo -E sh '{{ .Path }}'",
      "inline": [
        "echo 'Waiting for cloud-init to finish, this can take a few minutes please be patient...'",
        "/usr/bin/cloud-init status --wait",

        "fallocate -l 2G /swap && chmod 600 /swap && mkswap /swap && swapon /swap",
        "echo '/swap none swap sw 0 0' | sudo tee -a /etc/fstab",

        "echo 'Running dist-uprade'",
        "sudo apt update -qq",
        "DEBIAN_FRONTEND=noninteractive apt-get -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confnew dist-upgrade -qq",

        "echo 'Installing ufw fail2ban net-tools zsh jq build-essential python3-pip unzip git p7zip libpcap-dev rubygems ruby-dev grc'",
        "sudo apt install fail2ban ufw net-tools zsh zsh-syntax-highlighting zsh-autosuggestions jq build-essential python3-pip unzip git p7zip libpcap-dev rubygems ruby-dev grc zmap -y -qq",
        "ufw allow 22",
        "ufw allow 2266",
        "ufw --force enable",

        "echo 'Creating OP user'",
        "useradd -G sudo -s /usr/bin/zsh -m op",
        "mkdir -p /home/op/.ssh /home/op/c2 /home/op/recon/ /home/op/lists /home/op/go /home/op/bin /home/op/.config/ /home/op/.cache /home/op/work/ /home/op/.config/amass",
        "rm -rf /etc/update-motd.d/*",
        "/bin/su -l op -c 'wget -q https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O - | sh'",
        "chown -R op:users /home/op",
        "touch /home/op/.sudo_as_admin_successful",
        "touch /home/op/.cache/motd.legal-displayed",
        "chown -R op:users /home/op",
        "echo 'op:{{ user `op_random_password` }}' | chpasswd",
        "echo 'ubuntu:{{ user `op_random_password` }}' | chpasswd",
        "echo 'root:{{ user `op_random_password` }}' | chpasswd",

        "echo 'Moving Config files'",
        "mv /tmp/configs/sudoers /etc/sudoers",
        "pkexec chown root:root /etc/sudoers /etc/sudoers.d -R",
        "mv /tmp/configs/bashrc /home/op/.bashrc",
        "mv /tmp/configs/zshrc /home/op/.zshrc",
        "mv /tmp/configs/sshd_config /etc/ssh/sshd_config",
        "mv /tmp/configs/00-header /etc/update-motd.d/00-header",
        "mv /tmp/configs/authorized_keys /home/op/.ssh/authorized_keys",
        "mv /tmp/configs/config.ini /home/op/.config/amass/config.ini",
        "mv /tmp/configs/tmux-splash.sh /home/op/bin/tmux-splash.sh",
        "/bin/su -l op -c 'sudo chmod 600 /home/op/.ssh/authorized_keys'",
        "chown -R op:users /home/op",
        "sudo service sshd restart",
        "chmod +x /etc/update-motd.d/00-header",

        "echo 'Installing Golang 1.20.4'",
        "wget -q https://golang.org/dl/go1.22.1.linux-amd64.tar.gz && tar -C /usr/local -xzf go1.22.1.linux-amd64.tar.gz && rm go1.22.1.linux-amd64.tar.gz",
        "export GOPATH=/home/op/go",

        "echo 'Installing Docker'",
        "curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh && rm get-docker.sh",
        "sudo usermod -aG docker op",

        "echo 'Installing Interlace'",
        "git clone https://github.com/codingo/Interlace.git /home/op/recon/interlace && cd /home/op/recon/interlace/ && python3 setup.py install",

        "echo 'Optimizing SSH Connections'",
        "/bin/su -l root -c 'echo \"ClientAliveInterval 60\" | sudo tee -a /etc/ssh/sshd_config'",
        "/bin/su -l root -c 'echo \"ClientAliveCountMax 60\" | sudo tee -a /etc/ssh/sshd_config'",
        "/bin/su -l root -c 'echo \"MaxSessions 100\" | sudo tee -a /etc/ssh/sshd_config'",
        "/bin/su -l root -c 'echo \"net.ipv4.netfilter.ip_conntrack_max = 1048576\" | sudo tee -a /etc/sysctl.conf'",
        "/bin/su -l root -c 'echo \"net.nf_conntrack_max = 1048576\" | sudo tee -a /etc/sysctl.conf'",
        "/bin/su -l root -c 'echo \"net.core.somaxconn = 1048576\" | sudo tee -a /etc/sysctl.conf'",
        "/bin/su -l root -c 'echo \"net.ipv4.ip_local_port_range = 1024 65535\" | sudo tee -a /etc/sysctl.conf'",
        "/bin/su -l root -c 'echo \"1024 65535\" | sudo tee -a /proc/sys/net/ipv4/ip_local_port_range'",

        "echo 'Installing Tls-Scan'",
        "wget https://github.com/prbinu/tls-scan/releases/download/1.6.0/tls-scan-1.6.0-linux-amd64.tar.gz -O /tmp/tls-scan.tar.gz && sudo tar -C /usr/bin/ -xzf /tmp/tls-scan.tar.gz && rm /tmp/tls-scan.tar.gz",

        "echo 'Downloading Wordlists'",

        "echo 'Downloading axiom-dockerfiles'",
        "git clone https://github.com/0xtavian/minimal-pentesting-dockerfiles.git /home/op/lists/axiom-dockerfiles",

        "echo 'Downloading Nuelei-Templates",
        "git clone https://github.com/projectdiscovery/nuclei-templates.git /home/op/nuclei-templates"

        "echo 'Downloading resolvers'",
        "wget -q -O /home/op/lists/resolvers.txt https://raw.githubusercontent.com/trickest/resolvers/main/resolvers.txt",

        "echo 'Installing anew'",
        "/bin/su -l op -c '/usr/local/go/bin/go install github.com/tomnomnom/anew@latest'",

        "echo 'Installing assetfinder'",
        "/bin/su -l op -c '/usr/local/go/bin/go install github.com/tomnomnom/assetfinder@latest",

        "echo 'Installing axiom'",
        "/bin/su -l op -c 'git clone https://github.com/pry0cc/axiom.git /home/op/.axiom && cd /home/op/.axiom/interact && ./axiom-configure --shell zsh --unattended'",

        "echo 'Installing crt'",
        "/bin/su -l op -c '/usr/local/go/bin/go install github.com/cemulus/crt@latest'",

        "echo 'Installing dnsx'",
        "/bin/su -l op -c '/usr/local/go/bin/go install github.com/projectdiscovery/dnsx/cmd/dnsx@latest'",
        "/bin/su -l op -c '/usr/local/go/bin/go install github.com/glebarez/cero@latest'",
        "/bin/su -l op -c '/usr/local/go/bin/go install github.com/lanrat/certgraph@latest",

        "echo 'Installing fff'",
        "/bin/su -l op -c '/usr/local/go/bin/go install github.com/tomnomnom/fff@latest'",

        "echo 'Installing ffuf'",
        "/bin/su -l op -c '/usr/local/go/bin/go install github.com/ffuf/ffuf@latest'",

        "echo 'Installing findomain-linux'",
        "wget -q -O /tmp/findomain.zip https://github.com/Edu4rdSHL/findomain/releases/latest/download/findomain-linux.zip && unzip /tmp/findomain.zip -d /usr/bin/ && chmod +x /usr/bin/findomain && rm /tmp/findomain.zip",

        "echo 'Installing gau'",
        "/bin/su -l op -c '/usr/local/go/bin/go install github.com/lc/gau/v2/cmd/gau@latest'",

        "echo 'Installing google-chrome'",
        "wget -q -O /tmp/chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && cd /tmp/ && sudo apt install -y /tmp/chrome.deb -qq && apt --fix-broken install -qq",

        "echo 'Installing httprobe'",
        "/bin/su -l op -c '/usr/local/go/bin/go install github.com/tomnomnom/httprobe@latest'",

        "echo 'Installing httpx'",
        "/bin/su -l op -c '/usr/local/go/bin/go install github.com/projectdiscovery/httpx/cmd/httpx@latest'",

        "echo 'Installing interactsh-client'",
        "/bin/su -l op -c '/usr/local/go/bin/go install github.com/projectdiscovery/interactsh/cmd/interactsh-client@latest'",

        "echo 'Installing katana'",
        "/bin/su -l op -c '/usr/local/go/bin/go install github.com/projectdiscovery/katana/cmd/katana@latest'",

        "echo 'Installing kxss'",
        "/bin/su -l op -c '/usr/local/go/bin/go install github.com/tomnomnom/hacks/kxss@latest'",

        "echo 'Installing masscan'",
        "apt install masscan -y -qq",

        "echo 'Installing massdns'",
        "git clone https://github.com/blechschmidt/massdns.git /tmp/massdns; cd /tmp/massdns; make -s; sudo mv bin/massdns /usr/bin/massdns",

        "echo 'Installing nmap'",
        "sudo apt-get -qy --no-install-recommends install build-essential libssl-dev flex bison",
        "/bin/su -l op -c 'wget https://nmap.org/dist/nmap-7.92.tgz -O /home/op/recon/nmap.tar.gz && cd /home/op/recon/ && tar zxf nmap.tar.gz --transform s/nmap-7.92/nmap/ && rm nmap.tar.gz && cd /home/op/recon/nmap/ && sudo ./configure --without-ndiff --without-zenmap --without-nping  --without-ncat --without-nmap-update --with-libpcap=included && sudo make && sudo make install'",

        "echo 'Installing nuclei'",
        "/bin/su -l op -c '/usr/local/go/bin/go install github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest && /home/op/go/bin/nuclei'",

        "echo 'Installing puredns'",
        "/bin/su -l op -c '/usr/local/go/bin/go install github.com/d3mondev/puredns/v2@latest'",

        "echo 'Installing URLDedupe'",
        "/bin/su -l op -c 'git clone https://github.com/ameenmaali/urldedupe.git /home/op/urldedupe && cd /home/op/urldedupe && cmake CMakeLists.txt && make'",  

        "echo 'Installing qsreplace'",
        "/bin/su -l op -c '/usr/local/go/bin/go install github.com/tomnomnom/qsreplace@latest'",

        "echo 'Installing RustScan'",
        "wget -q -O /tmp/rustscan.deb https://github.com/brandonskerritt/RustScan/releases/download/2.0.1/rustscan_2.0.1_amd64.deb && apt install /tmp/rustscan.deb -y -qq",

        "echo 'Installing subjack'",
        "/bin/su -l op -c '/usr/local/go/bin/go install github.com/haccer/subjack@latest'",

        "echo 'Installing subfinder'",
        "/bin/su -l op -c '/usr/local/go/bin/go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest'",

        "echo 'Installing subjs'",
        "/bin/su -l op -c '/usr/local/go/bin/go install -v github.com/lc/subjs@latest'",

        "echo 'Installing testssl'",
        "git clone --depth 1 https://github.com/drwetter/testssl.sh.git /home/op/recon/testssl.sh",

        "echo 'Installing Zgrab2'",
        "git clone https://github.com/zmap/zgrab2.git /home/op/zgrab2 && cd /home/op/zgrab2 && make",

        "echo 'Installing tlsx'",
        "/bin/su -l op -c '/usr/local/go/bin/go install github.com/projectdiscovery/tlsx/cmd/tlsx@latest'",

        "echo 'Installing trufflehog'",
        "/bin/su -l op -c 'docker image build - < /home/op/lists/axiom-dockerfiles/trufflehog/Dockerfile -t axiom/trufflehog'",

        "echo 'Installing waybackurls'",
        "/bin/su -l op -c '/usr/local/go/bin/go install github.com/tomnomnom/waybackurls@latest'",

        "echo 'Removing unneeded Docker images'",
        "/bin/su -l op -c 'docker image prune -f'",

        "/bin/su -l op -c '/usr/local/go/bin/go  clean -modcache'",
        "/bin/su -l op -c 'wget -q -O gf-completion.zsh https://raw.githubusercontent.com/tomnomnom/gf/master/gf-completion.zsh && cat gf-completion.zsh >> /home/op/.zshrc && rm gf-completion.zsh && cd'",
        "/bin/su -l root -c 'apt-get clean'",
        "echo \"The password for user op is: {{ user `op_random_password` }}\"",
        "echo \"CgpDb25ncmF0dWxhdGlvbnMsIHlvdXIgYnVpbGQgaXMgYWxtb3N0IGRvbmUhCgogICAgICAgICAgICAgYXhpb20gaXMgc3BvbnNvcmVkIGJ5Li4uCl9fX18gICAgICAgICAgICAgICAgICAgICAgIF8gXyAgICAgICAgX19fX18uICAgICAgICAgXyBfCi8gX19ffCAgX19fICBfX18gXyAgIF8gXyBfXyhfKSB8XyBfICAgfF8gICBffCBfXyBfXyBfKF8pIHxfX18KXF9fXyBcIC8gXyBcLyBfX3wgfCB8IHwgJ19ffCB8IF9ffCB8IHwgfHwgfHwgJ19fLyBfYCB8IHwgLyBfX3wKIF9fXykgfCAgX18vIChfX3wgfF98IHwgfCAgfCB8IHxffCB8X3wgfHwgfHwgfCB8IChffCB8IHwgXF9fIFwKfF9fX18vIFxfX198XF9fX3xcX18sX3xffCAgfF98XF9ffFxfXywgfHxffHxffCAgXF9fLF98X3xffF9fXy8KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHxfX18vCgpSZWFkIHRoZXNlIHdoaWxlIHlvdSdyZSB3YWl0aW5nIHRvIGdldCBzdGFydGVkIDopCgogICAgLSBRdWlja3N0YXJ0IEd1aWRlOiBodHRwczovL2dpdGh1Yi5jb20vcHJ5MGNjL2F4aW9tL3dpa2kvQS1RdWlja3N0YXJ0LUd1aWRlCiAgICAtIEZpbGVzeXN0ZW0gVXRpbGl0aWVzOiBodHRwczovL2dpdGh1Yi5jb20vcHJ5MGNjL2F4aW9tL3dpa2kvRmlsZXN5c3RlbS1VdGlsaXRpZXMKICAgIC0gRmxlZXRzOiBodHRwczovL2dpdGh1Yi5jb20vcHJ5MGNjL2F4aW9tL3dpa2kvRmxlZXRzICAgICAKICAgIC0gU2NhbnM6IGh0dHBzOi8vZ2l0aHViLmNvbS9wcnkwY2MvYXhpb20vd2lraS9TY2FucwoKCg==\" | base64 -d",
        "touch /home/op/.z",
        "chown -R op:users /home/op",
        "chown root:root /etc/sudoers /etc/sudoers.d -R"
      ], "inline_shebang": "/bin/sh -x",
          "type": "shell"
    }
  ]
}
